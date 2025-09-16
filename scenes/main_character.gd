extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -920.0
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var start_position := Vector2.ZERO

func _ready() -> void:
	start_position = global_position

func _physics_process(delta: float) -> void:
	# Gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Horizontal movement
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 12)

	# Flip sprite
	sprite_2d.flip_h = velocity.x < 0

	# Animations
	if not is_on_floor():
		sprite_2d.animation = "jumping"
	elif abs(velocity.x) > 1:
		sprite_2d.animation = "running"
	else:
		sprite_2d.animation = "idle"

	# Move
	move_and_slide()

	# Respawn if fell off the map
	if global_position.y > 1000:
		get_tree().reload_current_scene()


func _on_finish_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		print("Player touched finish")
		get_tree().change_scene_to_file("res://scenes/Level2.tscn")
