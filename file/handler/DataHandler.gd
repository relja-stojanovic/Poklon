extends Node

func save_file(data: Resource, path: String) -> void:
	var error := ResourceSaver.save(data, path)
	if not error:
		print("Successfuly saved %s to %s" % [data.get_class(), path])
	else:
		printerr("Failed to saved %s error:%s" % [data.resource_name, error])
	
func load_file(path: String, return_type: GDScript) -> Resource:
	if FileAccess.file_exists(path):
		var res = ResourceLoader.load(path)
		if is_instance_of(res, return_type):
			print("Successfuly loaded %s" % return_type.get_global_name())
			return res
		else:
			printerr("File isn't of type %s (it's of type %s)" % [return_type.get_global_name(), res.get_class()])
	printerr("File doesn't exit or isn't of type %s" % return_type.get_global_name())
	return return_type.new()
