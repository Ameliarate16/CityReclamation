extends Node2D

@export var animalTypes: Array[PackedScene]

@onready var gui : CanvasLayer = %GUILayer

signal createAnimal(income)

func _ready():
	gui.timePassed.connect(on_time_pass)

func spawnAnimal(animal):
	var newAnimal = animal.instantiate()
	add_child(newAnimal)
	newAnimal.setPos(Vector2(-20, Global.groundY))
	createAnimal.emit(newAnimal.getIncome())

func on_time_pass():
	var numPlants = get_tree().get_node_count_in_group("PlantEntities")
	var numAnimals = get_tree().get_node_count_in_group("AnimalEntities")
	var numShrooms = get_tree().get_node_count_in_group("MushroomPlants")
	if numPlants * 2 - numShrooms > numAnimals:
		#pick an animal to spawn
		spawnAnimal(animalTypes[0])
