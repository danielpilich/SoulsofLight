extends Node
class_name State

@export var can_move : bool = true

var player: CharacterBody2D

signal Transitioned

func Enter():
	pass

func Exit():
	pass

func Update(_delta: float):
	pass

func Physics_Update(_delta: float):
	pass
