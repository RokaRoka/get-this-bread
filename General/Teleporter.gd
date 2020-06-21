extends Node2D

signal teleport_finished

var teleportParticles

var destination: Vector2
export (float) var delay = 0.2
export (float) var lag = 0.1

func goto(var location: Vector2):
	destination = location
	$Timer.start(delay)


func _on_Timer_timeout():
	var teleparticles = preload("res://General/TeleportParticles.tscn").instance()
	get_tree().current_scene.add_child(teleparticles)
	teleparticles.position = get_parent().position
	teleparticles.emitting = true
	
	var particleDir = destination.direction_to(get_parent().position)
	get_parent().position = destination
	$LagTimer.start(lag)


func _on_LagTimer_timeout():
	emit_signal("teleport_finished")
