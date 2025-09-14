extends AssessCriterion

func preferred_left(): # Pewnik
	right_bound = point_list[-2].x
	point_list[-2].x = (left_bound + point_list[-2].x) / 2
	#pewniak się robi jako (MIN_value + pewniak) / 2

func preferred_right(): # Loteria
	left_bound = point_list[-2].x
	point_list[-2].x = (point_list[-2].x + right_bound) / 2
	#pewniak się robi jako (pewniak + CUR_MAX_value) / 2

func set_bound():
	left_bound = point_list[-3].x
	right_bound = point_list[-1].x
