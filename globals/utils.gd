extends Node


func risk_to_string(value: float):

	var label: String = ""

	if abs(value) > 0.5:

		label = tr("RISKINESS_VERY_RISKY" if sign(value) == -1 else "RISKINESS_VERY_SAFE")

	elif abs(value) >= 0.25:

		label = tr("RISKINESS_RISKY" if sign(value) == -1 else "RISKINESS_SAFE")

	elif abs(value) >= 0.1:

		label = tr("RISKINESS_SLIGHTLY_RISKY" if sign(value) == -1 else "RISKINESS_SLIGHTLY_SAFE")

	else:

		label = tr("RISKINESS_BALANCED")

	return label
