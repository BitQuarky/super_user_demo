extends MeshInstance3D

@onready var msh: ImmediateMesh = mesh
@onready var cam: Node3D = self.get_tree().get_first_node_in_group("cameras")
@onready var rays: Array[RayCast3D] = [self.get_node("../south"), self.get_node("../southwest"), self.get_node("../west"), self.get_node("../northwest"), self.get_node("../north"), self.get_node("../northeast"), self.get_node("../east"), self.get_node("../southeast")]
@onready var pole: RayCast3D = self.get_node("../pole")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var pos = cam.global_position;
	pos.x += 10.0;
	var last = to_local(rays[7].get_collision_point());
	msh.clear_surfaces();
	msh.surface_begin(Mesh.PRIMITIVE_TRIANGLES);
	var avg = Vector3.ZERO;
	var count = 0;
	for ray in rays:
		if ray.is_colliding():
			avg += to_local(ray.get_collision_point());
			count += 1;
	avg /= count;
	for ray in rays:
		if ray.is_colliding():
			var next = to_local(ray.get_collision_point());
			msh.surface_add_vertex(last);
			msh.surface_add_vertex(next);
			msh.surface_add_vertex(Vector3.ZERO);
			msh.surface_add_vertex(next);
			msh.surface_add_vertex(last);
			msh.surface_add_vertex(to_local(pole.get_collision_point()));
			last = next;
	msh.surface_end();
