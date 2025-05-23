extends Node2D

@export var upkeep : int
@export var spaceProvided : int
@export var cracksDistance: int
@export var growthLevel = 0
var maxGrowthLevel

func on_time_pass():
	if growthLevel < maxGrowthLevel:
		growthLevel += 1
		get_node("AnimatedSprite2D").frame = growthLevel

func setPos(newPos):
	global_position = newPos

func _ready():
	maxGrowthLevel = get_node("AnimatedSprite2D").sprite_frames.get_frame_count("default") - 1
	get_node("/root/Node2D/GUILayer").timePassed.connect(Callable(self, "on_time_pass"))
	get_node("AnimatedSprite2D").frame = growthLevel
