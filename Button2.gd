extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var rng3 = RandomNumberGenerator.new()
var http_client
var dataString = {"filename": "", "filedata":""}

# Called when the node enters the scene tree for the first time.
func _ready():
	http_client = HTTPClient.new()


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
	# Convert data to json string:
	var query = JSON.print(data_to_send)
	# Add 'Content-Type' header:
	var headers = ["Content-Type: application/json"]
	http_client.connect_to_host(global.url)
	while(http_client.get_status() != 5):
		http_client.poll()
	http_client.poll()
	http_client.request(HTTPClient.METHOD_POST, url, headers, query)
	http_client.close()

func _on_Button2_pressed():
	global.url = $"../OptionButton17".text
	global.endpt = $"../OptionButton18".text
	dataString.filename = "dataFile_"+makeid(16)+".json"
	dataString.filedata = (global.dict)
	_make_post_request(global.endpt, dataString)
