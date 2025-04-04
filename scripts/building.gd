extends AnimatedSprite2D

signal buildingOvergrown

var herbsNearby = 0
var shroomsNearby = 0
var bushesNearby = 0
var treesNearby = 0


func _on_input_controller_create_plant(plant):
	if abs(plant.position.x - position.x) < 30:
		if plant.is_in_group("HerbPlants"):
			herbsNearby += 1
		if plant.is_in_group("MushroomPlants"):
			shroomsNearby += 1
		if plant.is_in_group("BushPlants"):
			bushesNearby += 1
		if plant.is_in_group("TreePlants"):
			treesNearby += 1

func _on_time_passed():
	var newFrame = 0
	if herbsNearby >= 1:
		newFrame += 1
	if shroomsNearby >= 1:
		newFrame += 1
	if bushesNearby >= 1:
		newFrame += 1
	if treesNearby >= 1:
		newFrame += 1
	if herbsNearby >= 2 && shroomsNearby >= 2 && bushesNearby >= 2 && treesNearby >= 2:
		newFrame += 1
	if herbsNearby >= 3 && shroomsNearby >= 3 && bushesNearby >= 3 && treesNearby >= 3:
		newFrame += 1
		buildingOvergrown.emit()
	frame = newFrame
