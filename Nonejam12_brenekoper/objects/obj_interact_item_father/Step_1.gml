/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

is_hovered = false;

xscale_force = spring_lerp(xscale , xscale_force , 1 , .5 , .1);
xscale += xscale_force;

yscale_force = spring_lerp(yscale , yscale_force , 1 , .5 , .11);
yscale += yscale_force;