extends AssessCriterion

func preferred_left(): # Pewnik
	right_bound = point_list[-2].x
	point_list[-2].x = (left_bound.added(point_list[-2].x)).divided(Decimal.new(2,1))
	#pewniak się robi jako (MIN_value + pewniak) / 2

func preferred_right(): # Loteria
	left_bound = point_list[-2].x
	point_list[-2].x = (point_list[-2].x.added(right_bound)).divided(Decimal.new(2,1))
	#pewniak się robi jako (pewniak + CUR_MAX_value) / 2

func set_bound():
	left_bound = point_list[-3].x
	right_bound = point_list[-1].x

func get_left() -> Lottery:
	return Lottery.new(point_list[-2].y,1,-1)
func get_right() -> Lottery:
	return Lottery.new(point_list[-1].x,point_list[-2].y,point_list[0].x)
