extends Node

var current_level_clones: int = 0
var level_clone_limits = {
	"res://scenes/lvl 1.tscn": 3,
	"res://scenes/Level.tscn": 4,
	"res://scenes/Level 2.tscn": 5,
}

signal clones_changed(remaining: int)
signal out_of_clones

func _ready():
	# Initialize when a level is loaded
	get_tree().node_added.connect(_on_node_added)

func _on_node_added(node: Node):
	if node.scene_file_path in level_clone_limits:
		reset_clones(node.scene_file_path)

func reset_clones(level_path: String):
	if level_path in level_clone_limits:
		current_level_clones = level_clone_limits[level_path]
		clones_changed.emit(current_level_clones)

func use_clone() -> bool:
	if current_level_clones > 0:
		current_level_clones -= 1
		clones_changed.emit(current_level_clones)
		if current_level_clones == 0:
			out_of_clones.emit()
		return true
	return false

func get_remaining_clones() -> int:
	return current_level_clones