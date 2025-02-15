extends Label

var money = 1


func update_money():
	money *= 2
	text = str(money) + "$"
