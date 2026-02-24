
update_content(!locked and !instance_exists(obj_transition) and obj_ui_manager.check_priority(priority));

//	Animation
anim = lerp(anim, anim_target, anim_acc);

if (abs(anim_target - anim) <= .02) {
	anim_event_update();
}