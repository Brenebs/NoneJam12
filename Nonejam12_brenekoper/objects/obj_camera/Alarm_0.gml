/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor



update_camera()

if(instance_exists(alvo))
{
	x=alvo.x;
	y=alvo.y;
	
	if(room == rm_gameplay)
	{
		y = -150
	}
	
	camera_set_view_pos(view_camera[0] , x + (CAMERA_WIDTH/2) , y + (CAMERA_HEIGHT/2) )
	
}