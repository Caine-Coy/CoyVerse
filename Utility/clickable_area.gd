extends Area3D

signal object_brushed()

func _on_mouse_entered():
	object_brushed.emit(get_parent())
