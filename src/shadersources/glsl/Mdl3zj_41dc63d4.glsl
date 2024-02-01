void mainImage( out vec4 fragColor, in vec2 fragCoord ) {

     vec2 position = (fragCoord.xy/iResolution.xy);

     float cX = position.x - 0.5;
     float cY = position.y - 0.5;

     float newX = log(sqrt(cX*cX + cY*cY));
     float newY = atan(cX, cY);
    
    //float newX = cX;
    //float newY = cY;
     
     float color = 0.0;
     color += cos( newX * cos(iTime / 10.0 ) * 40.0 ) + cos( newX * cos(iTime / 25.0 ) * 10.0 );
     color += cos( newY * cos(iTime / 10.0 ) * 40.0 ) + cos( newY * sin(iTime / 25.0 ) * 10.0 );
     color += tan( newX * sin(iTime / 10.0 ) * 40.0 ) + cos( newY * sin( iTime / 25.0 ) * 10.0 );
     //color += tan( newY * sin(iTime / 10.0 ) * 40.0 ) + cos( newX * sin( iTime / 25.0 ) * 10.0 );
    
    
     color *= cos(iTime / 10.0 ) * 0.5;

     fragColor = vec4( vec3( color, color * 0.5, sin( color + iTime / 3.0 ) * 0.75 ), 1.0 );

}