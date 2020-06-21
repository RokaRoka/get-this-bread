extends PanelContainer

func _physics_process(delta):
	if Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_down") or Input.is_action_pressed("ui_up"):
		$VBoxContainer/Tutorial1.hide()
		if !$VBoxContainer/Tutorial1.visible and !$VBoxContainer/Tutorial2.visible:
			queue_free()
	if Input.is_action_pressed("ui_accept"):
		$VBoxContainer/Tutorial2.hide()
		if !$VBoxContainer/Tutorial1.visible and !$VBoxContainer/Tutorial2.visible:
			queue_free()
