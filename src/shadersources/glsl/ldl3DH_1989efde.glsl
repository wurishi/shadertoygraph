
// From
// https://github.com/timsawtell/Greenscreen/blob/master/GreenScreen/Shaders/greenScreen.fsh
vec4 removeGreenScreen(vec4 inColor)
{
   // Calculate the average intensity of the texel's red and blue components
   lowp float rbAverage = inColor.r * 0.7 + inColor.b * 0.7;
   
   // Calculate the difference between the green element intensity and the
   // average of red and blue intensities
   lowp float gDelta = inColor.g - rbAverage;
   
   // If the green intensity is greater than the average of red and blue
   // intensities, calculate a transparency value in the range 0.0 to 1.0
   // based on how much more intense the green element is
   inColor.a = 1.0 - smoothstep(0.00, 0.90, gDelta);
   
   // Use the cube of the of the transparency value. That way, a fragment that
   // is partially translucent becomes even more translucent. This sharpens
   // the final result by avoiding almost but not quite opaque fragments that
   // tend to form halos at color boundaries.
   inColor.a = inColor.a * inColor.a * inColor.a;
      
   return inColor;
}


void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    float s=0.,v=0.;
    for (int r=0; r<150; r++) {
        vec3 p=vec3(vec2(.1,.2)+s*fragCoord.xy*0.001,fract(s+floor(iTime*25.)*.01));
		
        for (int i=0; i<10; i++) p=abs(p)/dot(p,p)-.5;
        v+=length(p*p)*(2.-s)*.001;
        s+=.01;
    }
	
	vec4 videoPixel = texture(iChannel0, fragCoord.xy / iResolution.xy);
	vec4 videoPixelFiltered = removeGreenScreen(videoPixel);
	
   	fragColor = vec4(v) * vec4(0.5,0.8,0.4,1.) * (1. - videoPixelFiltered.a) + videoPixel * videoPixelFiltered.a;
}