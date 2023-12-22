extends CanvasLayer
signal start_game

@onready var score_label: Label = $Score/Score

func _ready():
	Globals.connect("score_change", update_score)
	$HighScore.hide()
	$Score.hide()

func update_score():
	score_label.text = str(Globals.score)

func show_message(text):
	$StartMessage.text = text
	$StartMessage.show()
	$MessageTimer.start(2)

func show_game_over():
	show_message("You Died")
	await $MessageTimer.timeout
	$StartMessage.text = "Chicken Little 2: Electric Boogaloo"
	$StartMessage.show()
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()
	$Score.hide()
	$HighScore/Score.text = str(Globals.high_score)
	$HighScore.show()
	
func _on_start_button_pressed():
	$StartButton.hide()
	$StartMessage.hide()
	start_game.emit()
	$Score.show()
	$HighScore.hide()

func _on_message_timer_timeout():
	$StartMessage.hide()
	print("hiding msg")
