extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var screensize = Vector2(1280,720)


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		$AnimatedSprite2D.pause()
	else:
		$AnimatedSprite2D.play()
		

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		$AnimatedSprite2D.animation = "walk"
		velocity.x = direction * SPEED
		if velocity.x > 0:
			$AnimatedSprite2D.flip_h = false
		if velocity.x < 0:
			$AnimatedSprite2D.flip_h = true
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$AnimatedSprite2D.animation = "idle"
		
	position.x = clamp(position.x, 0 + $CollisionShape2D.shape.radius,
		screensize.x - $CollisionShape2D.shape.radius)
	move_and_slide()
