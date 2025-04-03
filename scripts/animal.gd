extends Node2D

@export var income : int

var destinationX : float

const speed = 10
const leftBounds = -150
const rightBounds = 150

var haltTimer = 0

func _ready():
	destinationX = 0
	get_node("AnimatedSprite2D").play("default")

func _physics_process(delta):
	if haltTimer <= 0:
		if (randf() < 0.002):
			haltTimer = randf_range(1, 5)
			get_node("AnimatedSprite2D").play("idle")
		if position.x < destinationX:
			get_node("AnimatedSprite2D").flip_h = false
			position.x += speed * delta
			if position.x >= destinationX:
				newDestination()
		elif position.x > destinationX:
			get_node("AnimatedSprite2D").flip_h = true
			position.x -= speed * delta
			if position.x <= destinationX:
				newDestination()
		else:
			newDestination()
	else:
		haltTimer -= delta
		if haltTimer <= 0:
			get_node("AnimatedSprite2D").play("default")

func newDestination():
	destinationX = randf_range(leftBounds, rightBounds)

func setPos(newPos):
	position = newPos
