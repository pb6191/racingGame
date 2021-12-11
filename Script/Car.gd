extends VehicleBody

############################################################
# behaviour values

#export var MAX_ENGINE_FORCE = 150.0
export var MAX_ENGINE_FORCE = 50.0
export var MAX_BRAKE_FORCE = 5.0
#export var MAX_STEER_ANGLE = 0.35
export var MAX_STEER_ANGLE = 0.20

#export var steer_speed = 1.0
export var steer_speed = 0.2

var arrayNBACK = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
var steer_target = 0.0
var steer_angle = 0.0
var fuel
var totalTime = 0.0
var rng = RandomNumberGenerator.new()
var rngN2 = RandomNumberGenerator.new()
var rngN3 = RandomNumberGenerator.new()
var rngN4 = RandomNumberGenerator.new()
var rngN5 = RandomNumberGenerator.new()
var rngN6 = RandomNumberGenerator.new()
var rngN7 = RandomNumberGenerator.new()
var executed = 0
var executedSet = 0
var hitExec = 0
var correectAnswerSet
var prevPosition = $".".translation
var currentPosition = $".".translation
var velocity
var speed = 0
var oldSpeed = 0
var speedToMaintain
var accToMaintain
var nOfBack
var direction = "forward"
var points = 0
var fuelIncrement
var fuelDecrement
var nBackInterval
var displacement = 0
var setInterval
var setN
var setNExtra
var countSet = 0
var numRandCentral
var setToggle = 1
var stDuration
var nFlanks
var currentTrialTime = 0.0
var responseLimit
var upcentre
var sizeComplexity
var trialNum
var closestPtPath
var distToPath = 0
var steer_val = 0
var throttle_val = accToMaintain
var brake_val = 0
var leftBtn = false
var rightBtn = false

var varTarget = ""
var varLMcolor = ""
var varLMshape = ""
var varLMsize = ""
var varLcolor = ""
var varLshape = ""
var varLsize = ""
var varCcolor = ""
var varCshape = ""
var varCsize = ""
var varRcolor = ""
var varRshape = ""
var varRsize = ""
var varRMcolor = ""
var varRMshape = ""
var varRMsize = ""
var varCupshift = ""

var allTextures = ["res://big_blue_diamond-removebg-preview.png", "res://big_blue_triangle-removebg-preview.png", "res://big_red_circle-removebg-preview.png", "res://big_red_diamond-removebg-preview.png", "res://Big_red_triangle-removebg-preview.png", "res://big_yellow_circle-removebg-preview.png", "res://Big_Yellow_diamond-removebg-preview.png", "res://big_yellow_triangle-removebg-preview.png", "res://Big_Blue_Circle-removebg.png"]
var allColors = ["blue", "blue", "red", "red", "red", "yellow", "yellow", "yellow", "blue"]
var allShapes = ["diamond", "triangle", "circle", "diamond", "triangle", "circle", "diamond", "triangle", "circle"]

############################################################
# Input

export var joy_steering = JOY_ANALOG_LX
#export var steering_mult = -1.0
export var steering_mult = -0.1
export var joy_throttle = JOY_ANALOG_R2
export var throttle_mult = 1.0
export var joy_brake = JOY_ANALOG_L2
export var brake_mult = 1.0

var http_client2

func get_url():
	if OS.has_feature('JavaScript'):
		return JavaScript.eval(""" 
				window.parent.location.href;
			""")
	return null

func get_parameter(param1, param2):
	if OS.has_feature('JavaScript'):
		var curr_url = get_url()
		curr_url = curr_url.split(param1)[1]
		curr_url = curr_url.split(param2)[0]
		return curr_url
	return null
	
func _ready():
	print(get_parameter("Populations/", "/Participants"))
	global.poplnID = get_parameter("Populations/", "/Participants")
	print(get_parameter("/Participants/", "/Sessions/"))
	global.partcnID = get_parameter("/Participants/", "/Sessions/")
	print(get_parameter("/Sessions/", "/Run/"))
	global.sessID = get_parameter("/Sessions/", "/Run/")
	print(get_parameter("/Measures/", "/"))
	global.measrID = get_parameter("/Measures/", "/")
	http_client2 = HTTPClient.new()
	var headers = ["Content-Type: application/json", "x-api-key: 0e89336b-27bc-466b-bebc-03b84ed7cc7b"]
	http_client2.connect_to_host("https://lnpitask.umn.edu")
	while(http_client2.get_status() != 5):
		http_client2.poll()
	http_client2.poll()
	http_client2.request(HTTPClient.METHOD_GET, "/api/v1.0/populations/"+global.poplnID+"/participants/"+global.partcnID+"/configurationproperties", headers)
	http_client2.close()
	#send a configProperties post request here (for default settings) if it comes back with Value-Value as empty
	trialNum = 0
	#nBackIntervalIP is stimulus interval | setIntervalIP is stimulus duration
	fuel = global.strtFuelIP
	speedToMaintain = global.maxSpeedIP
	accToMaintain = global.accelerationIP
	nOfBack = global.nBackIP
	fuelIncrement = global.bonusFuelIP
	nBackInterval = global.nBackIntervalIP
	setInterval = global.nBackIntervalIP
	setN = global.setNIP
	setNExtra = global.setNExtraIP
	stDuration = global.setIntervalIP
	fuelDecrement = global.penaltyIP
	nFlanks = global.nFlankIP
	responseLimit = global.respLimitIP
	upcentre = global.centreShift
	sizeComplexity = global.sizeIP
	if upcentre == 1:
		$"../../Sprite".position.y -= 15
		$"../../Sprite2".position.y -= 15
		$"../../Sprite3".position.y -= 15
		$"../../Sprite6".position.y -= 15
		$"../../Sprite11".position.y -= 15
		varCupshift = "Yes"
	$"../../RichTextLabel".text = "Fuel: "+str(int(fuel))
	$"../../Sprite4".modulate = Color(0,0,0,1)


func _on_Button2_button_down():
	leftBtn = true
	steer_val = 1.0
	if int(totalTime*1000) % 2000 == 0:
		logData("Key Pressed", "leftArrowOnScreen")

func _on_Button3_button_down():
	rightBtn = true
	steer_val = -1.0
	if int(totalTime*1000) % 2000 == 0:
		logData("Key Pressed", "rightArrowOnScreen")
		
func resetJSON():
	varTarget = ""
	varLMcolor = ""
	varLMshape = ""
	varLMsize = ""
	varLcolor = ""
	varLshape = ""
	varLsize = ""
	varCcolor = ""
	varCshape = ""
	varCsize = ""
	varRcolor = ""
	varRshape = ""
	varRsize = ""
	varRMcolor = ""
	varRMshape = ""
	varRMsize = ""

func logData(title, desc):
	global.dict.thisSession[global.dict.thisSession.size()-1].trials.append(global.dict.thisSession[global.dict.thisSession.size()-1].duplicate(true).trials[0])
	var time2 = OS.get_time()
	var time_return2 = String(time2.hour) +":"+String(time2.minute)+":"+String(time2.second)
	global.dict.thisSession[global.dict.thisSession.size()-1].trials[global.dict.thisSession[global.dict.thisSession.size()-1].trials.size()-1].timeStamp = time_return2
	global.dict.thisSession[global.dict.thisSession.size()-1].trials[global.dict.thisSession[global.dict.thisSession.size()-1].trials.size()-1].event = title
	if title != "Stimulus Displayed":
		global.dict.thisSession[global.dict.thisSession.size()-1].trials[global.dict.thisSession[global.dict.thisSession.size()-1].trials.size()-1].eventDesc = desc
	else:
		global.dict.thisSession[global.dict.thisSession.size()-1].trials[global.dict.thisSession[global.dict.thisSession.size()-1].trials.size()-1].eventDesc.target = varTarget
		global.dict.thisSession[global.dict.thisSession.size()-1].trials[global.dict.thisSession[global.dict.thisSession.size()-1].trials.size()-1].eventDesc.leftMost.color = varLMcolor
		global.dict.thisSession[global.dict.thisSession.size()-1].trials[global.dict.thisSession[global.dict.thisSession.size()-1].trials.size()-1].eventDesc.leftMost.shapeDesc = varLMshape
		global.dict.thisSession[global.dict.thisSession.size()-1].trials[global.dict.thisSession[global.dict.thisSession.size()-1].trials.size()-1].eventDesc.leftMost.size = varLMsize
		global.dict.thisSession[global.dict.thisSession.size()-1].trials[global.dict.thisSession[global.dict.thisSession.size()-1].trials.size()-1].eventDesc.rightMost.color = varRMcolor
		global.dict.thisSession[global.dict.thisSession.size()-1].trials[global.dict.thisSession[global.dict.thisSession.size()-1].trials.size()-1].eventDesc.rightMost.shapeDesc = varRMshape
		global.dict.thisSession[global.dict.thisSession.size()-1].trials[global.dict.thisSession[global.dict.thisSession.size()-1].trials.size()-1].eventDesc.rightMost.size = varRMsize
		global.dict.thisSession[global.dict.thisSession.size()-1].trials[global.dict.thisSession[global.dict.thisSession.size()-1].trials.size()-1].eventDesc.left.color = varLcolor
		global.dict.thisSession[global.dict.thisSession.size()-1].trials[global.dict.thisSession[global.dict.thisSession.size()-1].trials.size()-1].eventDesc.left.shapeDesc = varLshape
		global.dict.thisSession[global.dict.thisSession.size()-1].trials[global.dict.thisSession[global.dict.thisSession.size()-1].trials.size()-1].eventDesc.left.size = varLsize
		global.dict.thisSession[global.dict.thisSession.size()-1].trials[global.dict.thisSession[global.dict.thisSession.size()-1].trials.size()-1].eventDesc.right.color = varRcolor
		global.dict.thisSession[global.dict.thisSession.size()-1].trials[global.dict.thisSession[global.dict.thisSession.size()-1].trials.size()-1].eventDesc.right.shapeDesc = varRshape
		global.dict.thisSession[global.dict.thisSession.size()-1].trials[global.dict.thisSession[global.dict.thisSession.size()-1].trials.size()-1].eventDesc.right.size = varRsize
		global.dict.thisSession[global.dict.thisSession.size()-1].trials[global.dict.thisSession[global.dict.thisSession.size()-1].trials.size()-1].eventDesc.centre.upShift = varCupshift
		global.dict.thisSession[global.dict.thisSession.size()-1].trials[global.dict.thisSession[global.dict.thisSession.size()-1].trials.size()-1].eventDesc.centre.color = varCcolor
		global.dict.thisSession[global.dict.thisSession.size()-1].trials[global.dict.thisSession[global.dict.thisSession.size()-1].trials.size()-1].eventDesc.centre.shapeDesc = varCshape
		global.dict.thisSession[global.dict.thisSession.size()-1].trials[global.dict.thisSession[global.dict.thisSession.size()-1].trials.size()-1].eventDesc.centre.size = varCsize
	global.dict.thisSession[global.dict.thisSession.size()-1].trials[global.dict.thisSession[global.dict.thisSession.size()-1].trials.size()-1].totalTimeElapsed = totalTime
	global.dict.thisSession[global.dict.thisSession.size()-1].trials[global.dict.thisSession[global.dict.thisSession.size()-1].trials.size()-1].trialTimeElapsed = currentTrialTime
	global.dict.thisSession[global.dict.thisSession.size()-1].trials[global.dict.thisSession[global.dict.thisSession.size()-1].trials.size()-1].distanceCovered = displacement
	global.dict.thisSession[global.dict.thisSession.size()-1].trials[global.dict.thisSession[global.dict.thisSession.size()-1].trials.size()-1].distFrmCentre = distToPath
	global.dict.thisSession[global.dict.thisSession.size()-1].trials[global.dict.thisSession[global.dict.thisSession.size()-1].trials.size()-1].fuelStatus = fuel
	global.dict.thisSession[global.dict.thisSession.size()-1].trials[global.dict.thisSession[global.dict.thisSession.size()-1].trials.size()-1].timeDriven = points
	global.dict.thisSession[global.dict.thisSession.size()-1].trials[global.dict.thisSession[global.dict.thisSession.size()-1].trials.size()-1].currentTrial = trialNum

func _physics_process(delta):
	$"../../Track/Path/Position3D".global_transform.origin = $".".global_transform.origin
	closestPtPath = ($"../../Track/Path".curve.get_closest_point($"../../Track/Path/Position3D".translation))
	distToPath = closestPtPath.distance_to($"../../Track/Path/Position3D".translation)
	if ($"../../Position3D".translation.distance_to(closestPtPath) < $"../../Position3D".translation.distance_to($"../../Track/Path/Position3D".translation)):
		distToPath *= -1
	if($"left_front".get_rpm() + $"right_front".get_rpm() > 0):
		direction = "forward"
	else:
		direction = "backward"
	if totalTime > global.tLimit:
		get_tree().change_scene("res://Menu.tscn")
	if speed > speedToMaintain:
		throttle_val = 0.0
		if direction == "forward":
			displacement = displacement + (currentPosition - prevPosition).length()
		if direction == "backward":
			displacement = displacement - (currentPosition - prevPosition).length()
	if (fuel > 0.2 and speed > 0.0):
		fuel = fuel - delta
		points = points + delta
	if fuel>0.2 and speed < speedToMaintain:
		#brake_val = 1.0
		if (Input.is_action_pressed("ui_down")):
			displacement = displacement - (currentPosition - prevPosition).length()
			if speed>speedToMaintain:
				throttle_val = accToMaintain
			if speed<speedToMaintain:
				throttle_val = -accToMaintain
			if int(totalTime*1000) % 2000 == 0:
				logData("Key Pressed", "BackArrow")
		else:
			displacement = displacement + (currentPosition - prevPosition).length()
			if speed>speedToMaintain:
				throttle_val = -accToMaintain
			if speed<speedToMaintain:
				throttle_val = accToMaintain
			if int(totalTime*1000) % 2000 == 0:
				logData("No Key Pressed", "CarMovingForward")
	if (fuel <= 0.2 and speed < speedToMaintain):
		if speed > 0.2 and direction == "forward":
			throttle_val = -accToMaintain
			displacement = displacement + (currentPosition - prevPosition).length()
		if speed > 0.2 and direction == "backward":
			throttle_val = accToMaintain
			displacement = displacement - (currentPosition - prevPosition).length()
		if speed < 0.2:
			throttle_val = 0.0
			if direction == "forward":
				displacement = displacement + (currentPosition - prevPosition).length()
			if direction == "backward":
				displacement = displacement - (currentPosition - prevPosition).length()
		#$"../../Ground".visible = false
		#$"..".visible = false
		#$"../../Track".visible = false
		#$"../../Sprite".visible = false
		#$"../../Sprite2".visible = false
		#$"../../Sprite3".visible = false
		#$"../../RichTextLabel".visible = false
		#$"../../RichTextLabel2".visible = true
	totalTime = totalTime + delta
	currentTrialTime = currentTrialTime + delta
	$"../../RichTextLabel".text = "Fuel: "+str(int(fuel))
	$"../../RichTextLabel3".text = "Time Driven: "+str(int(points))
	$"../../RichTextLabel4".text = "Time Elapsed: "+str(int(totalTime))
	$"../../RichTextLabel5".text = "Distance Covered: "+str(int(displacement))
	if global.taskIP == 0:
		if ((int(totalTime+stDuration) % (nBackInterval+stDuration)) == 0 and executed == 0 and totalTime > 2.0):
			trialNum += 1
			if sizeComplexity == 1:
				rngN7.randomize()
				if (rngN7.randi_range(0,1) == 1):
					$"../../Sprite".scale.y = 0.1
					$"../../Sprite".scale.x = 0.1
				rngN7.randomize()
				if (rngN7.randi_range(0,1) == 1):
					$"../../Sprite2".scale.y = 0.075
					$"../../Sprite2".scale.x = 0.075
				rngN7.randomize()
				if (rngN7.randi_range(0,1) == 1):
					$"../../Sprite3".scale.y = 0.075
					$"../../Sprite3".scale.x = 0.075
				rngN7.randomize()
				if (rngN7.randi_range(0,1) == 1):
					$"../../Sprite5".scale.y = 0.075
					$"../../Sprite5".scale.x = 0.075
				rngN7.randomize()
				if (rngN7.randi_range(0,1) == 1):
					$"../../Sprite6".scale.y = 0.075
					$"../../Sprite6".scale.x = 0.075
				rngN7.randomize()
				if (rngN7.randi_range(0,1) == 1):
					$"../../Sprite7".scale.y = 0.075
					$"../../Sprite7".scale.x = 0.075
				rngN7.randomize()
				if (rngN7.randi_range(0,1) == 1):
					$"../../Sprite8".scale.y = 0.035
					$"../../Sprite8".scale.x = 0.035
				rngN7.randomize()
				if (rngN7.randi_range(0,1) == 1):
					$"../../Sprite9".scale.y = 0.035
					$"../../Sprite9".scale.x = 0.035
				rngN7.randomize()
				if (rngN7.randi_range(0,1) == 1):
					$"../../Sprite10".scale.y = 0.035
					$"../../Sprite10".scale.x = 0.035
				rngN7.randomize()
				if (rngN7.randi_range(0,1) == 1):
					$"../../Sprite11".scale.y = 0.035
					$"../../Sprite11".scale.x = 0.035
				rngN7.randomize()
				if (rngN7.randi_range(0,1) == 1):
					$"../../Sprite12".scale.y = 0.035
					$"../../Sprite12".scale.x = 0.035
			currentTrialTime = 0
			rng.randomize()
			var numRand = rng.randi_range(1, 3)
			if numRand == 1:
				$"../../Sprite".visible = true
				arrayNBACK.push_front(1)
				arrayNBACK.pop_back()
				varCshape = "Charge"
				if $"../../Sprite".scale.x < 0.15:
					varCsize = "half"
			elif numRand == 2:
				$"../../Sprite2".visible = true
				arrayNBACK.push_front(2)
				arrayNBACK.pop_back()
				varCshape = "OutwardArrows"
				if $"../../Sprite2".scale.x < 0.1:
					varCsize = "half"
			elif numRand == 3:
				$"../../Sprite3".visible = true
				arrayNBACK.push_front(3)
				arrayNBACK.pop_back()
				varCshape = "StopSign"
				if $"../../Sprite3".scale.x < 0.1:
					varCsize = "half"
			varTarget = "Charge"
			logData("Stimulus Displayed", "")
			executed = 1
		if ((int(totalTime) % (nBackInterval+stDuration)) == 0 and executed == 1):
			executed = 0
			$"../../Sprite".scale.y = 0.1*2
			$"../../Sprite".scale.x = 0.1*2
			$"../../Sprite2".scale.y = 0.075*2
			$"../../Sprite2".scale.x = 0.075*2
			$"../../Sprite3".scale.y = 0.075*2
			$"../../Sprite3".scale.x = 0.075*2
			$"../../Sprite5".scale.y = 0.075*2
			$"../../Sprite5".scale.x = 0.075*2
			$"../../Sprite6".scale.y = 0.075*2
			$"../../Sprite6".scale.x = 0.075*2
			$"../../Sprite7".scale.y = 0.075*2
			$"../../Sprite7".scale.x = 0.075*2
			$"../../Sprite8".scale.y = 0.035*2
			$"../../Sprite8".scale.x = 0.035*2
			$"../../Sprite9".scale.y = 0.035*2
			$"../../Sprite9".scale.x = 0.035*2
			$"../../Sprite10".scale.y = 0.035*2
			$"../../Sprite10".scale.x = 0.035*2
			$"../../Sprite11".scale.y = 0.035*2
			$"../../Sprite11".scale.x = 0.035*2
			$"../../Sprite12".scale.y = 0.035*2
			$"../../Sprite12".scale.x = 0.035*2
			$"../../Sprite".visible = false
			$"../../Sprite2".visible = false
			$"../../Sprite3".visible = false
			logData("Stimulus Hidden", "NA")
			resetJSON()
		if (Input.is_action_pressed("fKey") or Input.is_action_pressed("jKey")) and hitExec == 0:
			if currentTrialTime <= responseLimit * stDuration / 100:
				if (arrayNBACK[nOfBack] == 1 and ($"../../Sprite".visible == true or $"../../Sprite2".visible == true or $"../../Sprite3".visible == true)):
					fuel = fuel + fuelIncrement
					$"../../Sprite4".modulate = Color(0,1,0,1)
					logData("Left or Right Response key pressed", "Correct")
				else:
					if fuel <= fuelDecrement:
						fuel = 0
					else:
						fuel = fuel - fuelDecrement
					logData("Left or Right Response key pressed", "Incorrect")
					$"../../Sprite4".modulate = Color(1,0,0,1)
			else:
				$"../../Sprite4".modulate = Color(1,1,1,1)
				logData("Left or Right Response key pressed", "Late")
			hitExec = 1
		if ($"../../Sprite".visible != true and $"../../Sprite2".visible != true and $"../../Sprite3".visible != true):
			hitExec = 0
			$"../../Sprite4".modulate = Color(0,0,0,1)
	if global.taskIP == 1:
		if ((int(totalTime+stDuration) % (nBackInterval+stDuration)) == 0 and executedSet == 0 and totalTime > 2.0):
			var stimStr = ""
			trialNum += 1
			if sizeComplexity == 1:
				rngN7.randomize()
				if (rngN7.randi_range(0,1) == 1):
					$"../../Sprite".scale.y = 0.1
					$"../../Sprite".scale.x = 0.1
				rngN7.randomize()
				if (rngN7.randi_range(0,1) == 1):
					$"../../Sprite2".scale.y = 0.075
					$"../../Sprite2".scale.x = 0.075
				rngN7.randomize()
				if (rngN7.randi_range(0,1) == 1):
					$"../../Sprite3".scale.y = 0.075
					$"../../Sprite3".scale.x = 0.075
				rngN7.randomize()
				if (rngN7.randi_range(0,1) == 1):
					$"../../Sprite5".scale.y = 0.075
					$"../../Sprite5".scale.x = 0.075
					varLsize = "half"
				rngN7.randomize()
				if (rngN7.randi_range(0,1) == 1):
					$"../../Sprite6".scale.y = 0.075
					$"../../Sprite6".scale.x = 0.075
					varCsize = "half"
				rngN7.randomize()
				if (rngN7.randi_range(0,1) == 1):
					$"../../Sprite7".scale.y = 0.075
					$"../../Sprite7".scale.x = 0.075
					varRsize = "half"
				rngN7.randomize()
				if (rngN7.randi_range(0,1) == 1):
					$"../../Sprite8".scale.y = 0.035
					$"../../Sprite8".scale.x = 0.035
				rngN7.randomize()
				if (rngN7.randi_range(0,1) == 1):
					$"../../Sprite9".scale.y = 0.035
					$"../../Sprite9".scale.x = 0.035
				rngN7.randomize()
				if (rngN7.randi_range(0,1) == 1):
					$"../../Sprite10".scale.y = 0.035
					$"../../Sprite10".scale.x = 0.035
				rngN7.randomize()
				if (rngN7.randi_range(0,1) == 1):
					$"../../Sprite11".scale.y = 0.035
					$"../../Sprite11".scale.x = 0.035
				rngN7.randomize()
				if (rngN7.randi_range(0,1) == 1):
					$"../../Sprite12".scale.y = 0.035
					$"../../Sprite12".scale.x = 0.035
			currentTrialTime = 0
			if countSet%setN == 0:
				rngN2.randomize()
				numRandCentral = rngN2.randi_range(0, 8)
				$"../../Sprite6".texture = load(allTextures[numRandCentral])
			varCcolor = allColors[numRandCentral]
			varCshape = allShapes[numRandCentral]
			rngN3.randomize()
			var numLeft = rngN3.randi_range(0, 8)
			rngN4.randomize()
			var numRight = rngN4.randi_range(0, 8)
			if countSet%setNExtra == 0:
				setToggle += 1
			if setToggle % 2 == 0:
				varTarget = "Shape"
				while (allShapes[numRandCentral] != allShapes[numLeft] || allColors[numRandCentral] == allColors[numLeft]):
					rngN3.randomize()
					numLeft = rngN3.randi_range(0, 8)
			else:
				varTarget = "Color"
				while (allShapes[numRandCentral] == allShapes[numLeft] || allColors[numRandCentral] != allColors[numLeft]):
					rngN3.randomize()
					numLeft = rngN3.randi_range(0, 8)
			while (allShapes[numRandCentral] == allShapes[numRight] || allColors[numRandCentral] == allColors[numRight]):
				rngN4.randomize()
				numRight = rngN4.randi_range(0, 8)
			rngN5.randomize()
			if (rngN5.randi_range(0, 1) == 0):
				$"../../Sprite5".texture = load(allTextures[numLeft])
				$"../../Sprite7".texture = load(allTextures[numRight])
				varLcolor = allColors[numLeft]
				varLshape = allShapes[numLeft]
				varRcolor = allColors[numRight]
				varRshape = allShapes[numRight]
				correectAnswerSet = "left"
				stimStr = allTextures[numLeft] + " " + allTextures[numRandCentral] + " " + allTextures[numRight]
			else:
				$"../../Sprite5".texture = load(allTextures[numRight])
				$"../../Sprite7".texture = load(allTextures[numLeft])
				varLcolor = allColors[numRight]
				varLshape = allShapes[numRight]
				varRcolor = allColors[numLeft]
				varRshape = allShapes[numLeft]
				correectAnswerSet = "right"
				stimStr = allTextures[numRight] + " " + allTextures[numRandCentral] + " " + allTextures[numLeft]
			$"../../Sprite5".visible = true
			$"../../Sprite6".visible = true
			$"../../Sprite7".visible = true
			executedSet = 1
			countSet += 1
			logData("Stimulus Displayed", "")
		if ((int(totalTime) % (nBackInterval+stDuration)) == 0 and executedSet == 1):
			executedSet = 0
			$"../../Sprite".scale.y = 0.1*2
			$"../../Sprite".scale.x = 0.1*2
			$"../../Sprite2".scale.y = 0.075*2
			$"../../Sprite2".scale.x = 0.075*2
			$"../../Sprite3".scale.y = 0.075*2
			$"../../Sprite3".scale.x = 0.075*2
			$"../../Sprite5".scale.y = 0.075*2
			$"../../Sprite5".scale.x = 0.075*2
			$"../../Sprite6".scale.y = 0.075*2
			$"../../Sprite6".scale.x = 0.075*2
			$"../../Sprite7".scale.y = 0.075*2
			$"../../Sprite7".scale.x = 0.075*2
			$"../../Sprite8".scale.y = 0.035*2
			$"../../Sprite8".scale.x = 0.035*2
			$"../../Sprite9".scale.y = 0.035*2
			$"../../Sprite9".scale.x = 0.035*2
			$"../../Sprite10".scale.y = 0.035*2
			$"../../Sprite10".scale.x = 0.035*2
			$"../../Sprite11".scale.y = 0.035*2
			$"../../Sprite11".scale.x = 0.035*2
			$"../../Sprite12".scale.y = 0.035*2
			$"../../Sprite12".scale.x = 0.035*2
			$"../../Sprite5".visible = false
			$"../../Sprite6".visible = false
			$"../../Sprite7".visible = false
			logData("Stimulus Hidden", "NA")
			resetJSON()
		if Input.is_action_pressed("fKey") and hitExec == 0:
			if currentTrialTime <= responseLimit * stDuration / 100:
				if (correectAnswerSet == "left" and ($"../../Sprite5".visible == true and $"../../Sprite6".visible == true and $"../../Sprite7".visible == true)):
					fuel = fuel + fuelIncrement
					$"../../Sprite4".modulate = Color(0,1,0,1)
					logData("Left Response key pressed", "Correct")
				else:
					if fuel <= fuelDecrement:
						fuel = 0
					else:
						fuel = fuel - fuelDecrement
					$"../../Sprite4".modulate = Color(1,0,0,1)
					logData("Left Response key pressed", "Incorrect")
			else:
				$"../../Sprite4".modulate = Color(1,1,1,1)
				logData("Left Response key pressed", "Late")
			hitExec = 1
		if Input.is_action_pressed("jKey") and hitExec == 0:
			if currentTrialTime <= responseLimit * stDuration / 100:
				if (correectAnswerSet == "right" and ($"../../Sprite5".visible == true and $"../../Sprite6".visible == true and $"../../Sprite7".visible == true)):
					fuel = fuel + fuelIncrement
					$"../../Sprite4".modulate = Color(0,1,0,1)
					logData("Right Response key pressed", "Correct")
				else:
					if fuel <= fuelDecrement:
						fuel = 0
					else:
						fuel = fuel - fuelDecrement
					$"../../Sprite4".modulate = Color(1,0,0,1)
					logData("Right Response key pressed", "Incorrect")
			else:
				$"../../Sprite4".modulate = Color(1,1,1,1)
				logData("Right Response key pressed", "Late")
			hitExec = 1
		if ($"../../Sprite5".visible != true and $"../../Sprite6".visible != true and $"../../Sprite7".visible != true):
			hitExec = 0
			$"../../Sprite4".modulate = Color(0,0,0,1)
	if global.taskIP == 2:
		if ((int(totalTime+stDuration) % (nBackInterval+stDuration)) == 0 and executed == 0 and totalTime > 2.0):
			var stimStr = ""
			trialNum += 1
			if sizeComplexity == 1:
				rngN7.randomize()
				if (rngN7.randi_range(0,1) == 1):
					$"../../Sprite".scale.y = 0.1
					$"../../Sprite".scale.x = 0.1
				rngN7.randomize()
				if (rngN7.randi_range(0,1) == 1):
					$"../../Sprite2".scale.y = 0.075
					$"../../Sprite2".scale.x = 0.075
				rngN7.randomize()
				if (rngN7.randi_range(0,1) == 1):
					$"../../Sprite3".scale.y = 0.075
					$"../../Sprite3".scale.x = 0.075
				rngN7.randomize()
				if (rngN7.randi_range(0,1) == 1):
					$"../../Sprite5".scale.y = 0.075
					$"../../Sprite5".scale.x = 0.075
				rngN7.randomize()
				if (rngN7.randi_range(0,1) == 1):
					$"../../Sprite6".scale.y = 0.075
					$"../../Sprite6".scale.x = 0.075
				rngN7.randomize()
				if (rngN7.randi_range(0,1) == 1):
					$"../../Sprite7".scale.y = 0.075
					$"../../Sprite7".scale.x = 0.075
				rngN7.randomize()
				if (rngN7.randi_range(0,1) == 1):
					$"../../Sprite8".scale.y = 0.035
					$"../../Sprite8".scale.x = 0.035
					varRMsize = "half"
				rngN7.randomize()
				if (rngN7.randi_range(0,1) == 1):
					$"../../Sprite9".scale.y = 0.035
					$"../../Sprite9".scale.x = 0.035
					varLMsize = "half"
				rngN7.randomize()
				if (rngN7.randi_range(0,1) == 1):
					$"../../Sprite10".scale.y = 0.035
					$"../../Sprite10".scale.x = 0.035
					varLsize = "half"
				rngN7.randomize()
				if (rngN7.randi_range(0,1) == 1):
					$"../../Sprite11".scale.y = 0.035
					$"../../Sprite11".scale.x = 0.035
					varCsize = "half"
				rngN7.randomize()
				if (rngN7.randi_range(0,1) == 1):
					$"../../Sprite12".scale.y = 0.035
					$"../../Sprite12".scale.x = 0.035
					varRsize = "half"
			currentTrialTime = 0
			$"../../Sprite11".visible = true
			rngN6.randomize()
			if (rngN6.randi_range(0, 1) == 0):
				$"../../Sprite11".scale.x = -1 * $"../../Sprite11".scale.x
			if (int(100*$"../../Sprite11".scale.x) >= 0):
				correectAnswerSet = "right"
				varTarget = ">"
				varCshape = ">"
				stimStr = "arrow pointing right with " + str(nFlanks) + " flanks on either side"
			else:
				correectAnswerSet = "left"
				varTarget = "<"
				varCshape = "<"
				stimStr = "arrow pointing left with " + str(nFlanks) + " flanks on either side"
			if nFlanks >= 1:
				varLshape = ">"
				varRshape = ">"
				rngN6.randomize()
				if (rngN6.randi_range(0, 1) == 0):
					$"../../Sprite10".scale.x = -1 * $"../../Sprite10".scale.x
					varLshape = "<"
				rngN6.randomize()
				if (rngN6.randi_range(0, 1) == 0):
					$"../../Sprite12".scale.x = -1 * $"../../Sprite12".scale.x
					varRshape = "<"
				$"../../Sprite10".visible = true
				$"../../Sprite12".visible = true
			if nFlanks >= 2:
				varLMshape = ">"
				varRMshape = ">"
				rngN6.randomize()
				if (rngN6.randi_range(0, 1) == 0):
					$"../../Sprite9".scale.x = -1 * $"../../Sprite9".scale.x
					varLMshape = "<"
				rngN6.randomize()
				if (rngN6.randi_range(0, 1) == 0):
					$"../../Sprite8".scale.x = -1 * $"../../Sprite8".scale.x
					varRMshape = "<"
				$"../../Sprite9".visible = true
				$"../../Sprite8".visible = true
			executed = 1
			logData("Stimulus Displayed", "")
		if ((int(totalTime) % (nBackInterval+stDuration)) == 0 and executed == 1):
			executed = 0
			$"../../Sprite".scale.y = 0.1*2
			$"../../Sprite".scale.x = 0.1*2
			$"../../Sprite2".scale.y = 0.075*2
			$"../../Sprite2".scale.x = 0.075*2
			$"../../Sprite3".scale.y = 0.075*2
			$"../../Sprite3".scale.x = 0.075*2
			$"../../Sprite5".scale.y = 0.075*2
			$"../../Sprite5".scale.x = 0.075*2
			$"../../Sprite6".scale.y = 0.075*2
			$"../../Sprite6".scale.x = 0.075*2
			$"../../Sprite7".scale.y = 0.075*2
			$"../../Sprite7".scale.x = 0.075*2
			$"../../Sprite8".scale.y = 0.035*2
			$"../../Sprite8".scale.x = 0.035*2
			$"../../Sprite9".scale.y = 0.035*2
			$"../../Sprite9".scale.x = 0.035*2
			$"../../Sprite10".scale.y = 0.035*2
			$"../../Sprite10".scale.x = 0.035*2
			$"../../Sprite11".scale.y = 0.035*2
			$"../../Sprite11".scale.x = 0.035*2
			$"../../Sprite12".scale.y = 0.035*2
			$"../../Sprite12".scale.x = 0.035*2
			$"../../Sprite9".visible = false
			$"../../Sprite10".visible = false
			$"../../Sprite11".visible = false
			$"../../Sprite12".visible = false
			$"../../Sprite8".visible = false
			logData("Stimulus Hidden", "NA")
			resetJSON()
		if Input.is_action_pressed("fKey") and hitExec == 0:
			if currentTrialTime <= responseLimit * stDuration / 100:
				if (correectAnswerSet == "left" and ($"../../Sprite11".visible == true)):
					fuel = fuel + fuelIncrement
					$"../../Sprite4".modulate = Color(0,1,0,1)
					logData("Left Response key pressed", "Correct")
				else:
					if fuel <= fuelDecrement:
						fuel = 0
					else:
						fuel = fuel - fuelDecrement
					$"../../Sprite4".modulate = Color(1,0,0,1)
					logData("Left Response key pressed", "Incorrect")
			else:
				$"../../Sprite4".modulate = Color(1,1,1,1)
				logData("Left Response key pressed", "Late")
			hitExec = 1
		if Input.is_action_pressed("jKey") and hitExec == 0:
			if currentTrialTime <= responseLimit * stDuration / 100:
				if (correectAnswerSet == "right" and ($"../../Sprite11".visible == true)):
					fuel = fuel + fuelIncrement
					$"../../Sprite4".modulate = Color(0,1,0,1)
					logData("Right Response key pressed", "Correct")
				else:
					if fuel <= fuelDecrement:
						fuel = 0
					else:
						fuel = fuel - fuelDecrement
					$"../../Sprite4".modulate = Color(1,0,0,1)
					logData("Right Response key pressed", "Incorrect")
			else:
				$"../../Sprite4".modulate = Color(1,1,1,1)
				logData("Right Response key pressed", "Late")
			hitExec = 1
		if ($"../../Sprite11".visible != true):
			hitExec = 0
			$"../../Sprite4".modulate = Color(0,0,0,1)

	#var steer_val = steering_mult * Input.get_joy_axis(0, joy_steering)
	#var throttle_val = throttle_mult * Input.get_joy_axis(0, joy_throttle)
	#var brake_val = brake_mult * Input.get_joy_axis(0, joy_brake)

	# overrules for keyboard
	#if Input.is_action_pressed("ui_up"):
		#throttle_val = 1.0
	if Input.is_action_pressed("ui_left"):
		steer_val = 1.0
		if int(totalTime*1000) % 2000 == 0:
			logData("Key Pressed", "leftArrow")
	elif Input.is_action_pressed("ui_right"):
		steer_val = -1.0
		if int(totalTime*1000) % 2000 == 0:
			logData("Key Pressed", "rightArrow")

	engine_force = throttle_val * MAX_ENGINE_FORCE
	brake = brake_val * MAX_BRAKE_FORCE
	
	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right") or leftBtn == true or rightBtn == true:
		steer_target = steer_val * MAX_STEER_ANGLE
		if (steer_target < steer_angle):
			steer_angle -= steer_speed * delta
			if (steer_target > steer_angle):
				steer_angle = steer_target
		elif (steer_target > steer_angle):
			steer_angle += steer_speed * delta
			if (steer_target < steer_angle):
				steer_angle = steer_target
	else:
		steer_angle = 0
	
	steering = steer_angle
	
	prevPosition = currentPosition
	currentPosition = $".".translation
	velocity = (currentPosition - prevPosition)/delta
	oldSpeed = speed
	speed = velocity.length()

func _on_Button_pressed():
	logData("Button Pressed", "BackButton")
	get_tree().change_scene("res://Menu.tscn")



func _on_Button2_button_up():
	steer_angle = 0
	leftBtn = false
func _on_Button3_button_up():
	steer_angle = 0
	rightBtn = false


func _on_Button4_button_down():
	if global.taskIP == 0 and hitExec == 0:
		if currentTrialTime <= responseLimit * stDuration / 100:
			if (arrayNBACK[nOfBack] == 1 and ($"../../Sprite".visible == true or $"../../Sprite2".visible == true or $"../../Sprite3".visible == true)):
				fuel = fuel + fuelIncrement
				$"../../Sprite4".modulate = Color(0,1,0,1)
				logData("Left Screen Response key pressed", "Correct")
			else:
				if fuel <= fuelDecrement:
					fuel = 0
				else:
					fuel = fuel - fuelDecrement
				$"../../Sprite4".modulate = Color(1,0,0,1)
				logData("Left Screen Response key pressed", "Incorrect")
		else:
			$"../../Sprite4".modulate = Color(1,1,1,1)
			logData("Left Screen Response key pressed", "Late")
		hitExec = 1
	if global.taskIP == 1 and hitExec == 0:
		if currentTrialTime <= responseLimit * stDuration / 100:
			if (correectAnswerSet == "left" and ($"../../Sprite5".visible == true and $"../../Sprite6".visible == true and $"../../Sprite7".visible == true)):
				fuel = fuel + fuelIncrement
				$"../../Sprite4".modulate = Color(0,1,0,1)
				logData("Left Screen Response key pressed", "Correct")
			else:
				if fuel <= fuelDecrement:
					fuel = 0
				else:
					fuel = fuel - fuelDecrement
				$"../../Sprite4".modulate = Color(1,0,0,1)
				logData("Left Screen Response key pressed", "Incorrect")
		else:
			$"../../Sprite4".modulate = Color(1,1,1,1)
			logData("Left Screen Response key pressed", "Late")
		hitExec = 1
	if global.taskIP == 2 and hitExec == 0:
		if currentTrialTime <= responseLimit * stDuration / 100:
			if (correectAnswerSet == "left" and ($"../../Sprite11".visible == true)):
				fuel = fuel + fuelIncrement
				$"../../Sprite4".modulate = Color(0,1,0,1)
				logData("Left Screen Response key pressed", "Correct")
			else:
				if fuel <= fuelDecrement:
					fuel = 0
				else:
					fuel = fuel - fuelDecrement
				$"../../Sprite4".modulate = Color(1,0,0,1)
				logData("Left Screen Response key pressed", "Incorrect")
		else:
			$"../../Sprite4".modulate = Color(1,1,1,1)
			logData("Left Screen Response key pressed", "Late")
		hitExec = 1

func _on_Button5_button_down():
	if global.taskIP == 0 and hitExec == 0:
		if currentTrialTime <= responseLimit * stDuration / 100:
			if (arrayNBACK[nOfBack] == 1 and ($"../../Sprite".visible == true or $"../../Sprite2".visible == true or $"../../Sprite3".visible == true)):
				fuel = fuel + fuelIncrement
				$"../../Sprite4".modulate = Color(0,1,0,1)
				logData("Right Screen Response key pressed", "Correct")
			else:
				if fuel <= fuelDecrement:
					fuel = 0
				else:
					fuel = fuel - fuelDecrement
				$"../../Sprite4".modulate = Color(1,0,0,1)
				logData("Right Screen Response key pressed", "Incorrect")
		else:
			$"../../Sprite4".modulate = Color(1,1,1,1)
			logData("Right Screen Response key pressed", "Late")
		hitExec = 1
	if global.taskIP == 1 and hitExec == 0:
		if currentTrialTime <= responseLimit * stDuration / 100:
			if (correectAnswerSet == "right" and ($"../../Sprite5".visible == true and $"../../Sprite6".visible == true and $"../../Sprite7".visible == true)):
				fuel = fuel + fuelIncrement
				$"../../Sprite4".modulate = Color(0,1,0,1)
				logData("Right Screen Response key pressed", "Correct")
			else:
				if fuel <= fuelDecrement:
					fuel = 0
				else:
					fuel = fuel - fuelDecrement
				$"../../Sprite4".modulate = Color(1,0,0,1)
				logData("Right Screen Response key pressed", "Incorrect")
		else:
			$"../../Sprite4".modulate = Color(1,1,1,1)
			logData("Right Screen Response key pressed", "Late")
		hitExec = 1
	if global.taskIP == 2 and hitExec == 0:
		if currentTrialTime <= responseLimit * stDuration / 100:
			if (correectAnswerSet == "right" and ($"../../Sprite11".visible == true)):
				fuel = fuel + fuelIncrement
				$"../../Sprite4".modulate = Color(0,1,0,1)
				logData("Right Screen Response key pressed", "Correct")
			else:
				if fuel <= fuelDecrement:
					fuel = 0
				else:
					fuel = fuel - fuelDecrement
				$"../../Sprite4".modulate = Color(1,0,0,1)
				logData("Right Screen Response key pressed", "Incorrect")
		else:
			$"../../Sprite4".modulate = Color(1,1,1,1)
			logData("Right Screen Response key pressed", "Late")
		hitExec = 1
