extends Node2D

var fixedPoint = Vector2()
var userTouchPoint = Vector2()
var finger_in_touchArea = false
var can_fire = true
var fire_rate = 0.5
var bullet

var BULLET = preload("res://Szenes/Bullet.tscn")

onready var fireDirection = Vector2()

signal shoot(BULLET, direction)
signal create_arrow (BULLET)

func _ready():
	Global.fixedPoint = get_global_position()
	


func _process(delta):
	if finger_in_touchArea == true:
		$Barrel.look_at(get_global_mouse_position())

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.is_action_released("ui_fire") and finger_in_touchArea and can_fire:
			print("jo")
			emit_signal("shoot", BULLET, $Barrel.get_global_rotation_degrees())
			
		
	else:
		pass
		

func _on_MainTurret_shoot(Bullet, direction):
	can_fire = false
	$Timer.start()
	bullet = Bullet.instance()
	print("arrow created")
	
	get_node("/root/Level1").add_child(bullet)
	bullet.global_position = $Barrel.global_position
#	var look_vec = (get_global_position() - get_global_mouse_position()).normalized()
	
	bullet.set_global_rotation_degrees(direction)
#	bullet.set_global_rotation_degrees(atan2(look_vec.y, look_vec.x)) 
	
	####vllt mal global rotation mit richtungsvekor und in winkel umwandeln
	
	
	
#	bullet.position = global_position
#	bullet.rotation = direction
##	bullet.translate(fireDirection)


func _on_Area2D_mouse_entered():
	finger_in_touchArea = true


func _on_Timer_timeout():
	can_fire = true
