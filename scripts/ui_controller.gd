extends CanvasLayer

@onready var year_label : Label = $Control/YearLabel
@onready var nutrients_label : Label = $Control/NutrientsLabel

@export var currentYear = 2100
var yearTimer = 0
var yearLength = 1.825

@export var currentNutrients = 100
var nutrientIncome = 0
var nutrientUpkeep = 5

var sandboxMode = false

signal timePassed

func _ready():
	updateNutrientsLabel()
	updateYearLabel()

func _process(delta):
	if !Global.gamePaused:
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
	if currentNutrients < 0 && !sandboxMode:
		Global.gamePaused = true
		$Control/FailurePanel.visible = true


func _on_input_controller_create_plant(plant):
	if plant.upkeep > 0:
		nutrientUpkeep += plant.upkeep
	else:
		#mushrooms have negative upkeep, meaning they add to the nutrient income
		nutrientIncome -= plant.upkeep
	updateNutrientsLabel()


func _on_animal_spawner_create_animal(income):
	nutrientIncome += income
	updateNutrientsLabel()


func _on_building_overgrown():
	if (!sandboxMode):
		Global.gamePaused = true
		$Control/SuccessPanel.visible = true


func _on_sandbox_button_pressed():
	sandboxMode = true
	$Control/SuccessPanel.visible = false
	$Control/FailurePanel.visible = false
	Global.gamePaused = false


func _on_quit_button_pressed():
	pass # Replace with function body.


func _on_restart_button_pressed():
	Global.gamePaused = false
	get_tree().change_scene_to_file("res://scenes/mainGame.tscn")
