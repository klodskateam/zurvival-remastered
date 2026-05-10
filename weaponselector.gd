extends Panel

@onready var primary = $PrimaryDropdown
@onready var sidearm = $SidearmDropdown
@onready var utility = $UtilityDropdown
var deployed = false

func _ready() -> void:
	for i in Global.ALLWEAPONS.size():
		for i2 in Global.WEAPONS.size():
			if Global.ALLWEAPONS[i]["class"] == "primary":
				if Global.ALLWEAPONS[i]["id"] == Global.WEAPONS[i2]["id"]:
					primary.add_item(tr(Global.WEAPONS[i2]["name"]), Global.ALLWEAPONS[i]["id"])
			if Global.ALLWEAPONS[i]["class"] == "sidearm":
				if Global.ALLWEAPONS[i]["id"] == Global.WEAPONS[i2]["id"]:
					sidearm.add_item(tr(Global.WEAPONS[i2]["name"]), Global.ALLWEAPONS[i]["id"])
			if Global.ALLWEAPONS[i]["class"] == "utility":
				if Global.ALLWEAPONS[i]["id"] == Global.WEAPONS[i2]["id"]:
					utility.add_item(tr(Global.WEAPONS[i2]["name"]), Global.ALLWEAPONS[i]["id"])	
					
	for i in Global.SAVED_WEAPONS.size():
		if Global.SAVED_WEAPONS[i]["class"] == "primary":
			for i2 in primary.item_count:
				if primary.get_item_id(i2) == Global.SAVED_WEAPONS[i]["id"]:	
					primary.select(i2)
					break
		if Global.SAVED_WEAPONS[i]["class"] == "sidearm":
			for i2 in sidearm.item_count:
				if sidearm.get_item_id(i2) == Global.SAVED_WEAPONS[i]["id"]:	
					sidearm.select(i2)
					break
		if Global.SAVED_WEAPONS[i]["class"] == "utility":
			for i2 in utility.item_count:
				if utility.get_item_id(i2) == Global.SAVED_WEAPONS[i]["id"]:	
					utility.select(i2)		
					break


func _on_equip_button_pressed() -> void:
	Global.EQUIPPED_WEAPONS = []
	Global.SAVED_WEAPONS = []
	for i in [primary.get_selected_id(), sidearm.get_selected_id(), utility.get_selected_id()]:
		for i2 in Global.WEAPONS.size():
			if Global.WEAPONS[i2]["id"] == i:
				Global.EQUIPPED_WEAPONS.append(Global.WEAPONS[i2])	
				Global.SAVED_WEAPONS.append(Global.ALLWEAPONS[i2])
				break
	Global.CONFIG.set_value("items", "weapons", Global.SAVED_WEAPONS)
	Global.CONFIG.save(Global.SAVE_PATH)


func _on_weapons_button_pressed() -> void:
	if !deployed:
		visible = true
		var tween = create_tween()
		tween.tween_property(self, "position", Vector2(421.0, position.y), 0.5).set_trans(Tween.TRANS_QUINT)
		deployed = true
	elif deployed:
		var tween = create_tween()
		tween.tween_property(self, "position", Vector2(161.0, position.y), 0.5).set_trans(Tween.TRANS_QUINT)
		await tween.finished
		visible = false	
		deployed = false



	pass # Replace with function body.
