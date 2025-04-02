extends CanvasLayer

@onready var year_label : Label = $Control/YearLabel
@onready var nutrients_label : Label = $Control/NutrientsLabel

@export var currentYear = 2100
var yearTimer = 0
var yearLength = 1.825

@export var currentNutrients = 100
var nutrientIncome = 0
var nutrientUpkeep = 5

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
	year_label.text = "Year %d" % currentYear

func updateNutrientsLabel():
	var nutrientRate = nutrientIncome - nutrientUpkeep
	nutrients_label.text = "Nutrients: %d %+d" % [currentNutrients, nutrientRate]

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
