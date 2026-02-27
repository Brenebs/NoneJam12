/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor



timer--;



if(timer<=0)
{
	scale -= .01;
	if(scale <=0)
	{
		instance_destroy();
	}
}
else
{
	scale = lerp(scale , image_xscale , .1);
}