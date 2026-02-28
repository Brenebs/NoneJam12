
//checar sala pra ver se pode ou não pausar o projeto

if (room != rm_main_menu && room != rm_skill_tree) GAMEPLAY_ROOM = true;
else GAMEPLAY_ROOM = false;

global.wave_pot = 0;