extends Area2D

func pickup():
	call_deferred("queue_free")


func _on_LifeTimer_timeout():
	call_deferred("queue_free")
