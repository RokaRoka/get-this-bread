extends KinematicBody2D

const SPEED = 60

var velocity = Vector2()



func _physics_process(_delta: float) -> void:
	if Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
		$AnimationPlayer.play("walkRight")
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
		$AnimationPlayer.play("walkLeft")
	else:
		velocity.x = 0
		if Input.is_action_just_released("ui_right"):
			$AnimationPlayer.play("idleRight")
		if Input.is_action_just_released("ui_left"):
			$AnimationPlayer.play("idleLeft")
	
	
	if Input.is_action_pressed("ui_up"):
		velocity.y = -SPEED
		$AnimationPlayer.play("walkUp")
	elif Input.is_action_pressed("ui_down"):
		velocity.y = SPEED
		$AnimationPlayer.play("walkDown")
	else:
		velocity.y = 0
		if Input.is_action_just_released("ui_up"):
			$AnimationPlayer.play("idleUp")
		if Input.is_action_just_released("ui_down"):
			$AnimationPlayer.play("idleDown")
	
	
	
	velocity = move_and_slide(velocity)
