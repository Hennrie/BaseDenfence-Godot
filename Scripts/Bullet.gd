extends Area2D

const SPEED = 400
var motion = Vector2()
#var userTouchPos = Vector2()
var velocity_direction = Vector2()


func _ready():
#	userTouchPos = get_global_mouse_position()
#	velocity_direction = (Global.fixedPoint - userTouchPos).normalized()
#	self.set_global_rotation_degrees(velocity_direction)
	
#func init(muzzle_pos : Vector2, barrel_oriation : float):
	pass
#	global_position = muzzle_pos
#	global_rotation_degrees = barrel_oriation
	

func _physics_process(delta):
	
	motion = velocity_direction * SPEED * delta
	
	translate(motion)
	
		
func _set_direction(var direction : Vector2) -> void :
	velocity_direction = direction
	print(direction)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	
	

func _on_Area2D_body_entered(body):
	pass
