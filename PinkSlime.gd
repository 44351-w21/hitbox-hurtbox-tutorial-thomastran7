extends KinematicBody2D

var velocity = Vector2()
const GRAVITY = 40
var speed = 50
export var direction = -1
export var detects_cliffs = true

func _ready():
	$AnimatedSprite.flip_h = direction > 0
	$FloorDetector.position.x = $CollisionShape2D.shape.get_extents().x * direction
	$FloorDetector.enabled = detects_cliffs
	
func _physics_process(delta):
	velocity.y += GRAVITY
	velocity.x = speed * direction
	velocity = move_and_slide(velocity, Vector2.UP)
	if is_on_wall() or (not $FloorDetector.is_colliding() and detects_cliffs and is_on_floor()):
		direction *= -1
		$AnimatedSprite.flip_h = direction > 0
		$FloorDetector.position.x = $CollisionShape2D.shape.get_extents().x * direction
 
