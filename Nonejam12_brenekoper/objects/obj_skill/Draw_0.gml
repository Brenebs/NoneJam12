if locked exit;

_system_draw();

if(purchased_n > 0 && upgrade_amt>1)
{
	draw_set_valign(fa_middle);
	draw_set_halign(fa_center);
	draw_set_font(fnt_pb);
	draw_cool_text(x,bbox_bottom,$"{purchased_n}/{upgrade_amt}")
	draw_set_valign(-1);
	draw_set_font(-1);
	draw_set_halign(-1);
}