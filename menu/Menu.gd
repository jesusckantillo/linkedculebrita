extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	OS.center_window()


func _on_StartButton_pressed():
	get_tree().change_scene('res://main/Main.tscn')
