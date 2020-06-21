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
	"You're pretty crumby at this...",
	"Is that your best?",
	"Are you even trying?",
	"Ha. Looooooooser.",
	"Sometimes I get lonely at night...",
	"All this running is turning my dough sour.",
	"Yawn.",
	"Booooring.",
	"Have you ever even played a game before?",
	"LOL",
	"You're too slow!",
	"You need to lay off the bread.",
	"Someone's put on a little weight...",
	"Is that all you got?",
	"This is EZ-bake",
	"My grandma runs faster than you and she's a loaf of bread.",
	"Where is everyone?",
	"You've activated my trap card!",
	"Do you go out looking like that?"
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
