extends Control
class_name EndScreen


func _ready() -> void:
	PauseManager.pause()

	%LabelScore.text = tr("END_SCREEN_SCORE_COUNTER") % GlobalInfo.score_manager.score
	var test_value1: int = 0
	var test_value2: int = 0
	%LabelNotes.text = GlobalInfo.write_summary(GlobalInfo.assess_all, GlobalInfo.GameSummary.GAMETIME, 0)

	prompt_send_data()


func _exit_tree() -> void:
	PauseManager.unpause()


func _on_button_assess_info_pressed() -> void:
	var s: AssessInfoPanel = ObjectManager.instantiate(ObjectManager.OBJ_ASSESS_INFO_PANEL)
	s.assess_manager = GlobalInfo.assess_manager
	get_parent().add_child(s)


func prompt_send_data(resend: bool = false) -> void:
	var popup := YesNoPopup.instantiate(self)
	popup.title = tr("END_SCREEN_SEND_TITLE")

	if resend:
		popup.text = tr("END_SCREEN_RESEND_PROMPT")
	else:
		popup.text = tr("END_SCREEN_SEND_PROMPT")

	var popup_return: PopupReturnValue = await popup.closed

	if popup_return.data:
		send_data()


func send_data():

	var popup := TextInputPopup.instantiate(self)
	popup.title = tr("END_SCREEN_SEND_TITLE")
	popup.text = tr("END_SCREEN_USERNAME_PROMPT")
	var popup_return: PopupReturnValue = await popup.closed
	var player_name: String = popup_return.data

	var request: Dictionary = {
		"playerName": player_name,
		"score": GlobalInfo.score_manager.score,
		"stats": []
	}

	for s: BaseStat in GlobalInfo.player.stats.values():
		if s is not AssessStat:
			continue

		var stat: AssessStat = s as AssessStat
		request["stats"].append({
			"name": stat.name,
			"value": stat.value,
			"weight": stat.criterion.weight,
			"riskiness": stat.criterion.risk_factor
		})

	var json = JSON.stringify(request)
	var api_url: String = SettingsManager.get_setting("api_url")
	var headers = ["Content-Type: application/json"]
	$HTTPRequest.request(api_url + "/register_results", headers, HTTPClient.METHOD_POST, json)
	$HTTPRequest.request_completed.connect(_on_request_completed)


func _on_request_completed(result, response_code, headers, body):
	if result != HTTPRequest.RESULT_SUCCESS or response_code != 200:
		prompt_send_data(true)
		return

	var json = JSON.parse_string(body.get_string_from_utf8())
	print("\t\tFULL JSON")
	print(json)

	%LabelNotes.text += GlobalInfo.append_online(GlobalInfo.online_all, json)
	print("\n\n\t\tLABEL TEXT")
	print(%LabelNotes.text)
