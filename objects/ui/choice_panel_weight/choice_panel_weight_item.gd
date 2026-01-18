extends BoxContainer

# modified although very similar to stat_panel_item
# (this one uses criterion, stat_panel_item used BaseStat)
# also no reason to connect this one to a signal - all his info will be given through a question
class_name WeightItem

var criterion: AssessCriterion
var val: float


func _ready():
	%StatIcon.texture = criterion.icon
	#%StatLabel.text = tr(criterion.criterion_name) + " : " + "%0.2f" % val
	%StatLabel.text = "%0.2f" % val
