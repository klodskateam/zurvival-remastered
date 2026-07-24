extends CharacterBody2D

# ЗОНДРЕ НАХ 😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨
# ЗОНДРЕ НАХ 😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨
# ЗОНДРЕ НАХ 😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨
# ЗОНДРЕ НАХ 😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨
# ЗОНДРЕ НАХ 😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨
# ЗОНДРЕ НАХ 😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨
# ЗОНДРЕ НАХ 😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨
# ЗОНДРЕ НАХ 😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨
# ЗОНДРЕ НАХ 😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨
# ЗОНДРЕ НАХ 😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨😨

@onready var player: CharacterBody2D = $"../player"
@onready var navagent: NavigationAgent2D = $NavigationAgent2D
@onready var timer: Timer = $Timer

const DEFAULT_SPEED = 217
var SPEED = 217
var HP = 100
var DAMAGE = 10
var rngnum
var rngnum2
var rngnum3

var twotapkill = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready() -> void:
	match GamemodeManager.GAMEMODE:
		-1:
			pass
		1:
			DAMAGE = 100
			SPEED = DEFAULT_SPEED
		_:
			DAMAGE = 10
			SPEED = DEFAULT_SPEED
	if GamemodeManager.GAMEMODE == -1:
		if !GamemodeManager.MODGAME.has("zondre_damage") or GamemodeManager.MODGAME["zondre_damage"] == "default":
			DAMAGE = 10
		else:
			DAMAGE = int(GamemodeManager.MODGAME["zondre_damage"])
		if !GamemodeManager.MODGAME.has("zondre_speed") or GamemodeManager.MODGAME["zondre_speed"] == "default":
			SPEED = DEFAULT_SPEED
		else:
			SPEED = int(GamemodeManager.MODGAME["zondre_speed"])
			
	if GamemodeManager.GAMEMODE == 3:
		# дважды весело
		var DATE = Time.get_date_string_from_system()
		var RNG = RandomNumberGenerator.new()
		DATE = int(str(DATE).replace("-", ""))
		#print("date:" + str(hash(int(DATE/64))))
		if GamemodeManager.CHALLENGEID == 0:
			RNG.seed = hash(DATE^ChallengeManager.CHALLENGES[0]["xorhash"])
		elif GamemodeManager.CHALLENGEID == 1:
			RNG.seed = hash(DATE^ChallengeManager.CHALLENGES[1]["xorhash"])
		elif GamemodeManager.CHALLENGEID == 2:
			RNG.seed = hash(DATE^ChallengeManager.CHALLENGES[2]["xorhash"])
		rngnum = RNG.randi_range(0, 4)
		rngnum2 = RNG.randi_range(0, 6)
		rngnum3 = RNG.randi_range(0, 8)
		#print(rngnum)
		#print(rngnum2)
		#print(rngnum3)
		if rngnum == 3:
			SPEED = 380
		if rngnum2 == 2 or rngnum3 == 1:
			DAMAGE = 20
		if (rngnum2 == 6 or 3) or rngnum3 == 4: # не бейте, я исправил
			twotapkill = true
		else:
			twotapkill = false
			
func _physics_process(delta: float) -> void:
	if HP <= 0:
		player.SCORE += 1
		$".".queue_free()
	
	look_at($"../player".position)
	nav(delta)
	move_and_slide()
	
func nav(delta: float) -> void:
	if navagent.is_navigation_finished():
		velocity = velocity.lerp(Vector2.ZERO, 0.2)
	else:
		var nextpath: Vector2 = navagent.get_next_path_position()
		var newvelocity: Vector2 = (global_position.direction_to(nextpath) * SPEED)
		velocity = newvelocity
	


func _on_timer_timeout() -> void:
	if player != null:
		navagent.target_position = player.global_position

#func get_direction_to_player():
#	var player = get_tree().get_first_node_in_group("player") as Node2D
#	
#	if player != null:
#		return (player.global_position - global_position).normalized()
#	return Vector2.ZERO

func _on_area_2d_body_entered(body: Node2D) -> void:
	#print(body)
	if body.name == "player":
		body.HEALTH -= DAMAGE
		body.dmgblur = true
	if body.is_in_group("danger_zombie"):
		if GamemodeManager.GAMEMODE != 3 or !twotapkill:
			HP -= body.DAMAGE
			if body.PIERCETHRU and body.DAMAGE >= HP:
				body.DAMAGE /= 2
				pass
			else:
				body.queue_free()
		if GamemodeManager.GAMEMODE == 3 and twotapkill:
			HP -= body.DAMAGE/2
			body.queue_free()
			
