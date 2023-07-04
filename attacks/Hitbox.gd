class_name Hitbox
extends Area2D

var attack_data: AttackData



func _ready():
	self.body_entered.connect(deal_damage)


func deal_damage(body: Node2D):
	if body is Character:
		var damage_data: DamageData = attack_data.damage_data
		
		var data: DamageData = DamageData.new()
		data.damage = damage_data.damage
		data.knockback = damage_data.knockback
		data.knockback.x = abs(data.knockback.x) * sign(get_parent().scale.x)
		
		data.screenshake = damage_data.screenshake
		data.hitfreeze = damage_data.hitfreeze
		
		var b: bool = (body as Character).take_damage(data)
		if b:
			if data.screenshake != Vector2(-1, -1):
				print(data.screenshake)
				Events.shake(data.screenshake.x, data.screenshake.y)
			if data.hitfreeze != Vector2(-1, -1):
				Events.hitfreeze(data.hitfreeze.x, data.hitfreeze.y)
	



## Enable and disable the hitbox
func turn_on():
	self.monitoring = true
	self.visible = true

func turn_off():
	self.monitoring = false
	self.visible = false


