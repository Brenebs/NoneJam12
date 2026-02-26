// Inherit the parent event
event_inherited();

image_yscale = (sprite_get_height(sprite) + bt_depth) / sprite_get_height(sprite);

width = sprite_width;
height = sprite_height;

y -= bt_depth * .5;

alarm[0] = 2;