extends AssessCriterion


func preferred_left(): # Pewnik
	right_bound = point_list[-2].y
	point_list[-2].y = (left_bound + point_list[-2].y) / 2
	#pewniak się robi jako (MIN_value + pewniak) / 2


func preferred_right(): # Loteria
	left_bound = point_list[-2].y
	point_list[-2].y = (point_list[-2].y + right_bound) / 2
	#pewniak się robi jako (pewniak + CUR_MAX_value) / 2


func set_bound():
	left_bound = point_list[-3].y
	right_bound = point_list[-1].y


func change_question() -> void:
	question[0] = Lottery.new(point_list[-2].x, 1, -1)
	question[1] = Lottery.new(point_list[-1].x, point_list[-2].y, MIN_value)
	question_changed.emit(question)


func _question_init() ->void:
	question.append(Lottery.new(point_list[-2].x, 1, -1)) # Guaranteed middle value
	question.append(Lottery.new(point_list[-1].x, point_list[-2].y,MIN_value)) #Lottery
	question_changed.emit(question)
