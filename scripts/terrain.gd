extends MeshInstance3D


@onready var colShape = $StaticBody3D/CollisionShape3D
@export var chunk_size = 2.0
@export var height_ratio = 1.0
@export var colShape_size_ratio = 0.1


func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
