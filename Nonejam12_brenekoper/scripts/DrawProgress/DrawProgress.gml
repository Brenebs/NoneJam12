

function hollow_circle(_x, _y, r1, r2, sn, istart = 0)
{
	var i = istart;
	draw_primitive_begin(pr_trianglestrip);
	repeat (sn + 1){
	    var d, dx, dy;
	    d = i / sn * 360;
	    dx = lengthdir_x(1, d);
	    dy = lengthdir_y(1, d);
	    draw_vertex(_x + dx * r1, _y + dy * r1);
	    draw_vertex(_x + dx * r2, _y + dy * r2);
	    i += 1;
	}
	draw_primitive_end();
}
		
function draw_rectangle_border(x1,y1,x2,y2,brd = 0 , color = draw_get_color() , alpha = draw_get_alpha())
{
	draw_sprite_stretched_ext(spr_hud_circle , brd , x1 , y1 , x2 , y2,color,alpha);
}
	
function progress_pie(_x ,_y ,_value, _max, _colour1, _radius1, _transparency1 = 1, _radius2 = _radius1 + 4 , color2 = c_black , _transparency2 = .5)
{
	var _old_color = draw_get_colour();
	if (_value > 0) { // no point even running if there is nothing to display (also stops /0
		var i, len, tx1, ty1, val;
    
		var numberofsections = 60 // there is no draw_get_circle_precision() else I would use that here
		var sizeofsection = 360/numberofsections
    
		val = (_value/_max) * numberofsections 
    
		if (val > 1) { // HTML5 version doesnt like triangle with only 2 sides 
    
			draw_set_color(color2);
			 draw_set_alpha(_transparency2);
			draw_circle(_x, _y, _radius2, false)
			
		    draw_set_colour(_colour1);
		    draw_set_alpha(_transparency1);
        
		    draw_primitive_begin(pr_trianglefan);
		    draw_vertex(_x, _y);
        
		    for(i=0; i<=val; i++) {
		        len = (i*sizeofsection)+90; // the 90 here is the starting angle
		        tx1 = lengthdir_x(_radius1, len);
		        ty1 = lengthdir_y(_radius1, len);
		        draw_vertex(_x+tx1, _y+ty1);				
		    }
		    draw_primitive_end();
			
			;
		
		}
		draw_set_alpha(1);
		draw_set_color(c_white)
	}
}

function progress_hollow_circle(_x, _y, _value, _max, r1, r2, sn, istart = r1/2){
	var i = istart;
	draw_primitive_begin(pr_trianglestrip);
	var _rpt = (_value/_max) * sn;
	repeat (_rpt){
	    var d, dx, dy;
	    d = i / sn * 360;
	    dx = lengthdir_x(1, d);
	    dy = lengthdir_y(1, d);
	    draw_vertex(_x + dx * r1, _y + dy * r1);
	    draw_vertex(_x + dx * r2, _y + dy * r2);
	    i += 1;
	}
	draw_primitive_end();
}
	
function draw_donut(_x, _y, _r1, _r2, _segment_n, _progress = 1, _angle_offset = -90, _color = #ffffff, _alpha = 1) {
    var i = 0;
    draw_primitive_begin(pr_trianglestrip);
    repeat (_segment_n + 1){
        var _d, _dx, _dy;
        _d = (i / _segment_n) * (360 * -_progress) + _angle_offset;
        _dx = lengthdir_x(1, _d);
        _dy = lengthdir_y(1, _d);
        draw_vertex_color(_x + _dx * _r1, _y + _dy * _r1, _color, _alpha);
        draw_vertex_color(_x + _dx * _r2, _y + _dy * _r2, _color, _alpha);
        i += 1;
    }
    draw_primitive_end();
}