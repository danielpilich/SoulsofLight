extends Node
class_name StateMachine

@export var initial_state : State
@export var animation_tree: AnimationTree
@export var character : CharacterBody2D

var current_state : State
var states: Dictionary = {}
#var states : Array[State]

func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transition)
			#states.append(child)
			child.player = character
			child.playback = animation_tree["parameters/playback"]
		
		if initial_state:
			initial_state.Enter()
			current_state = initial_state

func _process(delta):
	if current_state:
		current_state.Update(delta)

func _physics_process(delta):
	if current_state:
		current_state.Physics_Update(delta)

func on_child_transition(state, new_state_name):
	if state != current_state:
		return
	
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return
	
	if current_state:
		current_state.Exit()
	
	new_state.Enter()
	
	current_state = new_state

func check_if_can_move():
	return current_state.can_move
