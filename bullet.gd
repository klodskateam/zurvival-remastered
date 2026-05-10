extends RigidBody2D

var SPEED = 1450
var DAMAGE = 100
var shotgunbullet
var rngnum = 0
var rngnum2 = 0
var magnum = false
var PIERCETHRU = false
var despawn_dist = 100
var markerpos = Vector2.ZERO

func _ready() -> void:
	if GamemodeManager.GAMEMODE == 3:
		# трижды весело
		var DATE = Time.get_date_string_from_system()
		var RNG = RandomNumberGenerator.new()
		DATE = int(str(DATE).replace("-", ""))
		#print("date:" + str(hash(int(DATE/64))))
		if GamemodeManager.CHALLENGEID == 0:
			RNG.seed = hash(DATE^4263)
		elif GamemodeManager.CHALLENGEID == 1:
			RNG.seed = hash(DATE^75419)
		elif GamemodeManager.CHALLENGEID == 2:
			RNG.seed = hash(DATE^93426)
		rngnum = RNG.randi_range(0, 7)
		rngnum2 = RNG.randi_range(0, 9)
		
		if rngnum == 3:
			SPEED /= 2
		elif rngnum == 6 or rngnum2 == 8:
			SPEED /= 1.7
	if shotgunbullet:
		var bet = 0
		bet = randi_range(0, 2)
		if bet == 1:
			PIERCETHRU = true
		elif PIERCETHRU == true:
			pass
		else:
			PIERCETHRU = false
	# magnum убран :( -- 28/04/26
func _physics_process(delta):
	linear_velocity = Vector2(0, -SPEED).rotated(global_rotation)
	if markerpos != Vector2.ZERO and global_position.distance_to(markerpos) >= despawn_dist:
		queue_free()
	
