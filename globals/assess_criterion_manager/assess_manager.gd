extends Node2D
class_name AssessManagerClass

@export var algorithm_script: GDScript = preload("res://globals/assess_criterion_manager/assess_decision_algorithm/algorithm_rr.gd")
@export var weight_algorithm_script: GDScript = preload("res://globals/assess_criterion_manager/assess_decision_algorithm/algorithm_rr.gd")
var algorithm: AssessAlgorithm
var weight_algorithm: AssessAlgorithm

@export var criteria: Array[AssessCriterion] = []
var weight_question: Question
var weight_index: int

enum GamePhases {CRITERION, WEIGHTS, FINAL}
var phase: GamePhases = GamePhases.CRITERION


func init_choice_panel() -> ChoicePanel:
	var choice_panel: ChoicePanel = ObjectManager.instantiate(ObjectManager.OBJ_CHOICE_PANEL)

	match phase:
		GamePhases.CRITERION:
			choice_panel.criterion = get_criterion()

			if choice_panel.criterion != null:
				choice_panel.question = choice_panel.criterion.get_question()

				if not SettingsManager.get_setting("tutorial/choice_criterion"):
					SettingsManager.set_setting("tutorial/choice_criterion", true)
					var p := OkPopup.instantiate(choice_panel)
					#TODO: translate
					p.title = "First phase"

					p.text = "Choose your reward!\nYou'll get a bonus for one of your stats."

			else:
				phase = GamePhases.WEIGHTS

		GamePhases.WEIGHTS:
			choice_panel.question = get_weight_question()

			if choice_panel.question != null:
				choice_panel.criterion = get_weight_criterion()

				if not SettingsManager.get_setting("tutorial/choice_weight"):
					SettingsManager.set_setting("tutorial/choice_weight", true)
					var p := OkPopup.instantiate(choice_panel)
					#TODO: translate
					p.title = "Second phase"

					p.text = "Choose your reward!\nYou can choose a certain award,\nor risk it for a boost of every stat!"
			else:
				phase = GamePhases.FINAL

		GamePhases.FINAL:
			#TODO after bairstow
			print("achived third phase")
			var l = get_most_u_on_all()
			choice_panel.question = Question.new(MultiLottery.new(l,1,l),MultiLottery.new(l,1,l))
			choice_panel.criterion = criteria[0]

			if not SettingsManager.get_setting("tutorial/choice_final"):
					SettingsManager.set_setting("tutorial/choice_final", true)
					var p := OkPopup.instantiate(choice_panel)
					#TODO: translate
					p.title = "Final phase"

					p.text = "Choose your reward!\nNow there are many choices that affect everything!\nThe game will assist you in making a decision\nbased on your previous choices."

	choice_panel.phase = phase
	return choice_panel


func _ready() -> void:
	GlobalInfo.assess_manager = self

	algorithm = algorithm_script.new(criteria)
	algorithm.weight = false
	weight_algorithm = weight_algorithm_script.new(criteria)
	weight_algorithm.weight = true

	for criterion: AssessCriterion in criteria:
		register_criterion(criterion)


func display_choice(criterion: AssessCriterion) -> String:
	return criterion.question._to_string()


func init_add_criterion(stat: AssessStat, criterion: AssessCriterion):
	criteria.append(criterion)
	criterion.criterion_name = stat.name
	criterion.icon = stat.icon
	register_criterion(criterion)


func register_criterion(criterion: AssessCriterion) -> void:
	algorithm = algorithm_script.new(criteria)
	weight_algorithm = weight_algorithm_script.new(criteria)
	weight_algorithm.weight = true
	criterion.setup()


func get_criterion() -> AssessCriterion:
	var val = algorithm.decide()

	if val >= 0:
		return criteria[val]
	else:
		return null


func get_least_u_on_all() -> Dictionary[AssessCriterion, float]:
	var dictionary: Dictionary[AssessCriterion, float] = {}

	for c in criteria:
		dictionary[c] = c.point_list[0].x

	return dictionary


func get_most_u_on_all()-> Dictionary[AssessCriterion, float]:
	var dictionary: Dictionary[AssessCriterion, float] = {}

	for c in criteria:
		dictionary[c] = c.point_list[-1].x

	return dictionary


func get_most_u_on_criterion(criterion_name: String)-> Dictionary[AssessCriterion, float]:
	var dictionary: Dictionary[AssessCriterion, float] = {}

	for c in criteria:

		if c.criterion_name == criterion_name:
			dictionary[c] = c.point_list[-1].x
		else:
			dictionary[c] = c.point_list[0].x

	return dictionary


func get_weight_question() -> Question:
	weight_index = weight_algorithm.decide()

	if weight_index == -1:
		return null
	else:
		criteria[weight_index].METRIC_count_weight += 1

	var win_val_right: Dictionary[AssessCriterion, float] = get_most_u_on_all()
	var loss_val_both: Dictionary[AssessCriterion, float] = get_least_u_on_all()
	var win_val_left: Dictionary[AssessCriterion, float] = get_most_u_on_criterion(criteria[weight_index].criterion_name)

	var left_lottery: MultiLottery = MultiLottery.new(win_val_left, 1, loss_val_both)
	var right_lottery: MultiLottery = MultiLottery.new(win_val_right, criteria[weight_index].weight, loss_val_both)

	weight_question = Question.new(left_lottery, right_lottery)
	return weight_question


func get_weight_criterion() -> AssessCriterion:
	return criteria[weight_index]


class WeightStepAnswer:
	var value: MultiLottery.MultiLotteryResult
	var answer: AssessCriterion.Answer


func weight_step(answer: AssessCriterion.Answer) -> WeightStepAnswer:
	var step_answer: WeightStepAnswer = WeightStepAnswer.new()
	var result: MultiLottery.MultiLotteryResult
	step_answer.answer = answer

	if (answer == AssessCriterion.Answer.p):
		#new
		criteria[weight_index].lower_bound_weight = criteria[weight_index].weight
		criteria[weight_index].weight += criteria[weight_index].upper_bound_weight
		criteria[weight_index].weight /= 2

		result = weight_question.get_left().get_value()

	if (answer == AssessCriterion.Answer.q):
		#new
		criteria[weight_index].upper_bound_weight = criteria[weight_index].weight
		criteria[weight_index].weight += criteria[weight_index].lower_bound_weight
		criteria[weight_index].weight /= 2
		result = weight_question.get_right().get_value()

	if (answer == AssessCriterion.Answer.i):
		#new
		criteria[weight_index].upper_bound_weight = criteria[weight_index].weight
		criteria[weight_index].lower_bound_weight = criteria[weight_index].weight
		#weight is set
		criteria[weight_index].METRIC_count_weight += criteria[weight_index].LIMIT_count_weight

		if randf() <= 0.5:
			result = weight_question.get_left().get_value()
			step_answer.answer = AssessCriterion.Answer.p
		else:
			result = weight_question.get_right().get_value()
			step_answer.answer = AssessCriterion.Answer.q

	step_answer.value = result

	for c in result.values:
		#print(result.values[c])
		c.value_result.emit(result.values[c])

	print("TIME FOR WEIGHTS TO SHOW UP WHAT THEY GOT")
	for x in criteria:
		print("==========`")
		print(x.criterion_name)
		#print(x.lower_bound_weight)
		#print(x.weight)
		#print(x.upper_bound_weight)
		print(x.LIMIT_count_weight)
		print(x.METRIC_count_weight)

	return step_answer


func next_phase():
	match phase:
		GamePhases.CRITERION:
			phase = GamePhases.WEIGHTS

		GamePhases.WEIGHTS:
			phase = GamePhases.FINAL

		GamePhases.FINAL:
			pass


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("force_endgame"):
		next_phase()
		print("switched to next phase")
