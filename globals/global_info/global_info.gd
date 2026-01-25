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
const assess_all = AssessSummary.MOST_RISKY | AssessSummary.LEAST_RISKY | AssessSummary.MOST_WEIGHT | AssessSummary.LEAST_WEIGHT
const game_all = GameSummary.GAMETIME | GameSummary.SCORETOTAL
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


func has_flag(all, flag):
	return(all & flag) != 0


func write_summary(assess_summary: int, game_summary: int, smart_mode: bool):
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
		return_string += "%0.2f" % game_time
		return_string += "s\n"

	if has_flag(game_summary, GameSummary.SCORETOTAL):
		return_string += "Your score: "
		return_string += str(score_manager.score)
		return_string += "\n"

	return return_string
