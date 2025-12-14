extends CharacterBody2D

class_name Character2

const FRICTION: float = 0.15



@export var accerelation: int = 40
@export var max_speed: int = 100


var mov_direction: Vector2 = Vector2.ZERO


func _physics_process(_delta: float) -> void:
	move_and_slide()
	velocity = lerp(velocity, Vector2.ZERO, FRICTION)


func move() -> void:
	mov_direction = mov_direction.normalized()
	velocity += mov_direction * accerelation
	velocity = velocity.limit_length(max_speed)

	
func _ready():
	pass
