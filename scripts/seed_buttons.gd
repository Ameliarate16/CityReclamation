extends BoxContainer

@onready var herb_sprite : Sprite2D = $HerbButton/Sprite2D
@onready var mush_sprite : Sprite2D = $MushButton/Sprite2D
@onready var bush_sprite : Sprite2D = $BushButton/Sprite2D
@onready var tree_sprite : Sprite2D = $TreeButton/Sprite2D

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
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		select(Global.SeedType.HERB)

func _on_tree_button_gui_input(event:InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		select(Global.SeedType.TREE)

func _on_bush_button_gui_input(event:InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		select(Global.SeedType.BUSH)

func _on_mush_button_gui_input(event:InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		select(Global.SeedType.MUSH)
