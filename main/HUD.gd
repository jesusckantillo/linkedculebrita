extends Control

func update_timer(new_val):
	$MarginContainer/LabelTimer.text = str(new_val)
	
func update_score(new_val):
	$MarginContainer/LabelScore.text = str(new_val)
	
func update_level(new_val):
	$MarginContainer2/LabelLevel.text = str(new_val)
