// Inherit the parent event
event_inherited();

region_w = 200;
region_h = 280;

x_menu = GUI_WIDTH*.7;

global.elevator_choose = max(0,GAME_INFO.max_chunk_achiev div 10);

//wrap(current_choose , 0 , GAME_INFO.max_chunk_achiev div 10);

close = fx() {
	anim_event = UI_EVENT.DESTROY;
	locked = true;
	anim_target = 1;
	anim_flag = false;
	
	save_game();
}

var _title = new UiText(x_menu, GUI_HEIGHT * .15, 150, 24);
with(_title) {
	text = fx() { return "Escolha um elevador" };
	text_scale = 2;
	text_font = fnt_pb;
	text_valign = fa_top;
}
push_content(_title);

var _sep = 72;
var _h = GUI_HEIGHT * .33;

#region Main Volume
	
	var _main_min_button = new UiButton(x_menu - _sep, _h, 18, 18);
	with(_main_min_button) {
		text = fx() { return "-" };
		color = #ff5555;
		depth = 5;
		action = fx() {
			global.elevator_choose = wrap(global.elevator_choose-1 , 0 , GAME_INFO.max_chunk_achiev div 10);
			update_save();
		}
	}
	push_content(_main_min_button);
	
	var _main = new UiText(x_menu, _h - 6, 150, 24);
	with(_main) {
		text = fx() { return $"{round(global.elevator_choose+1)}° elevador" };
		text_scribble = false;
		text_font = fnt_p
		text_valign = fa_top;
	}
	push_content(_main);
	
	var _main_max_button = new UiButton(x_menu + _sep, _h, 18, 18);
	with(_main_max_button) {
		text = fx() { return "+" };
		color = #ff5555;
		depth = 5;
		action = fx() {
			global.elevator_choose = wrap(global.elevator_choose+1 , 0 , GAME_INFO.max_chunk_achiev div 10);
			update_save();
		}
	}
	push_content(_main_max_button);
	
	_h += 28;
	
#endregion


#region Buttons

	var _fullscreen = new UiButton(x_menu, GUI_HEIGHT * .82 - 64, 110, 32);
	with(_fullscreen) {
		text = fx() { return $"Tela-cheia: {window_get_fullscreen() ? "Sim" : "Não"}" };
		action = fx() {
			GAME_INFO.fullscreen = !GAME_INFO.fullscreen;
			update_save();
		}
	}
	push_content(_fullscreen);

	//var _fullscreen = new UiButton(GUI_WIDTH * .5, GUI_HEIGHT * .82 - 52 - 34, 110, 32);
	//with(_fullscreen) {
	//	text = fx() { return $"Usar mouse: {GAME_INFO.use_mouse ? "Sim" : "Não"}" };
	//	action = fx() {
	//		GAME_INFO.use_mouse = !GAME_INFO.use_mouse;
	//	}
	//}
	//push_content(_fullscreen);

#endregion

var _back_button = new UiButton(x_menu, GUI_HEIGHT * .81, 120, 24);
with(_back_button) 
{
	text = fx() { return "Voltar" };
	color = #ff5555;
	depth = 5;
	action = fx() {
		owner.close();
	}
}
push_content(_back_button);