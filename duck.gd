extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var screensize = Vector2(1280,720)
@export var bolt : PackedScene


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		$Visuals/AnimatedSprite2D.pause()
	else:
		$Visuals/AnimatedSprite2D.play()
		
	if Input.is_action_just_pressed("fire"):
		shoot()
		
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("left", "right")
	var mouse = get_global_mouse_position()
	if direction:
		$Visuals/AnimatedSprite2D.animation = "walk"
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$Visuals/AnimatedSprite2D.animation = "idle"
		
	position.x = clamp(position.x, 0 + $CollisionShape2D.shape.radius,
		screensize.x - $CollisionShape2D.shape.radius)
	
	if mouse.x - position.x > 0:
			$Visuals.scale.x = 1
	if mouse.x - position.x < 0:
			$Visuals.scale.x = -1
			
	$Visuals/Crossbow.look_at(mouse)
	move_and_slide()


func shoot():
	var b = bolt.instantiate()
	get_tree().root.add_child(b)
	b.start($Visuals/Crossbow/Marker2D.global_transform)
