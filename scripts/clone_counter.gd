extends CanvasLayer

@onready var label = $MarginContainer/Label

func _ready():
	LevelManager.clones_changed.connect(_on_clones_changed)
	_on_clones_changed(LevelManager.get_remaining_clones())

func _on_clones_changed(remaining: int):
	label.text = "Clones Remaining: %d" % remaining