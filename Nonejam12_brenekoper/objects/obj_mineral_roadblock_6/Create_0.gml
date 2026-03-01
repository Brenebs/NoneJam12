/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

image_yscale *= 1.7

var _y = (sprite_height)/2.2;

for(var i = 0 ; i < 120 ; i++)
{
	var _rng = choose(-1,1) * _y + random_range(16 , -48);
	array_sprites[i] = new vector2(irandom_range(0,room_width),y+_rng);
}