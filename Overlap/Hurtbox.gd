extends Area2D

const HitEffect = preload("res://Effects/HitEffect.tscn")

signal invincibility_ended
signal invincibility_started

onready var timer = $Timer

var invincible := false setget set_invincible

func set_invincible(value : bool):
	invincible = value
	if invincible == true:
		emit_signal("invincibility_started")
	else:
		emit_signal("invincibility_ended")

func start_invincibility(duration : float):
	self.invincible = true # self required to call the setter
	timer.start(duration)

func create_hit_effect():
	var effect = HitEffect.instance()
	var main = get_tree().current_scene
	main.add_child(effect)
	effect.global_position = global_position

func _on_Timer_timeout():
	self.invincible = false # self required to call the setter

func _on_Hurtbox_invincibility_started():
	set_deferred("monitoring", false)

func _on_Hurtbox_invincibility_ended():
	monitoring = true
