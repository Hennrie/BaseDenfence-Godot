extends Node2D

var fixedPoint = Vector2()
#var userTouchPoint = Vector2()
var player_is_aiming = false
var can_fire = true
var fire_rate = 0.5
var bullet
var bullet_line_hit = false


const BULLET = preload("res://Szenes/Bullet.tscn")
const RIGIDARROW = preload("res://Szenes/ArrowRigid.tscn")

onready var turret_centerPoint : Vector2 = self.global_position
onready var Barrel = get_node("Barrel")
onready var fireDirection = Vector2()

signal shoot(BULLET, direction)
signal create_arrow (BULLET)


func _ready():
	
	pass
#	print(turret_centerPoint)
#	print($Barrel/Muzzle.global_position)
##	Global.fixedPoint = $Barrel.get_global_position()
	
	


func _physics_process(delta):

	if Global.touch_pos_in_actionArea and player_is_aiming:
		Barrel.look_at(get_global_mouse_position())

		

#	if finger_in_touchArea == true:
#		$Barrel.look_at(get_global_mouse_position())
	
		### rigid arrow test ###
		
#	print(Barrel.get_global_rotation_degrees())
	if player_is_aiming:
		calculate_aiming_line()
#		Barrel.look_at(get_global_mouse_position())
		
		
#func _show_bullet_line_assistance():
#	var space_state = get_world_2d().direct_space_state
#	var result = space_state.intersect_ray($Barrel/Muzzle.global_position, $Barrel/Muzzle.global_position + transform.x * 1000, [self])
#	if result:
#		if not bullet_line_hit:
#			$Barrel/Line2D.add_point(transform.xform_inv(result.position))
#		else:
#			$Barrel/Line2D.set_point_position(1,transform.xform_inv(result.position))
#		return result

func calculate_aiming_line() -> Vector2:
	var shoot_direction : Vector2 = get_global_mouse_position() - turret_centerPoint
	return shoot_direction
	

	
	
func _input(event):
	if event is InputEventScreenTouch and Global.touch_pos_in_actionArea: 
		if event.is_pressed():
			player_is_aiming = true
			print("aiming")
	
		else:
			player_is_aiming = false
			emit_signal("shoot", BULLET, $Barrel.get_global_rotation_degrees())
			print("shooooot")
			
			
	
#		var arrow = RIGIDARROW.instance()
#		arrow.set_global_position(event.get_position())
#
##		arrow.create_arrow(get_global_mouse_position()) 
##		arrow.set_global_position(get_global_mouse_position())
#
#		get_parent().add_child(arrow)
#
##	if event is InputEventMouseButton or InputEventScreenTouch:
#
#	if Input.is_action_just_pressed("ui_fire") and finger_in_touchArea and can_fire:
#
#		###### 
#		pass
#		#emit_signal("shoot", BULLET, $Barrel.get_global_rotation_degrees())
#
##		if  event.is_action_pressed("ui_fire") and finger_in_touchArea and can_fire:
##	if event is InputEventScreenTouch:
##		if event.pressed and finger_in_touchArea and can_fire:
##
##			$Barrel.look_at(get_global_mouse_position())
##			emit_signal("shoot", BULLET, $Barrel.get_global_rotation_degrees())
#
#
#	else:
#		pass
#
		
		

func _on_MainTurret_shoot(Bullet, direction):
	can_fire = false
	$Fire_rate_Timer.start()
	bullet = Bullet.instance()
	
	var orientation : Vector2 = ($Barrel/Muzzle.global_position  - turret_centerPoint).normalized()
	
	bullet.global_position = $Barrel/Muzzle.global_position
	bullet._set_direction(orientation)
	get_node("/root/Level1").add_child(bullet)
	bullet.set_global_rotation($Barrel.global_rotation)
	
	

func _on_Area2D_mouse_entered():
	pass


func _on_Area2D_mouse_exited():
	pass

func _on_Timer_timeout():
	can_fire = true


#func _on_TouchScreenButton_pressed(event):
#
#	event.get_global_position()
#	if event.is_pressed():
#
#		print("shoot")
#		$Barrel.look_at(get_global_mouse_position())
#		emit_signal("shoot", BULLET, $Barrel.get_global_rotation_degrees())
	
	


## Steuerungsverbesserungsidee:
# wenn touchpoint in eine richtung ansteigt dann erst barrel danach ausrichten, wenn touchpoint wieder relativ mittig auf shoottouchpoint
# dann shoot()
 ## + smooth the moving?


	
	
#	var look_vec = (get_global_position() - get_global_mouse_position()).normalized()
	
#	bullet.set_global_rotation_degrees(Barrel.global_rotation_degrees)
