
for (var i = 0; i < array_length(polygons); i++) {
	var _element = polygons[i];
	
	if _element.update() {
		array_delete(polygons, i, 1);
		i--;
	}
}