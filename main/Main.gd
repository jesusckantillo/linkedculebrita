extends Node2D

# signals
const BASIC_LEVEL = 5
export (PackedScene) var Gem
var Cherry = preload("res://gem/Cherry.tscn")
var Question = preload("res://menu/Question.tscn")

var level = 0
var screensize = Vector2.ZERO

onready var GameOverTimer = Timer.new()

var current_question = null
func _ready():
	randomize()
	OS.center_window()
	timer_setting()
	$HUD/GameOverLabel.visible = false
	$HUD/MarginContainer2/LabelLevel.visible = true
	Singleton.left_time = 15
	$HUD.update_timer(Singleton.left_time)
	screensize = get_viewport().get_visible_rect().size
	Question.connect("question_answered",self,"_on_question_answered")
	spawn_gems()
	set_cherry_time()


func _on_question_answered(answered_correctly):
	if answered_correctly:
		print("Respuesta correcta")
	else:
		print("Respuesta incorrecta")

func timer_setting():
	GameOverTimer.wait_time = 2
	GameOverTimer.connect('timeout', self, '_onGameOverTimer_timeout')
	add_child(GameOverTimer)


func _onGameOverTimer_timeout():
	get_tree().change_scene("res://menu/Menu.tscn")


func set_cherry_time():
	var interval = rand_range(5, 10)
	$CherryTimer.wait_time = interval
	$CherryTimer.start()


func _process(delta):
	if $GemContainer.get_child_count() == 0:
		level += 1
		$HUD.update_level(level)
		spawn_gems()


func spawn_gems():
	for index in range(BASIC_LEVEL + level):
		var Gema = Gem.instance()	
		Gema.position = \
		Vector2(rand_range(0, screensize.x), 
			rand_range(40, 480))
		$GemContainer.add_child(Gema)


func _on_GameTimer_timeout():
	Singleton.left_time -= 1
	$HUD.update_timer(Singleton.left_time)
	if Singleton.left_time <= 0:
		game_over()


func _on_Player_picked(type):
	match type:
		'gem':
			Singleton.score += 1
			$HUD.update_score(Singleton.score)
		'cherry':
			get_tree().paused = true
			var question_scene = Question.instance()
			add_child(question_scene)
			$HUD.update_score(Singleton.left_time)


func game_over():
	$GameTimer.stop()
	$HUD/MarginContainer2/LabelLevel.visible = false
	$HUD/GameOverLabel.visible = true
	$Player.game_over()
	GameOverTimer.start()


func _on_CherryTimer_timeout():
	$CherryTimer.stop()
	var cherry = Cherry.instance()
	cherry.position.x = rand_range(25,660)
	cherry.position.y = rand_range(25,500)
	$GemContainer.add_child(cherry)
	set_cherry_time()
