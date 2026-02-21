// Inherit the parent event
event_inherited();

current_timer_offset_attacks = max_timer(current_timer_offset_attacks);
speed_multiply_timer		 = max_timer(speed_multiply_timer);
acel_after_attack = lerp(acel_after_attack , 1 , .1);