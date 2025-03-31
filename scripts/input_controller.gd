extends Node

var click_position = Vector2()

@export var herbs : Array[PackedScene]
@export var mushrooms : Array[PackedScene]
@export var bushes : Array[PackedScene]
@export var trees : Array[PackedScene]

signal createPlant(upkeep)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _unhandled_input(event):
	if event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
		click_position = event.position - Vector2(get_viewport().size)/8
		click_position.y = Global.groundY
		var newPlant
		
		if Global.selected == Global.SeedType.HERB:
			var herbType = randi_range(0, herbs.size() -1)
			newPlant = herbs[herbType].instantiate()
		elif Global.selected == Global.SeedType.MUSH:
			var mushType = randi_range(0, mushrooms.size() -1)
			newPlant = mushrooms[mushType].instantiate()
			return
		elif Global.selected == Global.SeedType.BUSH:
			var bushType = randi_range(0, bushes.size() -1)
			newPlant = bushes[bushType].instantiate()
			return
		elif Global.selected == Global.SeedType.TREE:
			var treeType = randi_range(0, trees.size() -1)
			newPlant = trees[treeType].instantiate()
			return
		else:
			return
		
		newPlant.setPos(click_position)
		add_child(newPlant)
		createPlant.emit(newPlant.getUpkeep())
