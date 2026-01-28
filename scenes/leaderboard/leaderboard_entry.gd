extends Control
class_name LeaderboardEntry


func setup(data) -> void:
	%Rank.text = "#" + str(int(data["rank"]))
	%PlayerName.text = data["player"]
	%Score.text = tr("LEADERBOARD_SCORE") % int(data["score"])
	%Riskiness.text = tr("LEADERBOARD_RISKINESS") % [Utils.risk_to_string(data["average_riskiness"]), data["average_riskiness"]]
	%MostWeightStat.text = tr("LEADERBOARD_FAVORITE_STAT") % tr(data["most_weight_stat"])
