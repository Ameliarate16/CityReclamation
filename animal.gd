extends Node2D

@export var income : int
@export var diet : Global.SeedType

var destinationX : int

const speed = 10

func _ready():
	destinationX = 100
	get_node("AnimatedSprite2D").play("default")

func _physics_process(delta):
	if position.x < destinationX:
		position.x += speed * delta

func newDestination():
	pass

func setPos(newPos):
	position = newPos

func getIncome():
	return income
