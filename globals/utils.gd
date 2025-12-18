extends Node


func risk_to_string(
	value: float,
	method: AssessCriterion.RiskCalculationMode = AssessCriterion.RiskCalculationMode.area_minus_perfectline_over_perfectline):

	var label: String = ""

	match method:
		AssessCriterion.RiskCalculationMode.area_minus_perfectline:
			label = "N/A"

		AssessCriterion.RiskCalculationMode.area_minus_perfectline_over_perfectline:
			if abs(value) > 0.5:

				label = tr("RISKINESS_VERY_RISKY" if sign(value) == -1 else "RISKINESS_VERY_SAFE")

			elif abs(value) >= 0.25:

				label = tr("RISKINESS_RISKY" if sign(value) == -1 else "RISKINESS_SAFE")

			elif abs(value) >= 0.1:

				label = tr("RISKINESS_SLIGHTLY_RISKY" if sign(value) == -1 else "RISKINESS_SLIGHTLY_SAFE")

			else:

				label = tr("RISKINESS_BALANCED")

	return label
