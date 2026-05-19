extends Node

@export var bat: PackedScene

func _ready() -> void:
	spawnBats()


func spawnBats():
	var b = bat.instantiate()
	b.position = Vector2(200,200)
	get_tree().root.add_child.call_deferred(b)
