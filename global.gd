extends Node

var round: int = 0
var score: int = 0
var high_score: int = 0
var catch_array: Array[int] = []

var bonus_req_points: int = 30
var unlocked_bonus: bool = false

var catalogue_complete: bool = false
var catalogue_array: Array[int] = []

func reset_all():
	round = 0
	score = 0
	catch_array = []
