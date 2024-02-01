// 2x2 hash algorithm.
vec2 hash22(vec2 p) { 
    
    // This line makes the pattern repeatable. 
    p = mod(p, 5.); 

    // More concise, but wouldn't disperse things as nicely as other versions.
    float n = sin(dot(p, vec2(41, 289))); 
    return fract(vec2(8, 1)*262144.*n);

    //p = fract(vec2(8, 1)*262144.*n);
    //return sin(p*6.283 + iTime)*0.5 + 0.5;

}


// 2D 2nd-order Voronoi: Obviously, this is just a rehash of IQ's original. I've tidied
// up those if-statements. Since there's less writing, it should go faster. That's how 
// it works, right? :)
//
float voronoi(in vec2 p){
    
	vec2 g = floor(p), o; p -= g;
	
	vec3 d = vec3(1); // 1.4, etc. "d.z" holds the distance comparison value.
    
	for(int y = -1; y <= 1; y++){
		for(int x = -1; x <= 1; x++){
            
			o = vec2(x, y);
            o += hash22(g + o) - p;
            
			d.z = dot(o, o);            
            d.y = max(d.x, min(d.y, d.z));
            d.x = min(d.x, d.z); 
                       
		}
	}
	
	
    return d.y - d.x;
    // return d.x;
    // return max(d.y*.91 - d.x*1.1, 0.)/.91;
    // return sqrt(d.y) - sqrt(d.x); // etc.
}

// Prerendering a simple stone texture to one of the offscreen buffers. The process is simple, but
// definitely not simple enough to calculate it on the fly inside a distance function.
//
// There is one minor complication, and that is the texture needs to be repeatable. That's its own
// discussion, but if you're not sure how it's achieved, the key to repeatable Voronoi are the lines 
// "p = mod(p, 5)" and "float c = voronoi(p*5.)... ." I'm sure you'll figure it out from there. :)
//
// The random pixelization business is just a hacky way to redraw the texture when the canvas is resized.
// Definitely not the best way to go about it, that's for sure.
//
void mainImage( out vec4 fragColor, in vec2 fragCoord ){

    // Offscreen buffer coordinates.
    vec2 p = fragCoord.xy/iResolution.xy;

    // On the first frame, render the entire texture. Otherwise, randomly render every 8 pixels,
    // which, in theory, should lessen the workload. I'm continuously rendering parts of the texture
    // to account for resizing events. If you resize, the new heighmap will quickly pixel fade in.
    
    // Obviously, a better solution would be to detect a resize and render the texture just once, or 
    // better yet, have a fixed size offscreen buffer option... Although, that sounds like a backend 
    // nightmare. :)
    //if(hash22(p + iTime).x< 1./8. || iFrame==0){
    if(floor(hash22(p + iTime).x*8.)< 1. || iFrame==0){    
        
        // The stone texture. I made this up on the spot. Basically add three second order Voronoi
        // layers of varying amplitudes and frequency. Also, perturb the initial UV coordinates
        // to give it more of a natural look. Finally, add some fine detailing via one of Shadertoy's
        // in-house textures. By the way, you could generate that also, but I didn't want to 
        // overcomplicate a simple example.
        
        // Texture value. Reversing the channels for a different color variation.
        vec3 tx = texture(iChannel1, p).xyz; tx *= tx;
        tx = smoothstep(0., .5, tx);
        
        // Perturbing the UV coordinates just slightly to give the stones a slightly more natural feel.
        // Note the PI frequencies. That's for texture wrapping purposes.
        p += sin(p*6.283*2. - cos(p.yx*6.283*4.))*.01;
        
        // Three Voronoi layers. Pretty standard. I could have put a lot more effort into this
        // part, but it's just a simple proof of concept, so just three lazy layers.
        
        // More stone looking.
        //float c = voronoi(p*5.)*.8 + voronoi(p*15.)*.15 + voronoi(p*45.)*.05;
        
        // Less detail.
        //float c = voronoi(p*5.) - (1.-voronoi(p*15.))*.08 + voronoi(p*45.)*.04;
        
       
        //float c = voronoi(p*5.)*.6 + voronoi(p.yx*5. + vec2(2.666, 1.666))*.4 - (1.-voronoi(p*15.))*.08 + voronoi(p*45.)*.04;
        float c = voronoi(p*5. - .35)*.6 + voronoi((p.yx + .5)*10.)*.3 + (1.-voronoi(p*25.))*.075 + voronoi(p*60.)*.025;
 
        

        // Finally, using the greyscale texture value to add some fine detailing.
        c += dot(tx, vec3(.299, .587, .114))*.1;
        
        
        // Storing away the values for use in the main part of the application.
        fragColor.xyz = tx; // Put the texture color in the XYZ channels.
        fragColor.w = min(c/1.1, 1.); // Store the heightmap value in the "W" channel.


    }
    // Copy the rest of the pixels over to the new frame. Obvious, but it'd been a while, so I had to 
    // figure that one out. :)
    else fragColor = texture(iChannel0, p); 
    
}