extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var rng3 = RandomNumberGenerator.new()
var http_client
var dataString = {"filename": "", "filedata":""}
var headers
var response
var rb = PoolByteArray()

# Called when the node enters the scene tree for the first time.
func _ready():
	http_client = HTTPClient.new()
	http_client.read_chunk_size = 40960

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

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
			print("Waiting..body")
			yield(Engine.get_main_loop(), "idle_frame")
		while(http_client.get_status() == 7):
			http_client.poll()
			print("Requesting..body")
			yield(Engine.get_main_loop(), "idle_frame")
			rb += http_client.read_response_body_chunk()
		response = parse_json(rb.get_string_from_ascii())
		response["json"]=query
		var resp1 = JSON.print(response)
		http_client.request(HTTPClient.METHOD_PUT, "/api/v1.0/sessions/"+global.sessID+"/measures/"+global.measrID, headers, resp1)
		while(http_client.get_status() != 7):
			http_client.poll()
			print("Waiting..body")
			yield(Engine.get_main_loop(), "idle_frame")
		#send a configProperties post/put? request here (for updated settings-if auto setting/difficulty change)
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

func _on_Button2_pressed():
	global.url = $"../OptionButton17".text
	global.endpt = $"../OptionButton18".text
	dataString.filename = "dataFile_"+makeid(16)+".json"
	dataString.filedata = (global.dict)
	_make_post_request(global.endpt, dataString)
