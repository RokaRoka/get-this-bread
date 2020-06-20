extends KinematicBody2D

const SPEED = 60

var velocity = Vector2()

var lastDir = "Down"

func _physics_process(_delta: float) -> void:
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
