extends Area3D

signal object_selected()

func _on_mouse_entered():
	object_selected.emit(get_parent())
