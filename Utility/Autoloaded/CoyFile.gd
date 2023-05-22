extends Node

func LoadFileCSV(_filePath:String):
	if not FileAccess.file_exists(_filePath):
		CoyDebug.Error(str("Failed to load ",_filePath))
	else:
		var file = FileAccess.open(_filePath,FileAccess.READ)
		var json_string = file.get_csv_line()
		var json = JSON.new()
		return json_string

func SaveToFileCSV(_data, _filePath:String):
	var file = FileAccess.open(_filePath,FileAccess.WRITE)
	var json = JSON.stringify(_data)
	file.store_csv_line(json)
	file = null
