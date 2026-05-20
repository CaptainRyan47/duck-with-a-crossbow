extends Area2D
var falling: bool = false
var screensize = Vector2(1280,720)
@export var fallingSpeed: float = 800

func die():
    falling = true

func _on_area_entered(area: Area2D) -> void:
    if area.is_in_group("bolts"):
        die()

func _process(delta):
    if falling:
        position.y += fallingSpeed * delta
        # TODO make this fall slowly at first and build speed as falling.
    if position.y > screensize.y + $CollisionShape2D.shape.radius:
        queue_free()