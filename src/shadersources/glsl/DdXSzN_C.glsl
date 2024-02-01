vec4 getSample(in vec2 fragCoord)
{
    float restart = mod(float(iFrame), ROUNDS);
    
    vec4 fragColor;
    
    if (restart == 0.) 
        fragColor = texture(iChannel0,fragCoord/iChannelResolution[0].xy); 
    else 
        fragColor = texture(iChannel1,fragCoord/iChannelResolution[1].xy);   
        
    return fragColor;
}


void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    float restart = mod(float(iFrame), ROUNDS*2.);
    if(restart >= ROUNDS) {
        fragColor = texture (iChannel2, fragCoord.xy / iResolution.xy);
        return;
    }
    
   //Vertical blur
    

    vec4 tempColor = vec4(EPSILON);
    float divisor = EPSILON;
    

    for (int i = -RADIUS_Y; i <= RADIUS_Y; i++)
    {   
        
        vec4 pixel = getSample(fragCoord + vec2(0, i));
        
        
        if(pixel.w > 0.5)
        {
           tempColor += pixel;
           divisor += 1.0;
        }
        
    }
    
    if(divisor > EPSILON) {
       fragColor = tempColor* 1.0/divisor;
    }
    else {
       fragColor = getSample(fragCoord);
    }

}