extends Area2D

@export var speed = 400
var velocity = Vector2.ZERO

func start(_transform):
	transform = _transform
	velocity = transform.x * speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += velocity * delta
