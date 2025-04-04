extends Node

@export var herbs : Array[PackedScene]
@export var mushrooms : Array[PackedScene]
@export var bushes : Array[PackedScene]
@export var trees : Array[PackedScene]

signal createPlant(plant)

func _unhandled_input(event):
	if !Global.gamePaused && event is InputEventMouseButton \
	&& event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
		var spawnPosition = event.position - Vector2(get_viewport().size)/8
		spawnPosition.y = Global.groundY
		var newPlant
		
		if Global.selected == Global.SeedType.HERB && checkSpace(0, spawnPosition.x, "HerbPlants"):
			var herbType = randi_range(0, herbs.size() -1)
			newPlant = herbs[herbType].instantiate()
		elif Global.selected == Global.SeedType.MUSH && checkShroomSpace(spawnPosition.x):
			var mushType = randi_range(0, mushrooms.size() -1)
			newPlant = mushrooms[mushType].instantiate()
		elif Global.selected == Global.SeedType.BUSH && checkSpace(1, spawnPosition.x, "BushPlants"):
			var bushType = randi_range(0, bushes.size() -1)
			newPlant = bushes[bushType].instantiate()
		elif Global.selected == Global.SeedType.TREE && checkSpace(2, spawnPosition.x, "TreePlants"):
			var treeType = randi_range(0, trees.size() -1)
			newPlant = trees[treeType].instantiate()
		else:
			return
		
		newPlant.setPos(spawnPosition)
		add_child(newPlant)
		createPlant.emit(newPlant)

func checkSpace(spaceRequired, xPos, groupName):
	var canGrow = false
	for plant in get_tree().get_nodes_in_group("PlantEntities"):
		if abs(plant.position.x - xPos) < plant.cracksDistance:
			if plant.is_in_group(groupName):
				return false #can't crowd plants of the same type
			elif plant.spaceProvided >= spaceRequired:
				canGrow = true
	return canGrow

func checkShroomSpace(xPos):
	for plant in get_tree().get_nodes_in_group("MushroomPlants"):
		if abs(plant.position.x - xPos) < 10:
			return false
	for plant in get_tree().get_nodes_in_group("TreePlants"):
		if abs(plant.position.x - xPos) < 10:
			return true
	return false
