class_name XMLHelper


static func parse_xml(parser: XMLParser) -> Dictionary:
	var data: Dictionary = {}

	var attributes_dict:= {}
	# Read in current open tag (and its attributes)
	if parser.get_node_type() == XMLParser.NODE_ELEMENT:
		for index in range(parser.get_attribute_count()):
			attributes_dict[parser.get_attribute_name(index)] = parser.get_attribute_value(index)
		
		data.attributes = attributes_dict
	
	# Read in next element.
	parser.read()
	# Skip blank
	_ignore_blanks(parser)

	# If it's an element, its a nested element, so parse it and save its data into our dictionary.
	var nested_data: Dictionary = {}
	while parser.get_node_type() == XMLParser.NODE_ELEMENT:
		var nested_name:= parser.get_node_name()
		nested_data[nested_name] = parse_xml(parser)
	data.value = nested_data
	
	# If it's text, that means its between a pair of enveloping tags/
	var node_data: String = ""
	if parser.get_node_type() == XMLParser.NODE_TEXT:
		node_data = parser.get_node_data().strip_edges()
		data.value = node_data
		parser.read()

	if parser.get_node_type() == XMLParser.NODE_ELEMENT_END:
		parser.read()

	_ignore_blanks(parser)

	return data

static func _ignore_blanks(parser: XMLParser) -> void:
	if parser.get_node_type() == XMLParser.NODE_TEXT:
		if parser.get_node_data().strip_edges().is_empty():
			parser.read()
