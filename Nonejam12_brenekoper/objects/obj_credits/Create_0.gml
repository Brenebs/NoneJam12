// Inherit the parent event
event_inherited();

region_w = 440;
region_h = 180;

var _back_button = new UiButton(GUI_WIDTH * .5, GUI_HEIGHT * .67, 120, 24);
with(_back_button) {
	text = fx() { return "Voltar" };
	color = #ff5555;
	depth = 5;
	action = fx() {
		owner.close();
	}
}
push_content(_back_button);

var _cred1 = new UiText(GUI_WIDTH * .5 - 135, GUI_HEIGHT * .31, 150, 24);
with(_cred1) {
	text = fx() { return @"
[fnt_pb][scale, 1.5][rainbow]Mimineko:[scale, 1][/rainbow][fnt_p]

- Produção
- Arq. de Sistemas
- Prog. de UI
- Música
- Efeitos Sonoros
" };
	text_scribble = true;
	text_valign = fa_top;
}
push_content(_cred1);

var _cred2 = new UiText(GUI_WIDTH * .5, GUI_HEIGHT * .31, 150, 24);
with(_cred2) {
	text = fx() { return @"
[fnt_pb][scale, 1.5][rainbow]Brenebs:[scale, 1][/rainbow][fnt_p]

- Game Design
- Arte Técnica
- Prog. de Gameplay
- Direção Artística
- Ilustrações 2D
" };
	text_scribble = true;
	text_valign = fa_top;
}
push_content(_cred2);

var _cred3 = new UiText(GUI_WIDTH * .5 + 135, GUI_HEIGHT * .31, 150, 24);
with(_cred3) {
	text = fx() { return @"
[fnt_pb][scale, 1.5][rainbow]Teper:[scale, 1][/rainbow][fnt_p]

- Pixel-Arte
- Animação
- Design de Personagens
" };
	text_scribble = true;
	text_valign = fa_top;
}
push_content(_cred3);