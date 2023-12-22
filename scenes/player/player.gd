extends CharacterBody2D
@export var speed: int = 500
@export var jump_height: float
@export var jump_time_to_peak: float
@export var jump_time_to_descend: float

@onready var jump_velocity: float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity: float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_gravity: float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_descend)) * -1.0
@onready var alive: bool = true

signal player_lost

func _process(delta):
	if (not alive):
		$AnimatedSprite2D.play("death")
		if (is_on_floor()):
			velocity = Vector2.ZERO
		else:
			velocity.y += get_gravity() * delta 
			move_and_slide()
			
	elif (Globals.can_move):
		var direction = get_movement_x()
		velocity.x = direction * speed
		velocity.y += get_gravity() * delta
		if (direction < 0):
			$AnimatedSprite2D.flip_h = true
		if (direction > 0):
			$AnimatedSprite2D.flip_h = false
		
		if (velocity.x == 0.0):
			$AnimatedSprite2D.play("rest")
		else:
			$AnimatedSprite2D.play("walk")
		
		if (not is_on_floor()):
			$AnimatedSprite2D.play("jump")
		
		if (Input.is_action_just_pressed("jump") and is_on_floor()):
			jump()
		
		Globals.player_pos = global_position
		move_and_slide()
		
	else:
		$AnimatedSprite2D.play("rest")

func get_movement_x() -> int:
	if Input.is_action_pressed("left"):
		return -1
		
	if Input.is_action_pressed("right"):
		return 1
		
	else:
		return 0

func jump() -> void:
	velocity.y = jump_velocity

func get_gravity() -> float:
	return jump_gravity if velocity.y < 0.0 else fall_gravity

func hit() -> void:
	alive = false
	player_lost.emit()
