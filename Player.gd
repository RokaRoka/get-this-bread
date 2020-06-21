extends KinematicBody2D

const SPEED = 80

var velocity = Vector2()

export (float) var teleportDist = 60.0
var teleporting = false
var lastDir = "Down"

func _ready():
	$Teleporter.connect("teleport_finished", self, "teleportDone")

func _physics_process(_delta: float) -> void:
	if teleporting:
		return
	
	if Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
	else:
		velocity.x = 0
	
	
	if Input.is_action_pressed("ui_up"):
		velocity.y = -SPEED
	elif Input.is_action_pressed("ui_down"):
		velocity.y = SPEED
	else:
		velocity.y = 0
	
	if Input.is_action_just_pressed("ui_accept"):
		startTeleport()
	
	
	if velocity.x > 0:
		if velocity.y > 0:
			$AnimationPlayer.play("walkDiagDR")
			lastDir = "DR"
		elif velocity.y < 0:
			$AnimationPlayer.play("walkDiagUR")
			lastDir = "UR"
		else:
			$AnimationPlayer.play("walkRight")
			lastDir = "Right"
	elif velocity.x < 0:
		if velocity.y > 0:
			$AnimationPlayer.play("walkDiagDL")
			lastDir = "DL"
		elif velocity.y < 0:
			$AnimationPlayer.play("walkDiagUL")
			lastDir = "UL"
		else:
			$AnimationPlayer.play("walkLeft")
			lastDir = "Left"
	else:
		if velocity.y < 0:
			$AnimationPlayer.play("walkUp")
			lastDir = "Up"
		elif velocity.y > 0:
			$AnimationPlayer.play("walkDown")
			lastDir = "Down"
		else: # both x and y are 0
			$AnimationPlayer.stop(true)
	
	
	velocity = move_and_slide(velocity)

func startTeleport():
	teleporting = true
	var dir = Vector2()
	match(lastDir):
		"Up":
			dir = Vector2.UP
		"UR":
			dir = Vector2.UP + Vector2.RIGHT
		"Right":
			dir = Vector2.RIGHT
		"DR":
			dir = Vector2.RIGHT + Vector2.DOWN
		"Down":
			dir = Vector2.DOWN
		"DL":
			dir = Vector2.LEFT + Vector2.DOWN
		"Left":
			dir = Vector2.LEFT
		"UL":
			dir = Vector2.UP + Vector2.LEFT
	$Teleporter.goto(position + dir * teleportDist)

func teleportDone():
	teleporting = false
