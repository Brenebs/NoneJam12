
if (room == rm_main_menu) {
	current_input = "menu";
}
else if (room = rm_skill_tree) {
	current_input = "skill_tree";
}
else {
	if !global.pause {
		if !CURRENT_WORLD {
			if obj_player.inside_ground {
				current_input = "expedition_under";
			}
			else {
				current_input = "expedition";
			}
		}
		else {
			current_input = "overworld";
		}
	}
	else {
		current_input = "menu";
	}
}