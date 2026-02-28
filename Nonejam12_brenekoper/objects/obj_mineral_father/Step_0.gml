
lerp_scale = spring_lerp(scale , lerp_scale , 1 , .75 ,.125);
scale += lerp_scale;

angle_force = spring_lerp(angle , angle_force , 0 , .8 ,.175);
angle += angle_force;

white_timer -= white_timer>0;