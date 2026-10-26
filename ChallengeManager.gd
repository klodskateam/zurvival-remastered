extends Node

var DATE
var RNG = RandomNumberGenerator.new()
var highestscore = 0
var bestchallenge = 0
var CHALLENGES = [
	{
		"score": 0, # A
		"xorhash": 15863
	},
	{
		"score": 0, # B
		"xorhash": 8931
	},
	{
		"score": 0, # C
		"xorhash": 95372
	}
]

func pickbestchallenge():
	# это говнокод, но лучше способа я не знаю
	DATE = Time.get_date_string_from_system()
	DATE = int(str(DATE).replace("-", ""))
	for challenge in CHALLENGES.size():
		RNG.seed = hash(DATE^int(CHALLENGES[challenge]["xorhash"]))
		var rngnum = RNG.randi_range(0, 4)
		var rngnum2 = RNG.randi_range(0, 6)
		var rngnum3 = RNG.randi_range(0, 8)
		var rngnum4 = RNG.randi_range(0, 19)
		var rngnum5 = RNG.randi_range(0, 6)
		var rngnum6 = RNG.randi_range(0, 10)
		var rngnum7 = RNG.randi_range(0, 14)
		var rngnum8 = RNG.randi_range(0, 23)
		var rngnum9 = RNG.randi_range(0, 18)
		var rngnum10 = RNG.randi_range(0, 7)
		var rngnum11 = RNG.randi_range(0, 9)
		var rngnum12 = RNG.randi_range(0, 12)
		if rngnum == 3:
			CHALLENGES[challenge]["score"] += 1
		if rngnum2 == 2 or rngnum3 == 1:
			CHALLENGES[challenge]["score"] += 1
		if (rngnum2 == 6 or 3) or rngnum3 == 4:
			CHALLENGES[challenge]["score"] += 1
		if rngnum4 == 16 or rngnum5 == 4:
			CHALLENGES[challenge]["score"] += 1
		if rngnum6 == 5:
			CHALLENGES[challenge]["score"] += 1
		elif rngnum6 == 9:
			CHALLENGES[challenge]["score"] += 1
		if rngnum7 == 7 or rngnum9 == 3:
			CHALLENGES[challenge]["score"] += 1
		elif rngnum2 == 9 or rngnum9 == 12:
			CHALLENGES[challenge]["score"] += 1
		elif rngnum7 == 5 or rngnum7 == 8:
			CHALLENGES[challenge]["score"] += 1
		elif rngnum7 == 3:
			CHALLENGES[challenge]["score"] += 1
		elif rngnum7 == 12 or rngnum9 == 8:
			CHALLENGES[challenge]["score"] += 1
		if rngnum8 == 15 or rngnum9 == 6:
			CHALLENGES[challenge]["score"] += 1
		elif rngnum8 == 18 or rngnum9 == 2:
			CHALLENGES[challenge]["score"] += 1
		elif rngnum8 == 7:
			CHALLENGES[challenge]["score"] += 1
		if rngnum9 == 11:
			CHALLENGES[challenge]["score"] += 1
		if rngnum10 == 3:
			CHALLENGES[challenge]["score"] += 1
		elif rngnum10 == 6 or rngnum11 == 8:
			CHALLENGES[challenge]["score"] += 1
		if rngnum12 == 2:
			CHALLENGES[challenge]["score"] += 1
		
		var score = CHALLENGES[challenge]["score"]
		if score > highestscore:
			highestscore = score
			bestchallenge = challenge
		elif score == highestscore:
			highestscore = score+1
			bestchallenge = challenge
	
	return bestchallenge
		
			
