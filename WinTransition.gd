extends CanvasModulate

onready var tween = $Tween

var winScreenPath = "res://Menus/WinScreen.tscn"

func winGame():
	#pause player and bread
	print("win game!")
	get_tree().paused = true
	tween.interpolate_property(self, "color", Color.white, Color.black, 2, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	tween.start()
	tween.connect("tween_all_completed", self, "loadWinScreen")

func loadWinScreen():
	get_tree().paused = false
	get_tree().change_scene(winScreenPath)
