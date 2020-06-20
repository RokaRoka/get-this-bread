tool
extends Area2D

export (float) var playerDetectionRadius = 64 setget set_playerDetectionRadius
export (float) var teleportDistance = 128.0

var teleporting = false

var nav2D: Navigation2D
var player

func _ready():
	if !Engine.editor_hint:
		nav2D = get_node("/root/World/Navigation2D")
		player = get_node("/root/World/Player")
		$Teleporter.connect("teleport_finished", self, "teleportDone")

func _physics_process(delta):
	if !Engine.editor_hint and !teleporting:
		var distanceToPlayer =  player.position.distance_to(position)
		if distanceToPlayer < playerDetectionRadius:
			# we want to teleport away from the player, if possible
			var destination = Vector2()
			var closestPoint = Vector2()
			destination = -position.direction_to(player.position) * teleportDistance
			closestPoint = nav2D.get_closest_point(destination)
			if destination == closestPoint:
				$Teleporter.goto(destination)
				teleporting = true
			else:
				$Teleporter.goto(-destination)
				teleporting = true
			# if we can't do that, we teleport behind the player
			# if we can't do that, we teleport to the left
			# if we can't do that, we teleport to the right

func teleportDone():
	teleporting = false

func decideLocation() -> Vector2:
	return Vector2()

func set_playerDetectionRadius(var value):
	playerDetectionRadius = value
	update()

func _draw():
	if Engine.editor_hint:
		draw_arc(global_position, playerDetectionRadius, 0, 2 * PI, 64, Color.lightblue, 1.0)
