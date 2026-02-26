// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações

function draw_cool_text(_x , _y , _txt , _wid = 1000 , color_1 = c_white , _color_border = c_black)
{
	draw_set_color(_color_border);
	
	
	draw_text_ext(_x-1 , _y-1 , _txt , -1 , _wid);
	draw_text_ext(_x+1 , _y+1 , _txt , -1 , _wid);
	draw_text_ext(_x-1 , _y+1 , _txt , -1 , _wid);
	draw_text_ext(_x+1 , _y-1 , _txt , -1 , _wid);
	
	draw_text_ext(_x	, _y-1	, _txt , -1 , _wid);
	draw_text_ext(_x	, _y+1	, _txt , -1 , _wid);
	draw_text_ext(_x+1	, _y	, _txt , -1 , _wid);
	draw_text_ext(_x-1	, _y	, _txt , -1 , _wid);
	
	draw_set_color(c_white);
	draw_text_ext(_x	, _y	, _txt , -1 , _wid);
}

function draw_cool_scribble_text(_x , _y , _txt , _wid = 1000 , color_1 = c_white , _color_border = c_black)
{
	draw_set_color(_color_border);
	
	
	draw_text_scribble_ext(_x-1 , _y-1 , _txt , _wid);
	draw_text_scribble_ext(_x+1 , _y+1 , _txt , _wid);
	draw_text_scribble_ext(_x-1 , _y+1 , _txt , _wid);
	draw_text_scribble_ext(_x+1 , _y-1 , _txt , _wid);
	
	draw_text_scribble_ext(_x	, _y-1	, _txt , _wid);
	draw_text_scribble_ext(_x	, _y+1	, _txt , _wid);
	draw_text_scribble_ext(_x+1	, _y	, _txt , _wid);
	draw_text_scribble_ext(_x-1	, _y	, _txt , _wid);
	
	draw_set_color(c_white);
	draw_text_scribble_ext(_x	, _y	, _txt , _wid);
}