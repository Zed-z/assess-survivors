extends Control
class_name EndScreen


func _ready() -> void:
	get_tree().paused = true

	%LabelScore.text = tr("END_SCREEN_SCORE_COUNTER") % GlobalInfo.score_manager.score


func _exit_tree() -> void:
	get_tree().paused = false


func _on_button_assess_info_pressed() -> void:
	var s: AssessInfoPanel = ObjectManager.instantiate(ObjectManager.OBJ_ASSESS_INFO_PANEL)
	s.assess_manager = GlobalInfo.assess_manager
	get_parent().add_child(s)


func send_data():
	var request: Dictionary = {
		"playerName": "Player",
		"score": GlobalInfo.score_manager.score,
		"won": true,
		"stats": []
	}

	for s: BaseStat in GlobalInfo.player.stats.values():
		if s is not AssessStat:
			continue

		var stat: AssessStat = s as AssessStat
		request["stats"].append({
			"name": stat.name,
			"value": stat.value,
			"weight": 0,#stat.criterion.weight,
			"riskiness": stat.criterion.risk_factor
		})

	var json = JSON.stringify(request)
	print(json)
	var headers = ["Content-Type: application/json"]
	$HTTPRequest.request("http://localhost:3000/register_results", headers, HTTPClient.METHOD_POST, json)
	$HTTPRequest.request_completed.connect(_on_request_completed)


func _on_request_completed(result, response_code, headers, body):
	if response_code != 200:
		%ButtonSubmit.disabled = false

	var json = JSON.parse_string(body.get_string_from_utf8())
	print(json)

	%LabelNotes.text = "\n".join(json["notes"])


func _on_button_2_pressed() -> void:
	%ButtonSubmit.disabled = true
	send_data()
