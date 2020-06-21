extends Control

var titleScreenPath = "res://Menus/Title.tscn"
var gameScenePath = "res://Tilemap.tscn"

func _on_ReturnToMenuBtn_pressed():
	get_tree().change_scene(titleScreenPath)


func _on_PlayAgainBtn_pressed():
	get_tree().change_scene(gameScenePath)
