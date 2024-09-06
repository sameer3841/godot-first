extends CharacterBody2D


const SPEED = 900.0
const JUMP_VELOCITY = -2400.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var multi = 1
	if Input.is_action_pressed("run"):
		multi = 2
	else:
		multi = 1
		
		
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED * multi
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED * multi)
	
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = false
	if velocity.x != 0:
		$AnimatedSprite2D.play("walk")
	else:
		$AnimatedSprite2D.play("idle")

	move_and_slide()
