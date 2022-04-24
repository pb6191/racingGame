extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var rng3 = RandomNumberGenerator.new()
var http_client
var dataString = {"filename": "", "filedata":""}
var headers
var response
var rb = PoolByteArray()
var rb2 = PoolByteArray()
var http_client2
var response2
var maxID = -1
var extracted_measrTypeID


func makeid(length):
	var result           = ''
	var characters       = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'
	var charactersLength = characters.length() - 1
	for i in length:
		rng3.randomize()
		result += characters[rng3.randi_range(0, charactersLength)]
	return result

func _make_post_request(url, data_to_send):
	# Add 'Content-Type' header:
	if global.url == "":
		headers = ["Content-Type: application/json", "x-api-key: 0e89336b-27bc-466b-bebc-03b84ed7cc7b"]
		http_client.connect_to_host("https://lnpitask.umn.edu")
	else:
		headers = ["Content-Type: application/json"]
		http_client.connect_to_host(global.url)
	while(http_client.get_status() != 5):
		http_client.poll()
	http_client.poll()
		# Convert data to json string:
	var query = JSON.print(data_to_send)
	if url == "":
		http_client.request(HTTPClient.METHOD_GET, "/api/v1.0/sessions/"+global.sessID+"/measures/"+global.measrID, headers)
		#http_client.request(HTTPClient.METHOD_GET, "/api/v1.0/sessions/3897/measures/6795", headers)
		while(http_client.get_status() != 7):
			http_client.poll()
			#print("Waiting..body")
			yield(Engine.get_main_loop(), "idle_frame")
		while(http_client.get_status() == 7):
			http_client.poll()
			#print("Requesting..body")
			yield(Engine.get_main_loop(), "idle_frame")
			rb += http_client.read_response_body_chunk()
		response = parse_json(rb.get_string_from_ascii())
		extracted_measrTypeID = response["measureTypeId"]
		response["json"]=query
		var resp1 = JSON.print(response)
		http_client.request(HTTPClient.METHOD_PUT, "/api/v1.0/sessions/"+global.sessID+"/measures/"+global.measrID, headers, resp1)
		while(http_client.get_status() != 7):
			http_client.poll()
			#print("Waiting..body")
			yield(Engine.get_main_loop(), "idle_frame")
		#send a configProperties post/put? request here (for updated settings-if auto setting/difficulty change)
		if global.autoDifficulty != 1:
			if OS.has_feature('JavaScript'):
				JavaScript.eval(""" 
						let message = {
							_guid: "",
							_type: "MESSAGETYPE.ACTION",
							_value: ""
						};
						window.parent.postMessage(JSON.stringify(message), '*');
					""")
	else:
		http_client.request(HTTPClient.METHOD_POST, url, headers, query)
	http_client.close()


# Called when the node enters the scene tree for the first time.
func _ready():
	http_client = HTTPClient.new()
	http_client.read_chunk_size = 40960
	global.url = ""
	global.endpt = ""
	dataString.filename = "dataFile_subject_"+str(global.partcnID)+"_session_"+str(global.sessID)+".json"
	dataString.filedata = (global.dict)
	_make_post_request(global.endpt, dataString)
	if global.autoDifficulty == 1:
		$"Button".visible = true
		var travelcut = global.threshold * global.json_result[global.task][global.levelSet[global.task]]["maxdistance"]
		if global.travelled >= travelcut:
			if global.task == "flanker":
				if global.levelSet[global.task] == "0a":
					global.levelSet[global.task] = "0b"
				elif global.levelSet[global.task] == "0b":
					global.levelSet[global.task] = "1"
				elif global.levelSet[global.task] == "1":
					global.levelSet[global.task] = "2"
				elif global.levelSet[global.task] == "2":
					$"RichTextLabel4".visible = true
					$"Button".visible = false
				elif global.levelSet[global.task] == "3a":
					global.levelSet[global.task] = "3c"
				elif global.levelSet[global.task] == "3b":
					global.levelSet[global.task] = "3c"
				elif global.levelSet[global.task] == "3c":
					global.levelSet[global.task] = "4"
				elif global.levelSet[global.task] == "4":
					global.levelSet[global.task] = "5"
				elif global.levelSet[global.task] == "5":
					$"RichTextLabel5".visible = true
					$"Button".visible = false
				elif global.levelSet[global.task] == "6a":
					global.levelSet[global.task] = "6c"
				elif global.levelSet[global.task] == "6b":
					global.levelSet[global.task] = "6c"
				elif global.levelSet[global.task] == "6c":
					global.levelSet[global.task] = "7"
			if global.task == "nback" or global.task == "realnback" or global.task == "setshift":
				if global.levelSet[global.task] == "0a":
					global.levelSet[global.task] = "0b"
				elif global.levelSet[global.task] == "0b":
					global.levelSet[global.task] = "1"
				elif global.levelSet[global.task] == "1":
					global.levelSet[global.task] = "2"
				elif global.levelSet[global.task] == "2":
					$"RichTextLabel".visible = true
					$"Button".visible = false
				elif global.levelSet[global.task] == "3a":
					global.levelSet[global.task] = "3c"
				elif global.levelSet[global.task] == "3b":
					global.levelSet[global.task] = "3c"
				elif global.levelSet[global.task] == "3c":
					global.levelSet[global.task] = "4"
				elif global.levelSet[global.task] == "4":
					global.levelSet[global.task] = "5"
				elif global.levelSet[global.task] == "5":
					$"RichTextLabel2".visible = true
					$"Button".visible = false
				elif global.levelSet[global.task] == "6a":
					global.levelSet[global.task] = "6c"
				elif global.levelSet[global.task] == "6b":
					global.levelSet[global.task] = "6c"
				elif global.levelSet[global.task] == "6c":
					global.levelSet[global.task] = "7"
				elif global.levelSet[global.task] == "7":
					global.levelSet[global.task] = "8"
				elif global.levelSet[global.task] == "8":
					$"RichTextLabel3".visible = true
					$"Button".visible = false
				elif global.levelSet[global.task] == "9a":
					global.levelSet[global.task] = "9c"
				elif global.levelSet[global.task] == "9b":
					global.levelSet[global.task] = "9c"
				elif global.levelSet[global.task] == "9c":
					global.levelSet[global.task] = "10"
				elif global.levelSet[global.task] == "10":
					global.levelSet[global.task] = "11"
				elif global.levelSet[global.task] == "11":
					global.levelSet[global.task] = "12"
				elif global.levelSet[global.task] == "12":
					global.levelSet[global.task] = "13"
				elif global.levelSet[global.task] == "13":
					global.levelSet[global.task] = "14"
				elif global.levelSet[global.task] == "14":
					global.levelSet[global.task] = "15"
				elif global.levelSet[global.task] == "15":
					global.levelSet[global.task] = "16"
				elif global.levelSet[global.task] == "16":
					global.levelSet[global.task] = "17"



func _input(ev):
	if $"RichTextLabel".visible == true and ev is InputEventKey and ev.scancode == KEY_G and not ev.echo:
		global.levelSet[global.task] = "3a"
		$"RichTextLabel".visible = false
		$"Button".visible = true
	if $"RichTextLabel".visible == true and ev is InputEventKey and ev.scancode == KEY_H and not ev.echo:
		global.levelSet[global.task] = "3b"
		$"RichTextLabel".visible = false
		$"Button".visible = true
	if $"RichTextLabel2".visible == true and ev is InputEventKey and ev.scancode == KEY_G and not ev.echo:
		global.levelSet[global.task] = "6a"
		$"RichTextLabel2".visible = false
		$"Button".visible = true
	if $"RichTextLabel2".visible == true and ev is InputEventKey and ev.scancode == KEY_H and not ev.echo:
		global.levelSet[global.task] = "6b"
		$"RichTextLabel2".visible = false
		$"Button".visible = true
	if $"RichTextLabel3".visible == true and ev is InputEventKey and ev.scancode == KEY_G and not ev.echo:
		global.levelSet[global.task] = "9a"
		$"RichTextLabel3".visible = false
		$"Button".visible = true
	if $"RichTextLabel3".visible == true and ev is InputEventKey and ev.scancode == KEY_H and not ev.echo:
		global.levelSet[global.task] = "9b"
		$"RichTextLabel3".visible = false
		$"Button".visible = true
	if $"RichTextLabel4".visible == true and ev is InputEventKey and ev.scancode == KEY_G and not ev.echo:
		global.levelSet[global.task] = "3a"
		$"RichTextLabel4".visible = false
		$"Button".visible = true
	if $"RichTextLabel4".visible == true and ev is InputEventKey and ev.scancode == KEY_H and not ev.echo:
		global.levelSet[global.task] = "3b"
		$"RichTextLabel4".visible = false
		$"Button".visible = true
	if $"RichTextLabel5".visible == true and ev is InputEventKey and ev.scancode == KEY_G and not ev.echo:
		global.levelSet[global.task] = "6a"
		$"RichTextLabel5".visible = false
		$"Button".visible = true
	if $"RichTextLabel5".visible == true and ev is InputEventKey and ev.scancode == KEY_H and not ev.echo:
		global.levelSet[global.task] = "6b"
		$"RichTextLabel5".visible = false
		$"Button".visible = true
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
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
		rb2 += http_client2.read_response_body_chunk()
	response2 = parse_json(rb2.get_string_from_ascii())
	#for element in response2:
	#	if element["id"] > maxID:
	#		maxID = element["id"]
	#extracted_measrTypeID = maxID
	var sendDict = {"key": "0e89336b-27bc-466b-bebc-03b84ed7cc7b", "measureTypeId": extracted_measrTypeID, "populationId": global.poplnID, "userId": global.partcnID, "value": JSON.print(global.levelSet)}
	http_client2.request(HTTPClient.METHOD_POST, "/api/v1.0/populations/"+global.poplnID+"/participants/"+global.partcnID+"/configurationproperties", headers, JSON.print(sendDict))
	while(http_client2.get_status() != 7):
		http_client2.poll()
		#print("Waiting..body")
		yield(Engine.get_main_loop(), "idle_frame")
	http_client2.close()
	global.current_round +=1
	if global.current_round >= global.rounds:
		if OS.has_feature('JavaScript'):
			JavaScript.eval(""" 
					let message = {
						_guid: "",
						_type: "MESSAGETYPE.ACTION",
						_value: ""
					};
					window.parent.postMessage(JSON.stringify(message), '*');
				""")
	else:
		get_tree().change_scene("res://Starting.tscn")
