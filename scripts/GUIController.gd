extends CanvasLayer

@export var currentYear = 2100

@export var currentNutrients = 100
var nutrientIncome = 1
var nutrientUpkeep = 0

var yearTimer = 0
var yearLength = 1

func updateYearLabel():
	$YearContainer/YearCount.text = str(currentYear)

func updateNutrientsLabel():
	$ResourceContainer/NutrientsCount.text = str(currentNutrients)
	var nutrientRate = nutrientIncome - nutrientUpkeep
	if (nutrientRate >= 0):
		$ResourceContainer/NutrientsRate.text = "+" + str(nutrientRate)
	else:
		$ResourceContainer/NutrientsRate.text = str(nutrientRate)

func tickYear():
	currentYear += 1
	currentNutrients += nutrientIncome - nutrientUpkeep
	updateYearLabel()
	updateNutrientsLabel()

func _process(delta):
	yearTimer += delta
	if (yearTimer >= yearLength):
		yearTimer = 0
		tickYear()
