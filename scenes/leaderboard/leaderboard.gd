extends Control


func _ready() -> void:
	send_data()


func send_data():
	var api_url: String = SettingsManager.get_setting("api_url")
	$HTTPRequest.request_completed.connect(_on_request_completed)
	$HTTPRequest.request(api_url + "/get_leaderboard")


func _on_request_completed(result, response_code, headers, body):
	if result != HTTPRequest.RESULT_SUCCESS or response_code != 200:
		var popup := YesNoPopup.instantiate(self)
		popup.title = tr("END_SCREEN_SEND_TITLE")
		popup.text = tr("END_SCREEN_RESEND_PROMPT")

		var popup_return: PopupReturnValue = await popup.closed

		if popup_return.data:
			send_data()
		else:
			SceneManager.change_scene("main_menu")

		return

	var json = JSON.parse_string(body.get_string_from_utf8())
	print(json)

	for entry in json:
		var e: LeaderboardEntry = ObjectManager.instantiate(ObjectManager.OBJ_LEADERBOARD_ENTRY)
		e.setup(entry)
		%Entries.add_child(e)
