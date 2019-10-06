extends Area2D

const SPEED = 200
var velocity = Vector2()
var userTouchPos = Vector2()


func _ready():
	userTouchPos = get_global_mouse_position()
#	
	
	print(Global.fixedPoint)
	
func _process(delta):
	velocity = (Global.fixedPoint - userTouchPos).normalized() * SPEED * delta
	
	translate(velocity)
	

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	
	