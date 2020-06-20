extends Label

var quips = [
	"Catch me :)",
	"Haha Loooooooooser",
	"You really are trying huh"
]

var quipping = false

func _ready():
	visible_characters = 0

func makeQuip():
	#reset timer and characters just in case
	$StayTimer.stop()
	visible_characters = 0
	#get random quip
	var random = randi() % quips.size()
	text = quips[random]
	quipping = true

func _physics_process(delta):
	if quipping:
		visible_characters += 1
		if visible_characters >= get_total_character_count():
			$StayTimer.start()
			quipping = false


func _on_StayTimer_timeout():
	visible_characters = 0
