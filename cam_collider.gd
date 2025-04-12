extends CollisionShape3D

@onready var shap: PackedVector3Array = PackedVector3Array();
@onready var shape2: ConcavePolygonShape3D = ConcavePolygonShape3D.new();
@onready var cam: Node3D = self.get_node("../../..")
@onready var rays: Array[RayCast3D] = [self.get_node("../../south"), self.get_node("../../southwest"), self.get_node("../../west"), self.get_node("../../northwest"), self.get_node("../../north"), self.get_node("../../northeast"), self.get_node("../../east"), self.get_node("../../southeast")]
@onready var pole: RayCast3D = self.get_node("../../pole")
@onready var player: Node3D = self.get_tree().get_first_node_in_group("player")
@onready var light: SpotLight3D = cam.get_node("cameraSpot")

@onready var color = light.light_color
# Called every frame. 'delta' is the elapsed time since the previous frame.
var old_pos = Vector3(0.0, 0.0, 0.0)
var old_rot = Vector3(0.0, 0.0, 0.0)

func _process(delta: float) -> void:
	if old_pos != cam.position or old_rot != cam.rotation:
		shap.clear();
		var pos = cam.global_position;
		pos.x += 10.0;
		var last = to_local(rays[7].get_collision_point());
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
				shap.push_back(last);
				shap.push_back(next);
				shap.push_back(Vector3.ZERO);
				shap.push_back(next);
				shap.push_back(last);
				shap.push_back(to_local(pole.get_collision_point()));
				last = next;
		shape2.set_faces(shap);
		self.shape = shape2;
		old_pos = position
		old_rot = rotation


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body == player:
		var light: SpotLight3D = cam.get_node("cameraSpot")
		light.light_color = Color(1.0, 0.4, 0.3)

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body == player:
		print("exiting")
		light.light_color = color
