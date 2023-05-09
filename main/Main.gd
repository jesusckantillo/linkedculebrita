extends Node2D

# signals
const BASIC_LEVEL = 5
export (PackedScene) var Gem
var Cherry = preload("res://gem/Cherry.tscn")
var Question = preload("res://menu/Question.tscn")

var level = 0
var screensize = Vector2.ZERO
var time_left = 0
var score = 0
onready var GameOverTimer = Timer.new()

var current_question = null
func _ready():
	randomize()
	OS.center_window()
	timer_setting()
	$HUD/GameOverLabel.visible = false
	$HUD/MarginContainer2/LabelLevel.visible = true
	time_left = 15
	$HUD.update_timer(time_left)
	screensize = get_viewport().get_visible_rect().size
	spawn_gems()
	set_cherry_time()


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
	time_left -= 1
	$HUD.update_timer(time_left)
	if time_left <= 0:
		game_over()


func _on_Player_picked(type):
	match type:
		'gem':
			score += 1
			$HUD.update_score(score)
		'cherry':
			get_tree().paused = true
			var question_scene = Question.instance()
			add_child(question_scene)
			time_left += 10
			$HUD.update_score(time_left)


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
