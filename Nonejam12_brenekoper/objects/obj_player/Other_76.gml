/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//same_sprite

if (event_data[? "event_type"] == "sprite event")
{
    switch (event_data[? "message"])
    {
        case "same_sprite":
           image_index = image_index-.5;
        break;
    }
}