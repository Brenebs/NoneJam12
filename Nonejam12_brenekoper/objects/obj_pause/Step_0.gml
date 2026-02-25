// Inherit the parent event
event_inherited();

if (keyboard_check_pressed(vk_escape) and obj_ui_manager.check_priority(priority)) close();