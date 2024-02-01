//
// __ __|  |   |  ____|   \  |         \      \  |  __ \       __ )   ____|  ____|  _ \    _ \   ____| 
//    |    |   |  __|      \ |        _ \      \ |  |   |      __ \   __|    |     |   |  |   |  __|   
//    |    ___ |  |      |\  |       ___ \   |\  |  |   |      |   |  |      __|   |   |  __ <   |     
//   _|   _|  _| _____| _| \_|     _/    _\ _| \_| ____/      ____/  _____| _|    \___/  _| \_\ _____| 
//
//
//                                                                         4k PC intro - Altair MMXIX
//
//
//    Code & design:    KK
//    Music & design:   Lesnik
//    Add. code:        Virgill
//
//
//
//


void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy/iResolution.xy;
    fragColor = texture(iChannel0, uv);
}
