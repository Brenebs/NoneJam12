/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

if(hover)
{
	draw_set_font(fnt_pb);
	draw_set_valign(fa_bottom);
	draw_set_halign(fa_center);
	draw_cool_scribble_text(x,y-16,$"[scale,2]{display_name}[scale,1]\n{description}")
	draw_set_valign(-1);
	draw_set_halign(-1);
	draw_set_font(-1);
}