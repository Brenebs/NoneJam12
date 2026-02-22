
PauseInstanceHandler();

timer_to_be_collected = max_timer(timer_to_be_collected);

speed = lerp(speed , 0 , .1);

var _mrg = 16;
x = clamp(x,16,room_width-_mrg)