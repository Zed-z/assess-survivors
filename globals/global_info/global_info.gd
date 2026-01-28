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

const game_all: int = GameSummary.GAMETIME

const online_all: int =\
	OnlineSummary.BETTER_THAN_PERCENTILE |\
	OnlineSummary.AVG_RISK |\
	OnlineSummary.RISKIER_THAN_PERCENT |\
	OnlineSummary.LESS_RISKY_THAN_PERCENT |\
	OnlineSummary.RANK

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
}

enum OnlineSummary {
	BETTER_THAN_SCORE = 1 << 0,
	BETTER_THAN_PERCENTILE = 1 << 1,
	AVG_RISK = 1 << 2,
	RISKIER_THAN_PERCENT = 1 << 3,
	LESS_RISKY_THAN_PERCENT = 1 << 4,
	RANK = 1 << 5,
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
		return_string += tr("SUMMARY_MOST_RISKY_STAT") % tr(assess_manager.criteria[most_risky].criterion_name) + "\n"

	if has_flag(assess_summary, AssessSummary.LEAST_RISKY):
		var least_risky = assess_manager.criteria.find_custom(func(x): return x.risk_factor == assess_risks.max())
		return_string += tr("SUMMARY_LEAST_RISKY_STAT") % tr(assess_manager.criteria[least_risky].criterion_name) + "\n"

	if has_flag(assess_summary, AssessSummary.MOST_WEIGHT):
		var most_weight = assess_manager.criteria.find_custom(func(x): return x.weight == assess_weights.max())
		return_string += tr("SUMMARY_MOST_WEIGHED_STAT") % tr(assess_manager.criteria[most_weight].criterion_name) + "\n"

	if has_flag(assess_summary, AssessSummary.LEAST_WEIGHT):
		var least_weight = assess_manager.criteria.find_custom(func(x): return x.weight == assess_weights.min())
		return_string += tr("SUMMARY_LEAST_WEIGHED_STAT") % tr(assess_manager.criteria[least_weight].criterion_name) + "\n"

	if has_flag(assess_summary, AssessSummary.QUESTION_ANSWERED_TOTAL):
		return_string += tr("SUMMARY_ANSWER_COUNT") % question_answered + "\n"

	if has_flag(game_summary, GameSummary.GAMETIME):
		return_string += tr("SUMMARY_GAME_TIME") % float_to_time_string(game_time) + "\n"

	return return_string


func float_to_time_string(time: float) -> String:
	var _min: float = floor(time / 60.0)
	var _sec: float = int(floor(time)) % 60
	return "%02d:%02d" % [_min, _sec]


func append_online(online_summary: int, response) -> String:
	var return_string = ""

	if has_flag(online_summary, OnlineSummary.RANK):
		return_string += tr("SUMMARY_ONLINE_RANK") % response["rank"] + "\n"

	if has_flag(online_summary, OnlineSummary.BETTER_THAN_SCORE):
		return_string += tr("SUMMARY_ONLINE_BETTER_THAN_COUNT") % response["less_score_count"] + "\n"

	if has_flag(online_summary, OnlineSummary.BETTER_THAN_PERCENTILE):
		return_string += tr("SUMMARY_ONLINE_BETTER_THAN_PERCENT") % (response["score_percentile"] * 100) + "\n"

	if has_flag(online_summary, OnlineSummary.AVG_RISK):
		return_string += tr("SUMMARY_ONLINE_MEAN_RISKINESS") % response["avgerage_riskiness"] + "\n"

	if has_flag(online_summary, OnlineSummary.RISKIER_THAN_PERCENT):
		return_string += tr("SUMMARY_ONLINE_RISKIER_THAN_PERCENT") % response["more_riskiness_percentile"] + "\n"

	if has_flag(online_summary, OnlineSummary.LESS_RISKY_THAN_PERCENT):
		return_string += tr("SUMMARY_ONLINE_LESS_RISKY_THAN_PERCENT") % response["less_riskiness_percentile"] + "\n"

	return return_string
