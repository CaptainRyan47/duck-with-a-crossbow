extends Area2D

@export var speed = 1600
var _gravity = 400
var velocity = Vector2.ZERO

# Called when created
func start(_transform):
	transform = _transform
	velocity = transform.x * speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	velocity.y += _gravity * delta
	position += velocity * delta
	rotation = velocity.angle()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
