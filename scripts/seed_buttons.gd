extends BoxContainer

@onready var herb_sprite : Sprite2D = $HerbButton/Sprite2D
@onready var mush_sprite : Sprite2D = $MushButton/Sprite2D
@onready var bush_sprite : Sprite2D = $BushButton/Sprite2D
@onready var tree_sprite : Sprite2D = $TreeButton/Sprite2D

@onready var tooltip : Label = $"../../Tooltip"

func _ready():
	select(Global.SeedType.HERB)

func select(which : Global.SeedType) -> void:
	Global.selected = which
	herb_sprite.frame = 0
	mush_sprite.frame = 0
	bush_sprite.frame = 0
	tree_sprite.frame = 0

	match Global.selected:
		Global.SeedType.MUSH:
			mush_sprite.frame = 1
		Global.SeedType.BUSH:
			bush_sprite.frame = 2
		Global.SeedType.TREE:
			tree_sprite.frame = 3
		Global.SeedType.HERB:
			herb_sprite.frame = 4


func _on_herb_button_gui_input(event:InputEvent) -> void:
	if event is InputEventMouseMotion:
		tooltip.show()
		tooltip.size = Vector2(0, 0)
		tooltip.text = "Flower\nUpkeep: 1\nInfluence: 6\nCracks Required: 1\nCracks Provided: 2"
		tooltip.global_position = event.global_position - Vector2(0, 5 + tooltip.size.y)

	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		select(Global.SeedType.HERB)

func _on_tree_button_gui_input(event:InputEvent) -> void:
	if event is InputEventMouseMotion:
		tooltip.show()
		tooltip.size = Vector2(0, 0)
		tooltip.text = "Tree\nUpkeep: 5\nInfluence: 24\nCracks Required: 3\nCracks Provided: 1"
		tooltip.global_position = event.global_position - Vector2(0, 5 + tooltip.size.y)
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		select(Global.SeedType.TREE)

func _on_bush_button_gui_input(event:InputEvent) -> void:
	if event is InputEventMouseMotion:
		tooltip.show()
		tooltip.size = Vector2(0, 0)
		tooltip.text = "Bush\nUpkeep: 2\nInfluence: 12\nCracks Required: 2\nCracks Provided: 3"
		tooltip.global_position = event.global_position - Vector2(0, 5 + tooltip.size.y)
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		select(Global.SeedType.BUSH)

func _on_mush_button_gui_input(event:InputEvent) -> void:
	if event is InputEventMouseMotion:
		tooltip.show()
		tooltip.size = Vector2(0, 0)
		tooltip.text = "Mushroom\nMust be placed in the shade under a tree\nUpkeep: -1\nInfluence: 8"
		tooltip.global_position = event.global_position - Vector2(0, 5 + tooltip.size.y)
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		select(Global.SeedType.MUSH)
