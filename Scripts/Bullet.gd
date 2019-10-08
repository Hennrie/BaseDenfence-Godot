extends KinematicBody2D

const SPEED = 400
var velocity = Vector2()
var userTouchPos = Vector2()
var velocity_direction = Vector2()


func _ready():
	userTouchPos = get_global_mouse_position()
	velocity_direction = (Global.fixedPoint - userTouchPos).normalized()
	
func _process(delta):
	
	velocity =  velocity_direction * SPEED * delta
	
	translate(velocity)
	

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	
	

func _on_Area2D_body_entered(body):
	pass
