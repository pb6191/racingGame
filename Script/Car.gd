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
var rngN8 = RandomNumberGenerator.new()
var rngN9 = RandomNumberGenerator.new()
var rngN11 = RandomNumberGenerator.new()
var rngN12 = RandomNumberGenerator.new()
var rngN13 = RandomNumberGenerator.new()
var rngN14 = RandomNumberGenerator.new()
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
var setNOrig
var setNExtraOrig
var countSet = 0
var numRandCentral
var numRandCentralColor
var numRandCentralLine
var numRandCentralPattern

var numRandLeft
var numRandLeftColor
var numRandLeftLine
var numRandLeftPattern
var numRandRight
var numRandRightColor
var numRandRightLine
var numRandRightPattern

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
var variationsArr = []
var matchArr = []
var unmatchArr = []
var prevMoreMatchArr = []
var lessmatchArr = []
var lessunmatchArr = []

var varTarget = ""
var varLMcolor = ""
var varLMshape = ""
var varLMsize = ""
var varLcolor = ""
var varLshape = ""
var varLline = ""
var varLpattern = ""
var varLsize = ""
var varCcolor = ""
var varCshape = ""
var varCline = ""
var varCpattern = ""
var varCsize = ""
var varRcolor = ""
var varRshape = ""
var varRline = ""
var varRpattern = ""
var varRsize = ""
var varRMcolor = ""
var varRMshape = ""
var varRMsize = ""
var varCupshift = ""

# read these settings from json per team feedback
var allVariations = "color,shape,line,pattern"
var moreMatch = 3
var lessMatch = 2

#var allVariations = "color,shape"
#var moreMatch = 1
#var lessMatch = 0

var defaultColor = "blue"
var defaultShape = "circle"
var defaultLine = "none"
var defaultPattern = "none"

var allTextures = ["res://shape-circle.png", "res://shape-diamond.png", "res://shape-triangle.png"]
var allSingleB = ["res://singleB-circle.png", "res://singleB-diamond.png", "res://singleB-triangle.png"]
var allDoubleB = ["res://doubleB-circle.png", "res://doubleB_diamond.png", "res://doubleB-triangle.png"]
var allDots = ["res://dots-circle.png", "res://dots-diamond.png", "res://dots-triangle.png"]
var allGrids = ["res://grid-circle.png", "res://grid-diamond.png", "res://grid-triangle.png"]
var allShapes = ["circle", "diamond", "triangle"]

var allColors = ["blue", "red", "green"]

############################################################
# Input

export var joy_steering = JOY_ANALOG_LX
#export var steering_mult = -1.0
export var steering_mult = -0.1
export var joy_throttle = JOY_ANALOG_R2
export var throttle_mult = 1.0
export var joy_brake = JOY_ANALOG_L2
export var brake_mult = 1.0


	
func _ready():
	trialNum = 0
	#nBackIntervalIP is stimulus interval | setIntervalIP is stimulus duration
	fuel = global.strtFuelIP
	speedToMaintain = global.maxSpeedIP
	accToMaintain = global.accelerationIP
	nOfBack = global.nBackIP
	fuelIncrement = global.bonusFuelIP
	nBackInterval = global.nBackIntervalIP
	setInterval = global.nBackIntervalIP
	setNOrig = global.setNIP
	setNExtraOrig = global.setNExtraIP
	setN = setNOrig
	setNExtra = setNExtraOrig
	stDuration = global.setIntervalIP
	fuelDecrement = global.penaltyIP
	nFlanks = global.nFlankIP
	responseLimit = global.respLimitIP
	upcentre = global.centreShift
	sizeComplexity = global.sizeIP
	print(global.taskIP)
	if global.taskIP == -2:
		$"../../Sprite".position.y = -400
		$"../../Sprite2".position.y = -400
		$"../../Sprite3".position.y = -400
		$"../../Sprite4".position.y = -400
		$"../../Sprite5".position.y = -400
		$"../../Sprite6".position.y = -400
		$"../../Sprite7".position.y = -400
		$"../../Sprite8".position.y = -400
		$"../../Sprite9".position.y = -400
		$"../../Sprite10".position.y = -400
		$"../../Sprite11".position.y = -400
		$"../../Sprite12".position.y = -400
	if accToMaintain == -1:
		$"../../Ground".visible = false
		$"../../Sun".visible = false
		$"..".visible = false
		$"../../Camera".visible = false
		$"../../Track".visible = false
		$"../../RichTextLabel".visible = false
		$"../../RichTextLabel3".visible = false
		$"../../RichTextLabel5".visible = false
	print(fuel)
	print(speedToMaintain)
	print(accToMaintain)
	print(nOfBack)
	print(fuelIncrement)
	print(nBackInterval)
	print(setInterval)
	print(setN)
	print(setNExtra)
	print(stDuration)
	print(fuelDecrement)
	print(nFlanks)
	print(responseLimit)
	print(upcentre)
	print(sizeComplexity)
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
	varLline = ""
	varLpattern = ""
	varLsize = ""
	varCcolor = ""
	varCshape = ""
	varCline = ""
	varCpattern = ""
	varCsize = ""
	varRcolor = ""
	varRshape = ""
	varRline = ""
	varRpattern = ""
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
		global.dict.thisSession[global.dict.thisSession.size()-1].trials[global.dict.thisSession[global.dict.thisSession.size()-1].trials.size()-1].eventDesc.left.line = varLline
		global.dict.thisSession[global.dict.thisSession.size()-1].trials[global.dict.thisSession[global.dict.thisSession.size()-1].trials.size()-1].eventDesc.left.pattern = varLpattern
		global.dict.thisSession[global.dict.thisSession.size()-1].trials[global.dict.thisSession[global.dict.thisSession.size()-1].trials.size()-1].eventDesc.left.shapeDesc = varLshape
		global.dict.thisSession[global.dict.thisSession.size()-1].trials[global.dict.thisSession[global.dict.thisSession.size()-1].trials.size()-1].eventDesc.left.size = varLsize
		global.dict.thisSession[global.dict.thisSession.size()-1].trials[global.dict.thisSession[global.dict.thisSession.size()-1].trials.size()-1].eventDesc.right.color = varRcolor
		global.dict.thisSession[global.dict.thisSession.size()-1].trials[global.dict.thisSession[global.dict.thisSession.size()-1].trials.size()-1].eventDesc.right.line = varRline
		global.dict.thisSession[global.dict.thisSession.size()-1].trials[global.dict.thisSession[global.dict.thisSession.size()-1].trials.size()-1].eventDesc.right.pattern = varRpattern
		global.dict.thisSession[global.dict.thisSession.size()-1].trials[global.dict.thisSession[global.dict.thisSession.size()-1].trials.size()-1].eventDesc.right.shapeDesc = varRshape
		global.dict.thisSession[global.dict.thisSession.size()-1].trials[global.dict.thisSession[global.dict.thisSession.size()-1].trials.size()-1].eventDesc.right.size = varRsize
		global.dict.thisSession[global.dict.thisSession.size()-1].trials[global.dict.thisSession[global.dict.thisSession.size()-1].trials.size()-1].eventDesc.centre.upShift = varCupshift
		global.dict.thisSession[global.dict.thisSession.size()-1].trials[global.dict.thisSession[global.dict.thisSession.size()-1].trials.size()-1].eventDesc.centre.color = varCcolor
		global.dict.thisSession[global.dict.thisSession.size()-1].trials[global.dict.thisSession[global.dict.thisSession.size()-1].trials.size()-1].eventDesc.centre.line = varCline
		global.dict.thisSession[global.dict.thisSession.size()-1].trials[global.dict.thisSession[global.dict.thisSession.size()-1].trials.size()-1].eventDesc.centre.pattern = varCpattern
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
		if global.taskflowDeploy == 1:
			global.travelled = displacement
			get_tree().change_scene("res://Closing.tscn")
		else:
			global.travelled = displacement
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
		if ((int(totalTime+stDuration) % int(nBackInterval+stDuration)) == 0 and executed == 0 and totalTime > 2.0):
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
		if ((int(totalTime) % int(nBackInterval+stDuration)) == 0 and executed == 1):
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
		if ((int(totalTime+stDuration) % int(nBackInterval+stDuration)) == 0 and executedSet == 0 and totalTime > 2.0):
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
			if int(countSet)%int(setN) == 0:
				$"../../Sprite6".texture = load(allTextures[0])
				$"../../Sprite6".modulate = Color(0,0,1,1)
				$"../../Sprite17".visible = false
				$"../../Sprite23".visible = false

				numRandCentral = 0
				numRandCentralColor = 0
				numRandCentralLine = 0
				numRandCentralPattern = 0

				rngN11.randomize()
				numRandCentral = rngN11.randi_range(0, 2)
				rngN12.randomize()
				numRandCentralColor = rngN12.randi_range(0, 2)
				rngN13.randomize()
				numRandCentralLine = rngN13.randi_range(0, 2) #none, single, double
				rngN14.randomize()
				numRandCentralPattern = rngN14.randi_range(0, 2) #none, dots, grid
				$"../../Sprite6".texture = load(allTextures[numRandCentral])
				if numRandCentralLine == 1 and "line" in allVariations:
					$"../../Sprite23".texture = load(allSingleB[numRandCentral])
				if numRandCentralLine == 2 and "line" in allVariations:
					$"../../Sprite23".texture = load(allDoubleB[numRandCentral])
				if numRandCentralPattern == 1 and "pattern" in allVariations:
					$"../../Sprite17".texture = load(allDots[numRandCentral])
				if numRandCentralPattern == 2 and "pattern" in allVariations:
					$"../../Sprite17".texture = load(allGrids[numRandCentral])
				if numRandCentralColor == 1 and "color" in allVariations:
					$"../../Sprite6".modulate = Color(1,0,0,1)
				if numRandCentralColor == 2 and "color" in allVariations:
					$"../../Sprite6".modulate = Color(0,1,0,1)
				rngN8.randomize()
				setN = setNOrig + rngN8.randi_range(int(-1 * 0.5 * setNOrig), int(1 * 0.5 * setNOrig))
			varCshape = allShapes[numRandCentral]
			if !("color" in allVariations):
				varCcolor = allColors[0]
			if ("color" in allVariations):
				varCcolor = allColors[numRandCentralColor]
			if numRandCentralLine == 0 or !("line" in allVariations):
				varCline = "none"
			if numRandCentralLine == 1 and "line" in allVariations:
				varCline = "singleb"
			if numRandCentralLine == 2 and "line" in allVariations:
				varCline = "doubleb"
			if numRandCentralPattern == 0 or !("pattern" in allVariations):
				varCpattern = "none"
			if numRandCentralPattern == 1 and "pattern" in allVariations:
				varCpattern = "dots"
			if numRandCentralPattern == 2 and "pattern" in allVariations:
				varCpattern = "grids"
			rngN3.randomize()
			var numRandLeft = rngN3.randi_range(0, 2)
			rngN4.randomize()
			var numRandRight = rngN4.randi_range(0, 2)
			if int(countSet)%int(setNExtra) == 0:
				setToggle += 1
				
				matchArr = []
				unmatchArr = []
				lessmatchArr = []
				lessunmatchArr = []
				
				variationsArr = Array(allVariations.split(","))
				variationsArr.shuffle()
				for kk in moreMatch:
					matchArr.append(variationsArr.pop_back())
				matchArr.sort()
				while (prevMoreMatchArr == matchArr):
					matchArr = []
					variationsArr = Array(allVariations.split(","))
					variationsArr.shuffle()
					for ii in moreMatch:
						matchArr.append(variationsArr.pop_back())
					matchArr.sort()
				unmatchArr = variationsArr
				print(matchArr)
				print(unmatchArr)
				
				prevMoreMatchArr = matchArr
				prevMoreMatchArr.sort()

				variationsArr = Array(allVariations.split(","))
				variationsArr.shuffle()
				for jj in lessMatch:
					lessmatchArr.append(variationsArr.pop_back())
				lessunmatchArr = variationsArr
				print(lessmatchArr)
				print(lessunmatchArr)
				
				rngN9.randomize()
				setNExtra = setNExtraOrig + rngN9.randi_range(int(-1 * 0.5 * setNExtraOrig), int(1 * 0.5 * setNExtraOrig))
			if int(setToggle) % 2 == 0 or int(setToggle) % 2 == 1:

				$"../../Sprite5".texture = load(allTextures[0])
				$"../../Sprite5".modulate = Color(0,0,1,1)
				$"../../Sprite16".visible = false
				$"../../Sprite22".visible = false
				$"../../Sprite7".texture = load(allTextures[0])
				$"../../Sprite7".modulate = Color(0,0,1,1)
				$"../../Sprite18".visible = false
				$"../../Sprite24".visible = false
				numRandLeft = 0
				numRandLeftColor = 0
				numRandLeftLine = 0
				numRandLeftPattern = 0
				numRandRight = 0
				numRandRightColor = 0
				numRandRightLine = 0
				numRandRightPattern = 0
				
				varTarget = PoolStringArray(matchArr).join("-")
				if "shape" in matchArr:
					numRandLeft = numRandCentral
				if "shape" in unmatchArr:
					numRandLeft = (randi() % 3)
					while (numRandLeft == numRandCentral):
						numRandLeft = (randi() % 3)
				if "color" in matchArr:
					numRandLeftColor = numRandCentralColor
				if "color" in unmatchArr:
					numRandLeftColor = (randi() % 3)
					while (numRandLeftColor == numRandCentralColor):
						numRandLeftColor = (randi() % 3)
				if "line" in matchArr:
					numRandLeftLine = numRandCentralLine
				if "line" in unmatchArr:
					numRandLeftLine = (randi() % 3)
					while (numRandLeftLine == numRandCentralLine):
						numRandLeftLine = (randi() % 3)
				if "pattern" in matchArr:
					numRandLeftPattern = numRandCentralPattern
				if "pattern" in unmatchArr:
					numRandLeftPattern = (randi() % 3)
					while (numRandLeftPattern == numRandCentralPattern):
						numRandLeftPattern = (randi() % 3)

				if "shape" in lessmatchArr:
					numRandRight = numRandCentral
				if "shape" in lessunmatchArr:
					numRandRight = (randi() % 3)
					while (numRandRight == numRandCentral):
						numRandRight = (randi() % 3)
				if "color" in lessmatchArr:
					numRandRightColor = numRandCentralColor
				if "color" in lessunmatchArr:
					numRandRightColor = (randi() % 3)
					while (numRandRightColor == numRandCentralColor):
						numRandRightColor = (randi() % 3)
				if "line" in lessmatchArr:
					numRandRightLine = numRandCentralLine
				if "line" in lessunmatchArr:
					numRandRightLine = (randi() % 3)
					while (numRandRightLine == numRandCentralLine):
						numRandRightLine = (randi() % 3)
				if "pattern" in lessmatchArr:
					numRandRightPattern = numRandCentralPattern
				if "pattern" in lessunmatchArr:
					numRandRightPattern = (randi() % 3)
					while (numRandRightPattern == numRandCentralPattern):
						numRandRightPattern = (randi() % 3)
				print(matchArr)
				print(unmatchArr)
				print(lessmatchArr)
				print(lessunmatchArr)
				print("numRandCentral")
				print(numRandCentral)
				print("numRandCentralColor")
				print(numRandCentralColor)
				print("numRandCentralLine")
				print(numRandCentralLine)
				print("numRandCentralPattern")
				print(numRandCentralPattern)
				print("numRandLeft")
				print(numRandLeft)
				print("numRandLeftColor")
				print(numRandLeftColor)
				print("numRandLeftLine")
				print(numRandLeftLine)
				print("numRandLeftPattern")
				print(numRandLeftPattern)
				print("numRandRight")
				print(numRandRight)
				print("numRandRightColor")
				print(numRandRightColor)
				print("numRandRightLine")
				print(numRandRightLine)
				print("numRandRightPattern")
				print(numRandRightPattern)
			rngN5.randomize()
			if (rngN5.randi_range(0, 1) == 0):
				$"../../Sprite5".texture = load(allTextures[numRandLeft])
				$"../../Sprite7".texture = load(allTextures[numRandRight])
				if numRandLeftLine == 1:
					$"../../Sprite22".texture = load(allSingleB[numRandLeft])
				if numRandLeftLine == 2:
					$"../../Sprite22".texture = load(allDoubleB[numRandLeft])
				if numRandLeftPattern == 1:
					$"../../Sprite16".texture = load(allDots[numRandLeft])
				if numRandLeftPattern == 2:
					$"../../Sprite16".texture = load(allGrids[numRandLeft])
				if numRandLeftColor == 1:
					$"../../Sprite5".modulate = Color(1,0,0,1)
				if numRandLeftColor == 2:
					$"../../Sprite5".modulate = Color(0,1,0,1)
				if numRandRightLine == 1:
					$"../../Sprite24".texture = load(allSingleB[numRandRight])
				if numRandRightLine == 2:
					$"../../Sprite24".texture = load(allDoubleB[numRandRight])
				if numRandRightPattern == 1:
					$"../../Sprite18".texture = load(allDots[numRandRight])
				if numRandRightPattern == 2:
					$"../../Sprite18".texture = load(allGrids[numRandRight])
				if numRandRightColor == 1:
					$"../../Sprite7".modulate = Color(1,0,0,1)
				if numRandRightColor == 2:
					$"../../Sprite7".modulate = Color(0,1,0,1)
				varLshape = allShapes[numRandLeft]
				varLcolor = allColors[numRandLeftColor]
				if numRandLeftLine == 0:
					varLline = "none"
				if numRandLeftLine == 1:
					varLline = "singleb"
				if numRandLeftLine == 2:
					varLline = "doubleb"
				if numRandLeftPattern == 0:
					varLpattern = "none"
				if numRandLeftPattern == 1:
					varLpattern = "dots"
				if numRandLeftPattern == 2:
					varLpattern = "grids"
				varRshape = allShapes[numRandRight]
				varRcolor = allColors[numRandRightColor]
				if numRandRightLine == 0:
					varRline = "none"
				if numRandRightLine == 1:
					varRline = "singleb"
				if numRandRightLine == 2:
					varRline = "doubleb"
				if numRandRightPattern == 0:
					varRpattern = "none"
				if numRandRightPattern == 1:
					varRpattern = "dots"
				if numRandRightPattern == 2:
					varRpattern = "grids"
				correectAnswerSet = "left"
				stimStr = ""
			else:
				$"../../Sprite7".texture = load(allTextures[numRandLeft])
				$"../../Sprite5".texture = load(allTextures[numRandRight])
				if numRandLeftLine == 1:
					$"../../Sprite24".texture = load(allSingleB[numRandLeft])
				if numRandLeftLine == 2:
					$"../../Sprite24".texture = load(allDoubleB[numRandLeft])
				if numRandLeftPattern == 1:
					$"../../Sprite18".texture = load(allDots[numRandLeft])
				if numRandLeftPattern == 2:
					$"../../Sprite18".texture = load(allGrids[numRandLeft])
				if numRandLeftColor == 1:
					$"../../Sprite7".modulate = Color(1,0,0,1)
				if numRandLeftColor == 2:
					$"../../Sprite7".modulate = Color(0,1,0,1)
				if numRandRightLine == 1:
					$"../../Sprite22".texture = load(allSingleB[numRandRight])
				if numRandRightLine == 2:
					$"../../Sprite22".texture = load(allDoubleB[numRandRight])
				if numRandRightPattern == 1:
					$"../../Sprite16".texture = load(allDots[numRandRight])
				if numRandRightPattern == 2:
					$"../../Sprite16".texture = load(allGrids[numRandRight])
				if numRandRightColor == 1:
					$"../../Sprite5".modulate = Color(1,0,0,1)
				if numRandRightColor == 2:
					$"../../Sprite5".modulate = Color(0,1,0,1)
				varRshape = allShapes[numRandLeft]
				varRcolor = allColors[numRandLeftColor]
				if numRandLeftLine == 0:
					varRline = "none"
				if numRandLeftLine == 1:
					varRline = "singleb"
				if numRandLeftLine == 2:
					varRline = "doubleb"
				if numRandLeftPattern == 0:
					varRpattern = "none"
				if numRandLeftPattern == 1:
					varRpattern = "dots"
				if numRandLeftPattern == 2:
					varRpattern = "grids"
				varLshape = allShapes[numRandRight]
				varLcolor = allColors[numRandRightColor]
				if numRandRightLine == 0:
					varLline = "none"
				if numRandRightLine == 1:
					varLline = "singleb"
				if numRandRightLine == 2:
					varLline = "doubleb"
				if numRandRightPattern == 0:
					varLpattern = "none"
				if numRandRightPattern == 1:
					varLpattern = "dots"
				if numRandRightPattern == 2:
					varLpattern = "grids"
				correectAnswerSet = "right"
				stimStr = ""
			$"../../Sprite5".visible = true
			$"../../Sprite6".visible = true
			$"../../Sprite7".visible = true
			if varLpattern != "none":
				$"../../Sprite16".visible = true
			if varCpattern != "none":
				$"../../Sprite17".visible = true
			if varRpattern != "none":
				$"../../Sprite18".visible = true
			if varLline != "none":
				$"../../Sprite22".visible = true
			if varCline != "none":
				$"../../Sprite23".visible = true
			if varRline != "none":
				$"../../Sprite24".visible = true
			executedSet = 1
			countSet += 1
			logData("Stimulus Displayed", "")
		if ((int(totalTime) % int(nBackInterval+stDuration)) == 0 and executedSet == 1):
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
			$"../../Sprite22".visible = false
			$"../../Sprite23".visible = false
			$"../../Sprite24".visible = false
			$"../../Sprite16".visible = false
			$"../../Sprite17".visible = false
			$"../../Sprite18".visible = false
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
		if ((int(totalTime+stDuration) % int(nBackInterval+stDuration)) == 0 and executed == 0 and totalTime > 2.0):
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
		if ((int(totalTime) % int(nBackInterval+stDuration)) == 0 and executed == 1):
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

# this button would never be visible
func _on_Button_pressed():
	logData("Button Pressed", "BackButton")
	if global.taskflowDeploy == 1:
		get_tree().change_scene("res://Closing.tscn")
	else:
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
