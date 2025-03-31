extends CanvasLayer

@export var currentYear = 2100
var yearTimer = 0
var yearLength = 2.0

@export var currentNutrients = 100
var nutrientIncome = 1
var nutrientUpkeep = 0

signal timePassed

func _ready():
	updateNutrientsLabel()
	updateYearLabel()

func _process(delta):
	yearTimer += delta
	if yearTimer >= yearLength:
		yearTimer = 0
		tickYear()

func updateYearLabel():
	$Control/YearContainer/YearCount.text = str(currentYear)

func updateNutrientsLabel():
	$Control/ResourceContainer/NutrientsCount.text = str(currentNutrients)
	var nutrientRate = nutrientIncome - nutrientUpkeep
	if nutrientRate >= 0:
		$Control/ResourceContainer/NutrientsRate.text = "+" + str(nutrientRate)
	else:
		$Control/ResourceContainer/NutrientsRate.text = str(nutrientRate)

func tickYear():
	currentYear += 1
	currentNutrients += nutrientIncome - nutrientUpkeep
	updateYearLabel()
	updateNutrientsLabel()
	timePassed.emit()


func _on_input_controller_create_plant(upkeep):
	if upkeep > 0:
		nutrientUpkeep += upkeep
	else:
		#mushrooms have negative upkeep, meaning they add to the nutrient income
		nutrientIncome -= upkeep
	updateNutrientsLabel()
	


func _on_animal_spawner_create_animal(income):
	nutrientIncome += income
	updateNutrientsLabel()
