
update_content(!locked);

//	Animation
anim = lerp(anim, anim_target, anim_acc);

if (abs(anim_target - anim) <= .02) {
	anim_event_update();
}