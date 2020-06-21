extends PanelContainer

var quips = [
	
	#pun time
	"You knead to try harder than that.",
	"This is getting pretty stale...",
	"What are you loafing around for?",
	"See if you can cross these hot buns.",
	"Ooo I am on a roll.",
	"At yeast make me try a little.",
	"Your attempts are half-baked at best.",
	"You are pretty crumby at this...",
	"Is that your best?",
	"Are you even trying?",
	"Ha. Looooooooser.",
	"Sometimes I get lonely at night...",
	"All this running is turning my dough sour."
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
