extends Control
var respuesta
var pregunta_index
var time_left = 0
signal question_answered


func _ready():
	get_tree().paused = true
	pregunta_index = rand_range(0, 4)
	respuesta = read_file()
	set_process_input(true)


func _on_answer_a_pressed():
	var button_a = get_node("CanvasLayer/CenterContainer/VBoxContainer/answer_a")
	var button_b = get_node("CanvasLayer/CenterContainer/VBoxContainer/answer_b")
	var button_c = get_node("CanvasLayer/CenterContainer/VBoxContainer/answer_c")
	var button_d = get_node("CanvasLayer/CenterContainer/VBoxContainer/answer_d")
	
	button_b.disabled = true
	button_c.disabled = true
	button_d.disabled = true
	
	if respuesta == 0:
		button_a.modulate = Color(0,1,0)
		Singleton.left_time +=10
	else:
		button_a.modulate = Color(1,0,0)
		Singleton.left_time -=5
		correct_answer()
	AnswerTime()


func _on_answer_b_pressed():
	var button_a = get_node("CanvasLayer/CenterContainer/VBoxContainer/answer_a")
	var button_b = get_node("CanvasLayer/CenterContainer/VBoxContainer/answer_b")
	var button_c = get_node("CanvasLayer/CenterContainer/VBoxContainer/answer_c")
	var button_d = get_node("CanvasLayer/CenterContainer/VBoxContainer/answer_d")
	
	button_a.disabled = true
	button_c.disabled = true
	button_d.disabled = true
	if respuesta == 1:
		button_b.modulate = Color(0,1,0)
		Singleton.left_time +=10
	else:
		button_b.modulate = Color(1,0,0)
		Singleton.left_time -=5
		correct_answer()
	AnswerTime()




func _on_answer_c_pressed():
	var button_a = get_node("CanvasLayer/CenterContainer/VBoxContainer/answer_a")
	var button_b = get_node("CanvasLayer/CenterContainer/VBoxContainer/answer_b")
	var button_c = get_node("CanvasLayer/CenterContainer/VBoxContainer/answer_c")
	var button_d = get_node("CanvasLayer/CenterContainer/VBoxContainer/answer_d")
	
	button_b.disabled = true
	button_a.disabled = true
	button_d.disabled = true
	if respuesta == 2:
		button_c.modulate = Color(0,1,0)
		Singleton.left_time +=10
	else:
		button_c.modulate = Color(1,0,0)
		Singleton.left_time -=5
		correct_answer()
	AnswerTime()

func _on_answer_d_pressed():
	var button_a = get_node("CanvasLayer/CenterContainer/VBoxContainer/answer_a")
	var button_b = get_node("CanvasLayer/CenterContainer/VBoxContainer/answer_b")
	var button_c = get_node("CanvasLayer/CenterContainer/VBoxContainer/answer_c")
	var button_d = get_node("CanvasLayer/CenterContainer/VBoxContainer/answer_d")
	
	button_b.disabled = true
	button_c.disabled = true
	button_a.disabled = true
	if respuesta == 3:
		button_d.modulate = Color(0,1,0)
		Singleton.left_time +=10
	else:
		button_d.modulate = Color(1,0,0)
		Singleton.left_time -=5
		correct_answer()
	AnswerTime()


func AnswerTime():
	get_tree().paused = true

	yield(get_tree().create_timer(2.0), "timeout")

	get_tree().paused = false
	queue_free()


func read_file():
	var archivo = File.new()
	archivo.open('res://assets/data/pregunta.json',archivo.READ)
	var datos_del_archivo = archivo.get_as_text()
	archivo.close()
	var parse_result = JSON.parse(datos_del_archivo)
	var diccionario = parse_result.result
	var preguntas = parse_result.result["questions"]
	var pregunta = diccionario["questions"][pregunta_index]["question"]
	$CanvasLayer/CenterContainer/VBoxContainer/question.text = str(pregunta)
	var respuestas = diccionario["questions"][pregunta_index]["answers"]
	var respuesta_correcta = diccionario["questions"][pregunta_index]["correct_answer"]
	$CanvasLayer/CenterContainer/VBoxContainer/answer_a.text = str(respuestas[0])
	$CanvasLayer/CenterContainer/VBoxContainer/answer_b.text = str(respuestas[1])
	$CanvasLayer/CenterContainer/VBoxContainer/answer_c.text = str(respuestas[2])
	$CanvasLayer/CenterContainer/VBoxContainer/answer_d.text = str(respuestas[3])
			
	return respuesta_correcta

func correct_answer():
	var button_a = get_node("CanvasLayer/CenterContainer/VBoxContainer/answer_a")
	var button_b = get_node("CanvasLayer/CenterContainer/VBoxContainer/answer_b")
	var button_c = get_node("CanvasLayer/CenterContainer/VBoxContainer/answer_c")
	var button_d = get_node("CanvasLayer/CenterContainer/VBoxContainer/answer_d")
	if respuesta == 0:
		button_a.modulate = Color(0,1,0)
	elif respuesta == 1:
		button_b.modulate = Color(0,1,0)
	elif respuesta == 2:
		button_c.modulate = Color(0,1,0)
	elif respuesta == 3:
		button_d.modulate = Color(0,1,0)
