extends Node
class_name State

@export var can_move : bool = true

var character: CharacterBody2D
var playback: AnimationNodeStateMachinePlayback 
var is_dead: bool = false

signal Transitioned

func Enter():
	pass

func Exit():
	pass

func Update(_delta: float):
	pass

func Physics_Update(_delta: float):
	pass
