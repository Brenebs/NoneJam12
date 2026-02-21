
current_biom = 0;

bioms = 
[
	[spr_background_biom1 , (30  - .5) * CHUNK_HEIGHT , 1],
	[spr_background_biom2 , (55  - .5) * CHUNK_HEIGHT , 1],
	[spr_background_biom3 , (80  - .5) * CHUNK_HEIGHT , 1],
	[spr_background_biom4 , (105 - .5) * CHUNK_HEIGHT , 1],
	[spr_background_biom5 , (130 - .5) * CHUNK_HEIGHT , 1]
	
]

bioms_transition_offset = CHUNK_HEIGHT*3

bioms_len = array_length(bioms);