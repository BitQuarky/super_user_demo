enum MenuNodeType {Directory, File, Link, Device, DeadLink, Hacking}

class MenuNode extends Node:
	var left: MenuNode
	var right: MenuNode
	var down: MenuNode
	var up: MenuNode
	var type: MenuNodeType
	var content
	func MenuNode(t, n, l = null, r = null, d = null, u = null):
		type = t
		left = l
		right = r
		down = d
		up = u
		name = n
	func flatten(nodes: Array[MenuNode]) -> Array[MenuNode]:
		var branches = false
		for node in nodes:
			if node.left != null and not node.left in nodes:
				nodes.append(node.left)
				branches = true
			if node.right != null and not node.right in nodes:
				nodes.append(node.right)
				branches = true
			if node.down != null and not node.down in nodes:
				nodes.append(node.down)
				branches = true
		if !branches:
			return nodes
		else:
			return flatten(nodes) 
	func redirect(n: String):
		return flatten([self]).find_custom(
			func (m: MenuNode):
			return m.name == n
			)
