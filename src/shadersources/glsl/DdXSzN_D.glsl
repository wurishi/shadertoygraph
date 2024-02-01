
vec4 getSample(in vec2 fragCoord)
{
    vec4 fragColor;
    fragColor = texture(iChannel0,fragCoord/iChannelResolution[0].xy);  
    return fragColor;
}



void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    
    //horizontal blur
    
   
    vec4 tempColor = vec4(EPSILON);
    float divisor = EPSILON;
    

    for (int i = -RADIUS_Y; i <= RADIUS_Y; i++)
    {   
        
        vec4 pixel = getSample(fragCoord + vec2(i,0));
        
        
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