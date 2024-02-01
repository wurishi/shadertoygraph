
float hash1( vec2  p ) { float n = dot(p,vec2(127.1,311.7)); return fract(sin(n)*43758.5453); }

vec4 getParticle( vec2 id )
{
    return textureLod( iChannel0, (id+0.5)/iResolution.xy, 0.0);
}

vec4 react( in vec4 p, in vec2 qid, float rl )
{
    vec4 q = getParticle( qid );
    
    vec2 di = q.xy - p.xy;
    
    float l = length(di);
    
    p.xy += 0.1*(l-rl)*(di/l);
    
    return p;
}

vec4 solveContrainsts( in vec2 id, in vec4 p )
{
    if( id.x > 0.5 )  p = react( p, id + vec2(-1.0, 0.0), 0.1 );
    if( id.x < 8.5 )  p = react( p, id + vec2( 1.0, 0.0), 0.1 );
    if( id.y > 0.5 )  p = react( p, id + vec2( 0.0,-1.0), 0.1 );
    if( id.y < 8.5 )  p = react( p, id + vec2( 0.0, 1.0), 0.1 );

    if( id.x > 0.5 && id.y > 0.5)  p = react( p, id + vec2(-1.0, -1.0), 0.14142 );
    if( id.x > 0.5 && id.y < 8.5)  p = react( p, id + vec2(-1.0,  1.0), 0.14142 );
    if( id.x < 8.5 && id.y > 0.5)  p = react( p, id + vec2( 1.0, -1.0), 0.14142 );
    if( id.x < 8.5 && id.y < 8.5)  p = react( p, id + vec2( 1.0,  1.0), 0.14142 );

    return p;
}    

vec4 move( in vec4 p, in vec2 id )
{
    const float g = 0.6;

    // acceleration
    p.xy += iTimeDelta*iTimeDelta*vec2(0.0,-g);
    

    // colide screen
    if( p.x< 0.00 ) p.x = 0.00;
    if( p.x> 1.77 ) p.x = 1.77;
    if( p.y< 0.00 ) p.y = 0.00;        
    if( p.y> 1.00 ) p.y = 1.00;

    // constrains
    p = solveContrainsts( id, p );
        
    #if 1
    if( id.y > 8.5 ) p.xy = 0.05 + 0.1*id;
    #endif
    
    // innertia
    vec2 np = 2.0*p.xy - p.zw;
    p.zw = p.xy;
    p.xy = np;

    return p;
}




void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 id = floor( fragCoord-0.4 );
    
    if( id.x>9.5 || id.y>9.5 ) discard;
    
    vec4 p = getParticle(id);
    
    if( iFrame==0 )
    {
        p.xy = 0.05 + id*0.1;
        p.zw = p.xy - 0.01*vec2(0.5+0.5*hash1(id),0.0);
    }
    else
    {
    	p = move( p, id );
    }

    fragColor = p;
}