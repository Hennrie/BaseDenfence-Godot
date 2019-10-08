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
	Global.fixedPoint = $Barrel.get_global_position()
	


func _process(delta):
	if finger_in_touchArea == true:
		$Barrel.look_at(get_global_mouse_position())

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.is_action_pressed("ui_fire") and finger_in_touchArea and can_fire:
#	if event is InputEventScreenTouch:
#		if event.pressed and finger_in_touchArea and can_fire:
			$Barrel.look_at(get_global_mouse_position())
			emit_signal("shoot", BULLET, $Barrel.get_global_rotation_degrees())
			
		
	else:
		pass
		

func _on_MainTurret_shoot(Bullet, direction):
	can_fire = false
	$Fire_rate_Timer.start()
	bullet = Bullet.instance()
	print("arrow created")
	
	bullet.global_position = $Barrel/Muzzle.global_position
	get_node("/root/Level1").add_child(bullet)
	
	
#	var look_vec = (get_global_position() - get_global_mouse_position()).normalized()
	
	bullet.set_global_rotation_degrees(direction)
#	

func _on_Area2D_mouse_entered():
	finger_in_touchArea = true


func _on_Area2D_mouse_exited():
	finger_in_touchArea = false


func _on_Timer_timeout():
	can_fire = true


