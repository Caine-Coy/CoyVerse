extends Area3D

signal object_clicked()

func _on_input_event(camera, event, position, normal, shape_idx):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		object_clicked.emit(get_parent())
