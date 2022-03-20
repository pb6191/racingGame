extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var headers
var http_client2
var response
var jsonSett
var rb = PoolByteArray()
var maxID = -1
var nonDefSett

func get_url():
	if OS.has_feature('JavaScript'):
		return JavaScript.eval(""" 
				window.parent.location.href;
			""")
	return null
	
func assignVals():
	global.dict.thisSession.append(global.dict.duplicate(true).thisSession[0])
	global.dict.thisSession[global.dict.thisSession.size()-1].speed = global.maxSpeedIP
	global.dict.thisSession[global.dict.thisSession.size()-1].acc = global.accelerationIP
	global.dict.thisSession[global.dict.thisSession.size()-1].nback = global.nBackIP
	global.dict.thisSession[global.dict.thisSession.size()-1].respLimit = global.respLimitIP
	global.dict.thisSession[global.dict.thisSession.size()-1].startFuel = global.strtFuelIP
	global.dict.thisSession[global.dict.thisSession.size()-1].bonusFuel = global.bonusFuelIP
	global.dict.thisSession[global.dict.thisSession.size()-1].stimInterval = global.nBackIntervalIP
	global.dict.thisSession[global.dict.thisSession.size()-1].timeLimit = global.tLimit
	global.dict.thisSession[global.dict.thisSession.size()-1].task = global.taskIP
	global.dict.thisSession[global.dict.thisSession.size()-1].stimDuration = global.setIntervalIP
	global.dict.thisSession[global.dict.thisSession.size()-1].intraN = global.setNIP
	global.dict.thisSession[global.dict.thisSession.size()-1].extraN = global.setNExtraIP
	global.dict.thisSession[global.dict.thisSession.size()-1].penalty = global.penaltyIP
	global.dict.thisSession[global.dict.thisSession.size()-1].flankerN = global.nFlankIP
	global.dict.thisSession[global.dict.thisSession.size()-1].centreUp = global.centreShift
	global.dict.thisSession[global.dict.thisSession.size()-1].symComplexity = global.sizeIP
	global.dict.thisSession[global.dict.thisSession.size()-1].variationStr = global.allVariationsGlobal
	global.dict.thisSession[global.dict.thisSession.size()-1].moreMatch = global.moreMatchGlobal
	global.dict.thisSession[global.dict.thisSession.size()-1].lessMatch = global.lessMatchGlobal

func getLevelMapping():
	global.maxSpeedIP = global.json_result[global.task][global.levelSet[global.task]]["speed"]
	global.accelerationIP = global.json_result[global.task][global.levelSet[global.task]]["acc"]
	global.nBackIP = global.json_result[global.task][global.levelSet[global.task]]["nback"]
	global.strtFuelIP = global.json_result[global.task][global.levelSet[global.task]]["startFuel"]
	global.bonusFuelIP = global.json_result[global.task][global.levelSet[global.task]]["bonusFuel"]
	global.nBackIntervalIP = global.json_result[global.task][global.levelSet[global.task]]["stimInterval"]
	global.tLimit = global.json_result[global.task][global.levelSet[global.task]]["timeLimit"]
	global.taskIP = global.json_result[global.task][global.levelSet[global.task]]["task"]
	global.setIntervalIP = global.json_result[global.task][global.levelSet[global.task]]["stimDuration"]
	global.setNIP = global.json_result[global.task][global.levelSet[global.task]]["intraN"]
	global.setNExtraIP = global.json_result[global.task][global.levelSet[global.task]]["extraN"]
	global.penaltyIP = global.json_result[global.task][global.levelSet[global.task]]["penalty"]
	global.nFlankIP = global.json_result[global.task][global.levelSet[global.task]]["flankerN"]
	global.respLimitIP = global.json_result[global.task][global.levelSet[global.task]]["respLimit"]
	global.centreShift = global.json_result[global.task][global.levelSet[global.task]]["centreUp"]
	global.sizeIP = global.json_result[global.task][global.levelSet[global.task]]["symComplexity"]
	global.allVariationsGlobal = global.json_result[global.task][global.levelSet[global.task]]["variations"]
	global.moreMatchGlobal = global.json_result[global.task][global.levelSet[global.task]]["moreMatches"]
	global.lessMatchGlobal = global.json_result[global.task][global.levelSet[global.task]]["lessMatches"]
	global.url = ""
	global.endpt = ""
	global.startScrn = global.json_result[global.task][global.levelSet[global.task]]["startScreen"]

func getDefaults():
	if global.autoDifficulty == 0:
		if maxID == -1:
			global.maxSpeedIP = 10
			global.accelerationIP = 1
			global.nBackIP = 0
			global.strtFuelIP = 60
			global.bonusFuelIP = 30
			global.nBackIntervalIP = 3 + 2
			global.tLimit = 30
			global.taskIP = 0
			global.setIntervalIP = 5.0
			global.setNIP = 2 + 2
			global.setNExtraIP = 4 + 4
			global.penaltyIP = 5*0
			global.nFlankIP = 0
			global.respLimitIP = 100 - (25*0)
			global.centreShift = 1
			global.sizeIP = 0
			global.allVariationsGlobal = "color,shape"
			global.moreMatchGlobal = 1
			global.lessMatchGlobal = 0
			global.url = ""
			global.endpt = ""
			global.startScrn = 0
		else:
			jsonSett = parse_json(nonDefSett)
			global.maxSpeedIP = int(jsonSett["speed"])
			print(global.maxSpeedIP)
			global.accelerationIP = int(jsonSett["acc"])
			print(global.accelerationIP)
			global.nBackIP = int(jsonSett["nback"])
			print(global.nBackIP)
			global.strtFuelIP = int(jsonSett["startFuel"])
			print(global.strtFuelIP)
			global.bonusFuelIP = int(jsonSett["bonusFuel"])
			print(global.bonusFuelIP)
			global.nBackIntervalIP = int(jsonSett["stimInterval"])
			print(global.nBackIntervalIP)
			global.tLimit = int(jsonSett["timeLimit"])
			print(global.tLimit)
			global.taskIP = int(jsonSett["task"])
			print(global.taskIP)
			global.setIntervalIP = float(jsonSett["stimDuration"])
			print(global.setIntervalIP)
			global.setNIP = int(jsonSett["intraN"])
			print(global.setNIP)
			global.setNExtraIP = int(jsonSett["extraN"])
			print(global.setNExtraIP)
			global.penaltyIP = int(jsonSett["penalty"])
			print(global.penaltyIP)
			global.nFlankIP = int(jsonSett["flankerN"])
			print(global.nFlankIP)
			global.respLimitIP = int(jsonSett["respLimit"])
			print(global.respLimitIP)
			global.centreShift = int(jsonSett["centreUp"])
			print(global.centreShift)
			global.sizeIP = int(jsonSett["symComplexity"])
			print(global.sizeIP)
			global.allVariationsGlobal = int(jsonSett["variationStr"])
			print(global.allVariationsGlobal)
			global.moreMatchGlobal = int(jsonSett["moreMatch"])
			print(global.moreMatchGlobal)
			global.lessMatchGlobal = int(jsonSett["lessMatch"])
			print(global.lessMatchGlobal)
			global.url = ""
			global.endpt = ""
			global.startScrn = int(jsonSett["startScreen"])
		if global.changStartScrn == 1:
			global.startScrn = 1
	if global.autoDifficulty == 1:
		if maxID == -1:
			global.levelSet["nback"] = "0a"
			global.levelSet["setshift"] = "0a"
			global.levelSet["flanker"] = "0a"
			global.levelSet["realnback"] = "0a"
			getLevelMapping()
		else:
			jsonSett = parse_json(nonDefSett)
			global.levelSet["nback"] = str(jsonSett["nback"])
			global.levelSet["setshift"] = str(jsonSett["setshift"])
			global.levelSet["flanker"] = str(jsonSett["flanker"])
			global.levelSet["realnback"] = str(jsonSett["realnback"])
			getLevelMapping()
		if global.changStartScrn == 1:
			global.startScrn = 1


func get_parameter(param1, param2):
	if OS.has_feature('JavaScript'):
		var curr_url = get_url()
		curr_url = curr_url.split(param1)[1]
		curr_url = curr_url.split(param2)[0]
		return curr_url
	return null

# Called when the node enters the scene tree for the first time.
func _ready():
	if global.taskflowDeploy == 1:
		print(get_parameter("Populations/", "/Participants"))
		global.poplnID = get_parameter("Populations/", "/Participants")
		print(get_parameter("/Participants/", "/Sessions/"))
		global.partcnID = get_parameter("/Participants/", "/Sessions/")
		print(get_parameter("/Sessions/", "/Run/"))
		global.sessID = get_parameter("/Sessions/", "/Run/")
		print(get_parameter("/Measures/", "/"))
		global.measrID = get_parameter("/Measures/", "/")
		http_client2 = HTTPClient.new()
		http_client2.read_chunk_size = 40960
		headers = ["Content-Type: application/json", "x-api-key: 0e89336b-27bc-466b-bebc-03b84ed7cc7b"]
		http_client2.connect_to_host("https://lnpitask.umn.edu")
		while(http_client2.get_status() != 5):
			http_client2.poll()
		http_client2.poll()
		http_client2.request(HTTPClient.METHOD_GET, "/api/v1.0/populations/"+global.poplnID+"/participants/"+global.partcnID+"/configurationproperties", headers)
		while(http_client2.get_status() != 7):
			http_client2.poll()
			print("Waiting..body")
			yield(Engine.get_main_loop(), "idle_frame")
		while(http_client2.get_status() == 7):
			http_client2.poll()
			print("Requesting..body")
			yield(Engine.get_main_loop(), "idle_frame")
			rb += http_client2.read_response_body_chunk()
		response = parse_json(rb.get_string_from_ascii())
		for element in response:
			if global.autoDifficulty == 0:
				if !("GUID" in element["Value"]):
					if element["Id"] > maxID:
						maxID = element["Id"]
						nonDefSett = element["Value"]
						print(maxID)
			if global.autoDifficulty == 1:
				if (global.racingGUID in element["Value"]) and ("GUID" in element["Value"]) and !("VALUE" in element["Value"]):
					if element["Id"] > maxID:
						maxID = element["Id"]
						nonDefSett = element["Value"]
						print(maxID)
		http_client2.close()
		getDefaults()
		print("TASK1 "+str(global.taskIP))
		print(global.taskIP)
		if global.startScrn == 0:
			$"RichTextLabel".visible = true
			#global.changStartScrn = 1
			print("TASK2 "+str(global.taskIP))
			print(global.taskIP)
		else:
			assignVals()
			print("TASK3 "+str(global.taskIP))
			print(global.taskIP)
			get_tree().change_scene("res://Instr.tscn")
	else:
		get_tree().change_scene("res://Menu.tscn")




	#send a configProperties post request here (for default settings) if it comes back with Value-Value as empty


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _unhandled_input(event):
	if event.is_action_pressed("ui_select") and $"RichTextLabel".visible == true:
		assignVals()
		print("TASK4 "+str(global.taskIP))
		print(global.taskIP)
		get_tree().change_scene("res://Instr.tscn")


