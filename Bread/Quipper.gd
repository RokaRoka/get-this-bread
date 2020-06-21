extends PanelContainer

var quips = [
	"Catch me :)",
	"Haha Loooooooooser",
	"You really are trying huh"
]

var originalRect
var quipping = false

func _ready():
	originalRect = get_rect()
	$Label.visible_characters = 0

func makeQuip():
	#reset timer and characters just in case
	$StayTimer.stop()
	$Label.visible_characters = 0
	#show, and get random quip
	show()
	var random = randi() % quips.size()
	$Label.text = quips[random]
	quipping = true

func _physics_process(delta):
	if quipping:
		$Label.visible_characters += 1
		if $Label.visible_characters >= $Label.get_total_character_count():
			$StayTimer.start()
			quipping = false


func _on_StayTimer_timeout():
	$Label.visible_characters = 0
	$Label.text = ""
	hide()
