extends Node2D

@export var income : int

@onready var animation : AnimatedSprite2D = $AnimatedSprite2D

var destinationX : float

const speed = 10
const leftBounds = -150
const rightBounds = 150

#var haltTimer = 0

var stateTimer : float = 3.0
 

enum State {
	WALK,
	WAKE,
	REST
}

var state : State = State.WALK

func _ready():
	newDestination()
	state = State.WALK
	#animation.play("default")

func state_change(new_state : State) -> void:
	if new_state == State.REST:
		animation.play("idle")
		stateTimer = randf_range(2.0, 4.0)
	
	if new_state == State.WAKE:
		animation.play_backwards("idle")
	
	if new_state == State.WALK:
		animation.play("default")
		stateTimer = randf_range(6.0, 15.0)
		newDestination()
	
	state = new_state

func _physics_process(delta):
	
	if !Global.gamePaused:
		match state:
			State.WALK:
				if not animation.is_playing():
					animation.play("default")
				
				animation.flip_h = position.x > destinationX
				position.x = move_toward(position.x, destinationX, speed * delta)
				if abs(position.x - destinationX) <= 1:
					print("reach destination")
					newDestination()
				
				stateTimer -= delta
				if stateTimer <= 0:
					state_change(State.REST)
			State.WAKE:
				if not animation.is_playing():
					state_change(State.WALK)
			State.REST:
				stateTimer -= delta
				if stateTimer <= 0:
					state_change(State.WAKE)
				pass
	
	
	#if !Global.gamePaused:
		#if haltTimer <= 0:
			#if (randf() < 0.002):
				#haltTimer = randf_range(1, 5)
				#get_node("AnimatedSprite2D").play("idle")
			#if position.x < destinationX:
				#get_node("AnimatedSprite2D").flip_h = false
				#position.x += speed * delta
				#if position.x >= destinationX:
					#newDestination()
			#elif position.x > destinationX:
				#get_node("AnimatedSprite2D").flip_h = true
				#position.x -= speed * delta
				#if position.x <= destinationX:
					#newDestination()
			#else:
				#newDestination()
		#else:
			#haltTimer -= delta
			#if haltTimer <= 0:
				#get_node("AnimatedSprite2D").play("default")
		#
		##if !get_node("AnimatedSprite2D").is_playing():
			##get_node("AnimatedSprite2D").play()
	#
	#else:
		#get_node("AnimatedSprite2D").pause()

func newDestination():
	destinationX = randf_range(leftBounds, rightBounds)

func setPos(newPos):
	position = newPos
