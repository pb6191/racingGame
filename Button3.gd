extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var response
var rb = PoolByteArray()
var http_client2
var headers

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

# Called when the node enters the scene tree for the first time.
func _ready():
	if global.taskflowDeploy == 2:
		#print(get_parameter("Populations/", "/Participants"))
		global.poplnID = get_parameter("Populations/", "/Participants")
		#print(get_parameter("/Participants/", "/Sessions/"))
		global.partcnID = get_parameter("/Participants/", "/Sessions/")
		#print(get_parameter("/Sessions/", "/Run/"))
		global.sessID = get_parameter("/Sessions/", "/Run/")
		#print(get_parameter("/Measures/", "/"))
		global.measrID = get_parameter("/Measures/", "/")
		http_client2 = HTTPClient.new()
		http_client2.read_chunk_size = 40960
		headers = ["Content-Type: application/json", "x-api-key: 0e89336b-27bc-466b-bebc-03b84ed7cc7b"]
		http_client2.connect_to_host("https://lnpitask.umn.edu")
		while(http_client2.get_status() != 5):
			http_client2.poll()
		http_client2.poll()
		http_client2.request(HTTPClient.METHOD_GET, "/api/v1.0/populations/"+global.poplnID+"/measuretypes", headers)
		while(http_client2.get_status() != 7):
			http_client2.poll()
			#print("Waiting..body")
			yield(Engine.get_main_loop(), "idle_frame")
		while(http_client2.get_status() == 7):
			http_client2.poll()
			#print("Requesting..body")
			yield(Engine.get_main_loop(), "idle_frame")
			rb += http_client2.read_response_body_chunk()
		#response = parse_json(rb.get_string_from_ascii())

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_Button3_pressed():
	global.currLevel = "manualConfig"
	global.maxSpeedIP = 10 * ($"../OptionButton".selected + 1)
	global.accelerationIP = $"../OptionButton2".selected + 1
	global.nBackIP = $"../OptionButton3".selected
	global.strtFuelIP = 30 * ($"../OptionButton4".selected + 1)
	global.bonusFuelIP = 10 * ($"../OptionButton5".selected + 1)
	global.nBackIntervalIP = $"../OptionButton6".selected + 2
	global.tLimit = 30 * ($"../OptionButton7".selected + 1)
	global.taskIP = $"../OptionButton8".selected
	global.setIntervalIP = (0.5 * $"../OptionButton9".selected) + 0.5
	global.setNIP = 2 + 2*$"../OptionButton10".selected
	global.setNExtraIP = 4 + 4*$"../OptionButton11".selected
	global.penaltyIP = 5*$"../OptionButton12".selected
	global.nFlankIP = $"../OptionButton13".selected
	global.respLimitIP = 100 - (25*$"../OptionButton14".selected)
	global.centreShift = $"../OptionButton15".selected
	global.sizeIP = $"../OptionButton16".selected
	global.allVariationsGlobal = "color,shape"
	global.moreMatchGlobal = 1
	global.lessMatchGlobal = 0
	#global.url = $"../OptionButton17".text
	#global.endpt = $"../OptionButton18".text
	global.measrTypeID = $"../LineEdit".text
	if global.measrTypeID == "":
		global.measrTypeID = 531
	else:
		global.measrTypeID = int(global.measrTypeID)
	global.startScrn = $"../OptionButton19".selected
	#global.dict.thisSession.append(global.dict.duplicate(true).thisSession[0])
	global.dictSet.currLevel = global.currLevel
	global.dictSet.speed = global.maxSpeedIP
	global.dictSet.acc = global.accelerationIP
	global.dictSet.nback = global.nBackIP
	global.dictSet.respLimit = global.respLimitIP
	global.dictSet.startFuel = global.strtFuelIP
	global.dictSet.bonusFuel = global.bonusFuelIP
	global.dictSet.stimInterval = global.nBackIntervalIP
	global.dictSet.timeLimit = global.tLimit
	global.dictSet.task = global.taskIP
	global.dictSet.stimDuration = global.setIntervalIP
	global.dictSet.intraN = global.setNIP
	global.dictSet.extraN = global.setNExtraIP
	global.dictSet.penalty = global.penaltyIP
	global.dictSet.flankerN = global.nFlankIP
	global.dictSet.centreUp = global.centreShift
	global.dictSet.symComplexity = global.sizeIP
	global.dictSet.startScreen = global.startScrn
	global.dictSet.variationStr = global.allVariationsGlobal
	global.dictSet.moreMatch = global.moreMatchGlobal
	global.dictSet.lessMatch = global.lessMatchGlobal
	var sendDict = {"key": "0e89336b-27bc-466b-bebc-03b84ed7cc7b", "measureTypeId": global.measrTypeID, "populationId": global.poplnID, "userId": global.partcnID, "value": JSON.print(global.dictSet)}
	if global.autoDifficulty == 0:
		http_client2.request(HTTPClient.METHOD_POST, "/api/v1.0/populations/"+global.poplnID+"/participants/"+global.partcnID+"/configurationproperties", headers, JSON.print(sendDict))
		while(http_client2.get_status() != 7):
			http_client2.poll()
			#print("Waiting..body")
			yield(Engine.get_main_loop(), "idle_frame")
	http_client2.close()
	if OS.has_feature('JavaScript'):
		JavaScript.eval(""" 
				let message = {
					_guid: "",
					_type: "MESSAGETYPE.ACTION",
					_value: ""
				};
				window.parent.postMessage(JSON.stringify(message), '*');
			""")
	#get_tree().change_scene("res://Main.tscn")

