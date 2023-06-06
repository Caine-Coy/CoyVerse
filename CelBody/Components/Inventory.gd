extends Node

var inventory = {
	"Pop" : 0,
	"BMats":0,
	"AMats":0,
	"Hydrogen":0,
	"Energy":0,
}

func GetStored():
	return inventory

func AddPop(_amount):
	inventory.Pop = inventory.Pop + _amount
