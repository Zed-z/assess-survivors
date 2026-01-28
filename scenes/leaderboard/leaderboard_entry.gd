extends Control
class_name LeaderboardEntry


func setup(data) -> void:
	%Rank.text = "#" + str(int(data["rank"]))
	%PlayerName.text = data["player"]
	%Score.text = tr("END_SCREEN_SCORE_COUNTER") % int(data["score"])
	%Riskiness.text = tr("SUMMARY_ONLINE_MEAN_RISKINESS") % data["average_riskiness"]
	%MostWeightStat.text = tr("SUMMARY_MOST_WEIGHED_STAT") % data["most_weight_stat"]
