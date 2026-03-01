
if (room == rm_main_menu) {
	current_input = "menu";
}
else {
	if !global.pause {
		if !CURRENT_WORLD {
			current_input = "expedition";
		}
		else {
			current_input = "overworld";
		}
	}
	else {
		current_input = "menu";
	}
}