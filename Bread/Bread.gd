tool
extends Area2D

export (float) var playerDetectionRadius = 64 setget set_playerDetectionRadius
export (float) var teleportDistance = 128.0

var teleporting = false

var nav2D: Navigation2D
var player
var quipper

func _ready():
	if !Engine.editor_hint:
		nav2D = get_tree().current_scene.get_node("Navigation2D")
		player = get_tree().current_scene.get_node("YSort/Player")
		quipper = get_tree().current_scene.get_node("GUI/Quipper")
		$Teleporter.connect("teleport_finished", self, "teleportDone")

func _physics_process(delta):
	if !Engine.editor_hint and !teleporting:
		var distanceToPlayer =  player.position.distance_to(position)
		if distanceToPlayer < playerDetectionRadius:
			# we want to teleport away from the player, if possible
			var destination = position
			var closestPoint = Vector2()
			var teleportVector = -position.direction_to(player.position).normalized() * teleportDistance
			closestPoint = nav2D.get_closest_point(teleportVector + position)
			if destination + teleportVector == closestPoint and checkInBounds(closestPoint): # try away from player
				print("nyoom time")
				destination = closestPoint
			elif checkInBounds(position - teleportVector):
				print("I'm behind you :)")
				destination -= teleportVector
			elif checkInBounds(position - teleportVector.rotated(PI/2)):
				print("On your right!")
				destination -= teleportVector.rotated(PI/2)
			elif checkInBounds(position - teleportVector.rotated(-PI/2)):
				print("On your left!")
				destination -= teleportVector.rotated(-PI/2)
			#LMAO uh. if we hit else, teleport in place???? cool.
			$AudioStreamPlayer.play()
			$Teleporter.goto(destination)
			teleporting = true

func checkInBounds(var destination) -> bool:
	var ground_tilemap:TileMap = get_tree().current_scene.get_node("Tiles+Walls")
	var tilePos = ground_tilemap.world_to_map(destination)
	var destTile = ground_tilemap.get_cell(tilePos.x, tilePos.y)
	if destTile != TileMap.INVALID_CELL:
		var destTileName = ground_tilemap.tile_set.tile_get_name(destTile)
		if destTileName == "Walls":
			return false
		else:
			return true
	else:
		return false

func teleportDone():
	teleporting = false
	quipper.makeQuip()

func set_playerDetectionRadius(var value):
	playerDetectionRadius = value
	update()

func _draw():
	if Engine.editor_hint:
		draw_arc(Vector2(0, 0), playerDetectionRadius, 0, 2 * PI, 64, Color.lightblue, 1.0)
		draw_arc(Vector2(0, 0), teleportDistance, 0, 2 * PI, 96, Color.lightpink, 1.0)


func _on_Bread_body_entered(body: Node) -> void:
	if body.name == "Player":
		print("You win!")
		get_tree().current_scene.get_node("WinTransition").winGame()
