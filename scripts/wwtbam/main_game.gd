extends Node2D
var questions = 0
var answers_arr
var correct_answer

func _ready() -> void:
	questions = load_questions("res://questions/questions.txt")
	change_question(questions)

func load_questions(file_path: String) -> Array:
	var questions_array = []  
	var file = FileAccess.open(file_path, FileAccess.READ)
	if not file:
		print("Failed to open file: ", file_path)
		return []
	var file_content = file.get_as_text()
	file.close()
	var lines = file_content.split("\n", false)  # "false" to skip empty lines
	for i in range(0, lines.size(), 6):
		if i + 5 >= lines.size():
			break 
		var question_data = [
			lines[i].strip_edges(),      # Difficulty
			lines[i + 1].strip_edges(),  # Question
			lines[i + 2].strip_edges(),  # Correct answer
			lines[i + 3].strip_edges(),  # Wrong answer 1
			lines[i + 4].strip_edges(),  # Wrong answer 2
			lines[i + 5].strip_edges()   # Wrong answer 3
		]
		questions_array.append(question_data)
	return questions_array


func change_question(questions):
	if questions:
		var q = questions.pick_random()
		get_node("Question/Question label").text = q[1]
		answers_arr = [q[2], q[3], q[4], q[5]]
		randomize()
		answers_arr.shuffle()
		correct_answer = answers_arr.find(q[2])
		get_node("Answers/option1/Label").text = answers_arr[0]
		get_node("Answers/option2/Label").text = answers_arr[1]
		get_node("Answers/option3/Label").text = answers_arr[2]
		get_node("Answers/option4/Label").text = answers_arr[3]
		get_node('Answers/White').position = Vector2(0, -10000)
	else:
		return


func _on_option_1_button_up() -> void:
	get_node('AnimationPlayer').play('option1choice')
	get_node('Answers/White').z_index = 1
	get_node('Answers/White').position = Vector2(291.5, 589)
	disable_buttons()
	await get_tree().create_timer(2.0).timeout
	is_answer_right(0)


func _on_option_2_button_up() -> void:
	get_node('AnimationPlayer').play('option1choice')
	get_node('Answers/White').z_index = 1
	get_node('Answers/White').position = Vector2(868, 589)
	disable_buttons()
	await get_tree().create_timer(2.0).timeout
	is_answer_right(1)


func _on_option_3_button_up() -> void:
	get_node('AnimationPlayer').play('option1choice')
	get_node('Answers/White').z_index = 1
	get_node('Answers/White').position = Vector2(291.5, 499)
	disable_buttons()
	await get_tree().create_timer(2.0).timeout
	is_answer_right(2)


func _on_option_4_button_up() -> void:
	get_node('AnimationPlayer').play('option1choice')
	get_node('Answers/White').z_index = 1
	get_node('Answers/White').position = Vector2(868, 499)
	disable_buttons()
	await get_tree().create_timer(2.0).timeout
	is_answer_right(3)


func is_answer_right(option_id):
	if option_id == correct_answer:
		pass
		get_node('Answers/White').self_modulate = '#0aff00a2'
		get_node('sounds/right').playing = true
		await get_tree().create_timer(1.5).timeout
		get_node('Money/amount').update_money()
		change_question(questions)
		reset()
	else:
		get_node('Answers/White').self_modulate = '#AF1B3Fa2'
		get_node('sounds/wrong').playing = true
		await get_tree().create_timer(1.5).timeout
	reset()

func reset():
	get_node('Answers/White').position = Vector2(0, -10000)
	get_node('sounds/background sound').playing = true
	enable_buttons()


func disable_buttons():
		get_node("Answers/option1").disabled = true
		get_node("Answers/option2").disabled = true
		get_node("Answers/option3").disabled = true
		get_node("Answers/option4").disabled = true

func enable_buttons():
		get_node("Answers/option1").disabled = false
		get_node("Answers/option2").disabled = false
		get_node("Answers/option3").disabled = false
		get_node("Answers/option4").disabled = false
