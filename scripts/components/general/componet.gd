class_name Component extends Node

func get_component(component : String) -> Component:
	var found_component : Component
	if get_parent().has_node(component):
		print("Found Componet:" + component + " | On:" + get_parent().name)
		found_component = get_parent().get_node(component)
		return found_component
	else:
		push_warning("Required Componet of type:" + component + " required, script may not function properly")
		return null
func get_parent_component() -> Component:
	var found_component : Component
	if get_parent().type == Component:
		print("Found Parent Componet")
		found_component = get_parent()
		return found_component
	else:
		push_warning("Parent is not a Component, can't get parent")
		return null
func get_component_in_child(component : String, child : int) -> Component:
	var found_component : Component
	if get_child(child).has_node(component):
		print("Found Componet:" + component + " | On:" + get_child(child).name)
		found_component =  get_child(child).get_node(component)
		return found_component
	else:
		push_warning("Required Componet of type:" + component + " required, script may not function properly")
		return null
