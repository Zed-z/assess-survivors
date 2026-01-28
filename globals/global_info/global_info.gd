extends Node

var player: Player
var combat_ui_overlay: UIOverley
var enemy_spawner: EnemySpawner
var assess_manager: AssessManagerClass
var projectile_holder: ProjectileHolder
var score_manager: ScoreManager
var game_camera: GameCamera
var gameplay_scene: GameplayScene

var game_time: float

const assess_all: int = AssessSummary.MOST_RISKY |\
 AssessSummary.LEAST_RISKY |\
 AssessSummary.MOST_WEIGHT |\
 AssessSummary.LEAST_WEIGHT

const game_all: int = GameSummary.GAMETIME |\
 GameSummary.SCORETOTAL

const online_all: int =	OnlineSummary.BETTER_THAN_SCORE |\
 OnlineSummary.BETTER_THAN_PERCENTILE |\
 OnlineSummary.AVG_RISK |\
 OnlineSummary.RISKIER_THAN |\
 OnlineSummary.CAUTIOUS_THAN |\
 OnlineSummary.RISK_PERCINTILE

const flag_none: int = 0

enum AssessSummary {
	MOST_RISKY = 1 << 0,
	LEAST_RISKY = 1 << 1,
	MOST_WEIGHT = 1 << 2,
	LEAST_WEIGHT = 1 << 3,
	QUESTION_ANSWERED_TOTAL = 1 << 4
	}
enum GameSummary {
	GAMETIME = 1 << 0,
	SCORETOTAL = 1 << 1
}

enum OnlineSummary {
	BETTER_THAN_SCORE = 1 << 0,
	BETTER_THAN_PERCENTILE = 1 << 1,
	AVG_RISK = 1 << 2,
	RISKIER_THAN = 1 << 3,
	CAUTIOUS_THAN = 1 << 4,
	RISK_PERCINTILE = 1 << 5
}


func has_flag(all, flag):
	return(all & flag) != 0


func write_summary(assess_summary: int, game_summary: int, smart_mode: bool = true):
	var return_string: String = ""
	var assess_weights: Array[float] = []
	var assess_risks: Array[float] = []
	var question_answered: int = 0

	for c in assess_manager.criteria:
		assess_weights.append(c.weight)
		assess_risks.append(c.risk_factor)
		question_answered += c.METRIC_question_answered

	question_answered += assess_manager.METRIC_weight_question_count

	if smart_mode:
		if abs(assess_weights.min() - assess_weights.max()) < 0.01:
			assess_summary ^= AssessSummary.MOST_WEIGHT | AssessSummary.LEAST_WEIGHT

		if abs(assess_risks.min() - assess_risks.max()) < 0.01:
			assess_summary ^= AssessSummary.MOST_RISKY | AssessSummary.LEAST_RISKY

	#TODO translate
	if has_flag(assess_summary, AssessSummary.MOST_RISKY):
		var most_risky = assess_manager.criteria.find_custom(func(x): return x.risk_factor == assess_risks.min())
		return_string += "Your most risky stat: "
		return_string += tr(assess_manager.criteria[most_risky].criterion_name)
		return_string += "\n"

	if has_flag(assess_summary, AssessSummary.LEAST_RISKY):
		var least_risky = assess_manager.criteria.find_custom(func(x): return x.risk_factor == assess_risks.max())
		return_string += "Your least risky stat: "
		return_string += tr(assess_manager.criteria[least_risky].criterion_name)
		return_string += "\n"

	if has_flag(assess_summary, AssessSummary.MOST_WEIGHT):
		var most_weight = assess_manager.criteria.find_custom(func(x): return x.weight == assess_weights.max())
		return_string += "Your most weighted stat: "
		return_string += tr(assess_manager.criteria[most_weight].criterion_name)
		return_string += "\n"

	if has_flag(assess_summary, AssessSummary.LEAST_WEIGHT):
		var least_weight = assess_manager.criteria.find_custom(func(x): return x.weight == assess_weights.min())
		return_string += "Your least weighted stat: "
		return_string += tr(assess_manager.criteria[least_weight].criterion_name)
		return_string += "\n"

	if has_flag(assess_summary, AssessSummary.QUESTION_ANSWERED_TOTAL):
		return_string += "Total answered (1st phase): "
		return_string += str(question_answered)
		return_string += "\n"

	if has_flag(game_summary, GameSummary.GAMETIME):
		return_string += "Your game time: "
		return_string += float_to_time_string(game_time)
		return_string += "\n"

	if has_flag(game_summary, GameSummary.SCORETOTAL):
		return_string += "Your score: "
		return_string += str(score_manager.score)
		return_string += "\n"

	return return_string


func float_to_time_string(time: float) -> String:
	var time_string = ""

	if (time / 60.0) >= 1:
		time_string = str(floori(time / 60.0)) + "m " + "0.2f" % (time - (floori(time / 60.0) * 60)) + "s"
	else:
		time_string = 	("%0.2f" % time)

		time_string += "s"

	return time_string


func append_online(online_summary: int, response) -> String:
	var return_string = ""

	if has_flag(online_summary, OnlineSummary.BETTER_THAN_SCORE):
		return_string += "you were better than: "
		return_string += str(int(response["less_score_count"]))
		return_string += " of players\n"

	if has_flag(online_summary, OnlineSummary.BETTER_THAN_PERCENTILE):
		return_string += "you were in top: "
		return_string += "%0.2f" % (response["score_percentile"] * 100)
		return_string += "%"
		return_string += " of players\n"

	if has_flag(online_summary, OnlineSummary.AVG_RISK):
		return_string += "Your mean risk was: "
		return_string += str(response["avgerage_riskiness"])
		return_string += "\n"

	if has_flag(online_summary, OnlineSummary.RISKIER_THAN):
		return_string += "You were riskier than: "
		return_string += str(int(response["more_riskiness_count"]))
		return_string += " of players\n"

	if has_flag(online_summary, OnlineSummary.CAUTIOUS_THAN):
		return_string += "You were more cautious than: "
		return_string += str(int(response["less_riskiness_count"]))
		return_string += " of players\n"

	if has_flag(online_summary, OnlineSummary.RISK_PERCINTILE):
		return_string += "You were in top: "
		return_string += "%0.2f" % (response["riskiness_percentile"] * 100)
		return_string += "%"
		return_string += " of risky players\n"

	return return_string
