// Inherit the parent event
event_inherited();

region_w = 280;
region_h = 280;

close = fx() {
	anim_event = UI_EVENT.DESTROY;
	locked = true;
	anim_target = 1;
	anim_flag = false;
	
	save_game();
}

var _title = new UiText(GUI_WIDTH * .5, GUI_HEIGHT * .15, 150, 24);
with(_title) {
	text = fx() { return "Opções" };
	text_scale = 2;
	text_font = fnt_pb;
	text_valign = fa_top;
}
push_content(_title);

var _sep = 72;
var _h = GUI_HEIGHT * .28;

#region Main Volume
	
	var _main_min_button = new UiButton(GUI_WIDTH * .5 - _sep, _h, 18, 18);
	with(_main_min_button) {
		text = fx() { return "-" };
		color = #ff5555;
		depth = 5;
		action = fx() {
			GAME_INFO.volume_main.value = clamp(GAME_INFO.volume_main.value - GAME_INFO.volume_main.value_change_snap, GAME_INFO.volume_main.value_min, GAME_INFO.volume_main.value_max);
			update_save();
		}
	}
	push_content(_main_min_button);
	
	var _main = new UiText(GUI_WIDTH * .5, _h - 6, 150, 24);
	with(_main) {
		text = fx() { return $"[fnt_pb]Vol. Principal:[fnt_p] {round(GAME_INFO.volume_main.value * 100)}%" };
		text_scribble = true;
		text_valign = fa_top;
	}
	push_content(_main);
	
	var _main_max_button = new UiButton(GUI_WIDTH * .5 + _sep, _h, 18, 18);
	with(_main_max_button) {
		text = fx() { return "+" };
		color = #ff5555;
		depth = 5;
		action = fx() {
			GAME_INFO.volume_main.value = clamp(GAME_INFO.volume_main.value + GAME_INFO.volume_main.value_change_snap, GAME_INFO.volume_main.value_min, GAME_INFO.volume_main.value_max);
			update_save();
		}
	}
	push_content(_main_max_button);
	
	_h += 28;
	
#endregion

#region Music Volume
	
	var _music_min_button = new UiButton(GUI_WIDTH * .5 - _sep, _h, 18, 18);
	with(_music_min_button) {
		text = fx() { return "-" };
		color = #ff5555;
		depth = 5;
		action = fx() {
			GAME_INFO.volume_music.value = clamp(GAME_INFO.volume_music.value - GAME_INFO.volume_music.value_change_snap, GAME_INFO.volume_music.value_min, GAME_INFO.volume_music.value_max);
			update_save();
		}
	}
	push_content(_music_min_button);
	
	var _music = new UiText(GUI_WIDTH * .5, _h - 6, 150, 24);
	with(_music) {
		text = fx() { return $"[fnt_pb]Vol. Música:[fnt_p] {round(GAME_INFO.volume_music.value * 100)}%" };
		text_scribble = true;
		text_valign = fa_top;
	}
	push_content(_music);
	
	var _music_max_button = new UiButton(GUI_WIDTH * .5 + _sep, _h, 18, 18);
	with(_music_max_button) {
		text = fx() { return "+" };
		color = #ff5555;
		depth = 5;
		action = fx() {
			GAME_INFO.volume_music.value = clamp(GAME_INFO.volume_music.value + GAME_INFO.volume_music.value_change_snap, GAME_INFO.volume_music.value_min, GAME_INFO.volume_music.value_max);
			update_save();
		}
	}
	push_content(_music_max_button);
	
	_h += 28;
	
#endregion

#region Sfx Volume
	
	var _sfx_min_button = new UiButton(GUI_WIDTH * .5 - _sep, _h, 18, 18);
	with(_sfx_min_button) {
		text = fx() { return "-" };
		color = #ff5555;
		depth = 5;
		action = fx() {
			GAME_INFO.volume_sfx.value = clamp(GAME_INFO.volume_sfx.value - GAME_INFO.volume_sfx.value_change_snap, GAME_INFO.volume_sfx.value_min, GAME_INFO.volume_sfx.value_max);
			update_save();
		}
	}
	push_content(_sfx_min_button);
	
	var _sfx = new UiText(GUI_WIDTH * .5, _h - 6, 150, 24);
	with(_sfx) {
		text = fx() { return $"[fnt_pb]Vol. Ef. Sonoro:[fnt_p] {round(GAME_INFO.volume_sfx.value * 100)}%" };
		text_scribble = true;
		text_valign = fa_top;
	}
	push_content(_sfx);
	
	var _sfx_max_button = new UiButton(GUI_WIDTH * .5 + _sep, _h, 18, 18);
	with(_sfx_max_button) {
		text = fx() { return "+" };
		color = #ff5555;
		depth = 5;
		action = fx() {
			GAME_INFO.volume_sfx.value = clamp(GAME_INFO.volume_sfx.value + GAME_INFO.volume_sfx.value_change_snap, GAME_INFO.volume_sfx.value_min, GAME_INFO.volume_sfx.value_max);
			update_save();
		}
	}
	push_content(_sfx_max_button);
	
	_h += 28;
	
#endregion

#region Buttons

	var _fullscreen = new UiButton(GUI_WIDTH * .5, GUI_HEIGHT * .82 - 52, 110, 32);
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

var _back_button = new UiButton(GUI_WIDTH * .5, GUI_HEIGHT * .81, 120, 24);
with(_back_button) {
	text = fx() { return "Voltar" };
	color = #ff5555;
	depth = 5;
	action = fx() {
		owner.close();
	}
}
push_content(_back_button);