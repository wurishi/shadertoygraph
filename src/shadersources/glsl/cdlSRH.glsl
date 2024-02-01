void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    float waterLine = 0.33;
    
    // Reveser x-axis as first thing for easier webcam understanding
    fragCoord.x = iResolution.xy.x - fragCoord.x;
    
    // Normalized pixel coordinates (from 0 to 1)
    vec2 input_pixel = fragCoord/iResolution.xy;
    
    if(input_pixel.y < waterLine)
    {
        float distance_to_waterline = (waterLine - input_pixel.y) / waterLine;
        input_pixel.y = waterLine + (waterLine - input_pixel.y) * 2.0;
        
        float speed = 5.0;
        float wave_height = distance_to_waterline * 200.0  * (iResolution.xy.y / 1000.0);
        float wave_width = distance_to_waterline * 0.1 * (iResolution.xy.y / 1000.0);
        
        input_pixel.x += cos(iTime*speed + fragCoord.y / wave_height) * wave_width;
    }
    
    // get pixel information from uv location
    vec4 texColor = texture(iChannel0, input_pixel);
    
    texColor *= 1.5;
    
    // Output to screen
    fragColor = vec4(texColor);
    
    if(abs(input_pixel.y - waterLine) < 0.002)
    {
        fragColor *= 0.8;;
    }
}