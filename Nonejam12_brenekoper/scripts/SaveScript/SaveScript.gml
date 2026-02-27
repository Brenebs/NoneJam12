
//cria uma opção no menu de opção ou acessibilidade numérico, definindo um valor maximo, minimo e quanto que ele é alterado ao ir para direita/esquerda
function create_options_numeric(_value , _value_min = 0 , _value_max = 1, _value_change_snap = 0.1) constructor
{
	value			  = _value
	value_min		  = _value_min
	value_max		  = _value_max
	value_change_snap = _value_change_snap
}

//informção importante do jogo que deve ser salvo
function create_saveable_info() constructor
{
	//volume
	volume_main		= new create_options_numeric(.5);
	volume_sfx		= new create_options_numeric(.5);
	volume_music	= new create_options_numeric(.5);
	
	//variaveis do menu de opções
	fullscreen = false;
	use_mouse = false;
	
	//coisas que o player fez
	
	drops_colected = better_array_create(SLOTS_MINERAL_MIN,undefined)
	
	coins = 0;

	enemies_killed = 0;
	
	max_roadblock_destroyed = 0;
	max_chunk_achiev = 0;
	
	//melhorias
	
	upgrades = {}
	with(upgrades)
	{
		//Broca
		drill_level				 = 0;
		drill_damage			 = 0;
		drill_eletric			 = 0;
		drill_range				 = 0;
		drill_speed				 = 0;
		drill_triple			 = 0;
		
		//Dash
		dash_unlocked			 = 0;
		dash_colector			 = 0;
		dash_distance			 = 0;
		dash_eficiency			 = 0;
		dash_damage				 = 0;
		dash_load				 = 0; 
		dash_critic				 = 0;
		
		//Energy
		energy_max				 = 0; //carga maxima
		energy_movement			 = 0; //movimentação eficiente
		energy_drill_damage		 = 0; //broca eficiente
		energy_still			 = 0; //motor eficiente
		energy_invencibility	 = 0; //Invencibidade ao tomar dano
		energy_resistency		 = 0; //resistencia a danos
		energy_leech			 = 0; //sangue suga
		
		//Extras
		ext_slot_total			 = 0;
		ext_slot_lenght			 = 0;
		
		ext_selling_slots		 = 0;
		ext_selling_clients		 = 0;
		
		ext_magnet				 = 0;
		
		ext_drill_bot			 = 0;
		ext_drill_bot_eficiency  = 0;
		
		ext_tnt					 = 0;
		ext_tnt_area			 = 0;
		ext_tnt_damage			 = 0;
		
		ext_more_drops			 = 0;
		ext_lost_drops			 = 0;
		ext_life_saver			 = 0;
		ext_pointer				 = 0;
		
		//Fogão
		cooker_number			 = 0;
		cooker_faster			 = 0;
		cooker_seasoning		 = 0;
		cooker_ideal			 = 0;
		cooker_propaganda		 = 0;
		cooker_auto				 = 0;
		cooker_selling			 = 0;
		
	}
	
}


global.game_save = new create_saveable_info();


//coisas que devem ser atualizadas após mexer numa variavel 
function update_save()
{
	audio_group_set_gain(ag_musics	,GAME_INFO.volume_music.value	* GAME_INFO.volume_main.value,100);
	audio_group_set_gain(ag_sfx		,GAME_INFO.volume_sfx.value		* GAME_INFO.volume_main.value,100);
	
	window_set_fullscreen(GAME_INFO.fullscreen);
}

#region save load de fato

	function save_game()
	{
		var file = file_text_open_write(working_directory + SAVE_NAME);
	
		var _txt = json_stringify(global.game_save,true);
		file_text_write_string(file, _txt);
	
		file_text_close(file);
	}

	function load_game()
	{
	
		var file = file_text_open_read(working_directory + SAVE_NAME);
	
		var _txt = "nope"
		if(file!=-1)
		{
			var _content = "";
			while(true)
			{
				if(file_text_eof(file))
				{
					break;
				}
				else
				{
					_content += file_text_readln(file);
				}
			}
		
			_txt = json_parse(_content)
		
			show_debug_message($"old arquivo save = {_txt}");
			struct_copy_missing_variables(global.game_save,_txt);
			show_debug_message($"novo arquivo save = {_txt}");
			
			delete global.game_save;
			global.game_save = _txt;
		
			file_text_close(file);
		}
		
	}
	call_later(1,time_source_units_frames,load_game);
	call_later(5,time_source_units_frames,update_save);
	
#endregion