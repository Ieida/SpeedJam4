extends HBoxContainer
class_name Entry

var username: String
var score: String

func _ready():
	$Username.text = username
	$Score.text = score
