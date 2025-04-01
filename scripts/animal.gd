extends Node2D

@export var income : int

var destinationX : int

const speed = 10

func _ready():
	destinationX = 0
	get_node("AnimatedSprite2D").play("default")

func _physics_process(delta):
	if position.x < destinationX:
		position.x += speed * delta

func newDestination():
	pass

func setPos(newPos):
	position = newPos
