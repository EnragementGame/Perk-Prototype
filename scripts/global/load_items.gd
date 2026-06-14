class_name Items extends Node

var items : Dictionary[StringName, ItemData]

func _ready() -> void:
	reload_items_list()
	print(items.size())

func fix_filename(filename: String) -> String:
	return filename.replace(".remap", "").replace(".import", "")

func reload_items_list() -> void:
	for raw_filename in DirAccess.get_files_at("res://resources/itemdata/"):
		var filename := fix_filename(raw_filename)
		if not filename.ends_with(".gd"):
			push_warning("Stupid idiot! Non-Script file in materials directory.")
			continue
		var item := load("res://resources/itemdata/" + filename) as ItemData
		if not item: continue # Could not load the resource or is wrong type
		items[item.id] = item
		print(items)

func mat_find(id: StringName) -> ItemData: #Loads the material from mats using an ID.
	if id in items:
		return items[id]
	push_warning(id + " is not a valid ID, setting to null.")
	return items["null"]
