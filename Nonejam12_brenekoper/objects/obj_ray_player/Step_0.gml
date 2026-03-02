/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

if(global.pause) return;

current_between_hits--;

if(current_between_hits<=0)
{
	hurt_enemies();
}