extends Node

signal teleport_finished

var destination: Vector2
export (float) var delay = 0.2

func goto(var location: Vector2):
	destination = location
	$Timer.start(delay)


func _on_Timer_timeout():
	get_parent().position = destination
	emit_signal("teleport_finished")
