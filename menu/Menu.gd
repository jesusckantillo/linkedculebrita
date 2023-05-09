extends Control


func _ready():
	OS.center_window()
	print(Singleton.left_time)

func _on_StartButton_pressed():
	get_tree().change_scene('res://main/Main.tscn')
