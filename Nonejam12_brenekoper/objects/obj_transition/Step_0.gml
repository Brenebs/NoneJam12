
for (var i = 0; i < array_length(polygons); i++) {
	var _element = polygons[i];
	
	if _element.update() {
		if (!acted and polygons[i + 1].out) __system_action();
		
		array_delete(polygons, i, 1);
		i--;
	}
}

if (array_length(polygons) <= 0) instance_destroy()