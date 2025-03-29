extends Node

enum SeedType {
	HERB,
	MUSH,
	BUSH,
	TREE,
	NONE,
}

var selected : SeedType  = SeedType.NONE

var groundY = 400 #edit when we have ground, ideally we want it to dynamically scale
