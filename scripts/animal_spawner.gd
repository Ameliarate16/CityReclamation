extends Node2D

@export var herbEaters: Array[PackedScene]
@export var mushroomEaters: Array[PackedScene]
@export var bushEaters: Array[PackedScene]
@export var treeEaters: Array[PackedScene]
@export var animalEaters: Array[PackedScene]

@onready var gui : CanvasLayer = %GUILayer

signal createAnimal(income)

func _ready():
	gui.timePassed.connect(on_time_pass)

func spawnAnimal(animal):
	var newAnimal = animal.instantiate()
	add_child(newAnimal)
	newAnimal.setPos(Vector2(-150, Global.groundY))
	createAnimal.emit(newAnimal.income)

func on_time_pass():
	var numHerbs = get_tree().get_node_count_in_group("HerbPlants")
	var numBushes = get_tree().get_node_count_in_group("BushPlants")
	var numTrees = get_tree().get_node_count_in_group("TreePlants")
	var numHerbEaters = get_tree().get_node_count_in_group("HerbEaters")
	var numBushEaters = get_tree().get_node_count_in_group("BushEaters")
	var numTreeEaters = get_tree().get_node_count_in_group("TreeEaters")
	var numAnimalEaters = get_tree().get_node_count_in_group("AnimalEaters")
	var numPlants = numHerbs + numBushes + numTrees
	var numAnimals = numHerbEaters + numBushEaters + numTreeEaters + numAnimalEaters
	
	if numPlants * 2 > numAnimals && randf() > 0.25:
		#pick an animal to spawn
		var spawnable: Array[PackedScene]
		if numHerbEaters < numHerbs:
			spawnable.append_array(herbEaters)
		if numBushEaters < numBushes:
			spawnable.append_array(bushEaters)
		if numTreeEaters < numTrees * 2:
			spawnable.append_array(treeEaters)
		if numAnimalEaters + 1 < numAnimals / 5:
			spawnable.append_array(animalEaters)
		
		if spawnable.size() > 0:
			spawnAnimal(spawnable[randi_range(0, spawnable.size() - 1)])
