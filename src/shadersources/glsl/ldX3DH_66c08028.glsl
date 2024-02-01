#define time (iTime*0.16)

const float pi = 3.14159265;

vec4 effect1(in vec2 fragCoord) {

  vec2 newPos = fragCoord.xy / iResolution.xy ;
   
   
   newPos = (newPos -0.5);
   
   float k= 1.8;
   float rd = length(newPos);
   float ru = rd*(1.0+ k*rd*rd);
   
   newPos = newPos/length(newPos) * ru +0.5;
   
   vec2 oldPos = newPos;
   float angle = pi/4.0;
   newPos = vec2(oldPos.x *cos(angle) - oldPos.y *sin(angle),
   					  oldPos.y *cos(angle) + oldPos.x *sin(angle));
   
    vec2 coords=newPos*vec2(0.15,-1)*3.1+vec2(time*1.3,time*1.3);
	
	
		vec2 texcoord = vec2(coords.x*0.3,coords.y*0.3);
   
	
   vec4 final = texture(iChannel0,vec2(mod(texcoord.x,0.14),mod(texcoord.y,0.9)));
  
	
   vec2 oldPos2 = (fragCoord.xy/iResolution.xy );
	final = final *0.7  +(0.3*30.0*oldPos2.x*oldPos2.y*(1.0-oldPos2.x)*(1.0-oldPos2.y));
	   
//final = final *0.7  +(0.3*30.0*oldPos2.x*oldPos2.y*(1.0-oldPos2.x)*(1.0-oldPos2.y));
	  // rasters

   float size = 0.4;
   vec4 temp2 = vec4(0,0,0,0);
   for(float i=0.0; i < 10.0; i++) {
      float pos2 = +360.0/2.0+sin(time*10.0+0.16*i) *60.0;
   float col2 = (cos((fragCoord.y-pos2)*size) +1.0)/2.0;
   col2 = pow(col2+0.1,3.0);
   //float al2 = (1-smoothstep(pi-0.01,  pi, (fragCoord.y-pos2)*size))*(1-smoothstep(-pi+0.01,  -pi, (fragCoord.y-pos2)*size));
  float al2 =(1.0-smoothstep(pi-0.9,  pi-0.89, (fragCoord.y-pos2)*size))*(1.0-smoothstep(-pi+0.9,  -pi+0.89, (fragCoord.y-pos2)*size));
  float red = (cos(pi*i/10.0/0.5+time*3.0)+1.0)/2.0;
	float green = (sin(pi*i/10.0/0.5+time*3.0)+1.0)/2.0;
	float blue = (sin(+time*3.0)+1.0)/2.0;
	float luma = red*0.3 + green*0.59+ blue*0.11;
	float alpha = 0.6;
	red = red*(1.0-alpha) + luma*(alpha);
	green = green*(1.0-alpha) + luma*(alpha);
	blue = blue*(1.0-alpha) + luma*(alpha);
  
   final =final*(1.0-al2)+ al2* vec4(col2*red,col2*green, col2*blue,1.0);
   }
  return vec4(final.xyz, 1.0);
}

vec4 rasters (vec4 color, in vec2 fragCoord) {
  // rasters

	vec4 final = color;
   float size = 0.4;
   vec4 temp2 = vec4(0,0,0,0);
   for(float i=0.0; i < 10.0; i++) {
      float pos2 = +360.0/2.0+sin(time*10.0+0.16*i) *60.0;
   float col2 = (cos((fragCoord.y-pos2)*size) +1.0)/2.0;
   col2 = pow(col2+0.2,2.0);
   //float al2 = (1-smoothstep(pi-0.07,  pi-0.05, (fragCoord.y-pos2)*size))*(1-smoothstep(-pi+0.07,  -pi+0.05, (fragCoord.y-pos2)*size));
  float al2 =(1.0-smoothstep(pi-0.9,  pi-0.89, (fragCoord.y-pos2)*size))*(1.0-smoothstep(-pi+0.9,  -pi+0.89, (fragCoord.y-pos2)*size));
  float red = (cos(pi*i/10.0/0.5+time*3.0)+1.0)/2.0;
	float green = (sin(pi*i/10.0/0.5+time*3.0)+1.0)/2.0;
	float blue = (sin(+time*3.0)+1.0)/2.0;
	
		float luma = red*0.3 + green*0.59+ blue*0.11;
	float alpha = 0.6;
	red = red*(1.0-alpha) + luma*(alpha);
	green = green*(1.0-alpha) + luma*(alpha);
	blue = blue*(1.0-alpha) + luma*(alpha);
  
  
   final =final*(1.0-al2)+ al2* vec4(col2*red,col2*green, col2*blue,1.0);
   }
   return final;
}

vec4 effect2(in vec2 fragCoord) {

	vec2 position = vec2(640.0/2.0+640.0/2.0*sin(time*2.0), 360.0/2.0+360.0/2.0*cos(time*3.0));
	vec2 position2 = vec2(640.0/2.0+640.0/2.0*sin((time+2000.0)*2.0), 360.0/2.0+360.0/2.0*cos((time+2000.0)*3.0));
	
	
	vec2 offset = vec2(iResolution.x /2.0,  iResolution.y /2.0) ;
	vec2 offset2 = vec2(6.0*sin(time*1.1), 3.0*cos(time*1.1));
   
   vec2 oldPos = (fragCoord.xy-offset);
   
   float angle = time*2.0;
   
   vec2 newPos = vec2(oldPos.x *cos(angle) - oldPos.y *sin(angle),
   					  oldPos.y *cos(angle) + oldPos.x *sin(angle));
   
        
        newPos = (newPos)*(0.0044+0.004*sin(time*3.0))-offset2;
        vec2 temp = newPos;
       // newPos.x = temp.x + 0.4*sin(temp.y*2+time*8);
       // newPos.y = (-temp.y + 0.4*sin(temp.x*2+time*8));
		vec2 texcoord = newPos*vec2(0.15,-1);
   vec4 final = texture(iChannel0,vec2(mod(texcoord.x,0.14),mod(texcoord.y,0.9)));
	//final = texture(texCol,fragCoord.xy*vec2(1.0/640, -1.0/360));
	  
	  
	   vec2 oldPos2 = (fragCoord.xy/iResolution.xy );
	final = final *0.7  +(0.3*30.0*oldPos2.x*oldPos2.y*(1.0-oldPos2.x)*(1.0-oldPos2.y));
	  // rasters

   float size = 0.4;
   vec4 temp2 = vec4(0,0,0,0);
   for(float i=0.0; i < 10.0; i++) {
      float pos2 = +360.0/2.0+sin(time*10.0+0.16*i) *60.0;
   float col2 = (cos((fragCoord.y-pos2)*size) +1.0)/2.0;
   col2 = pow(col2+0.2,2.0);
   //float al2 = (1-smoothstep(pi-0.07,  pi-0.05, (fragCoord.y-pos2)*size))*(1-smoothstep(-pi+0.07,  -pi+0.05, (fragCoord.y-pos2)*size));
  float al2 =(1.0-smoothstep(pi-0.9,  pi-0.89, (fragCoord.y-pos2)*size))*(1.0-smoothstep(-pi+0.9,  -pi+0.89, (fragCoord.y-pos2)*size));
  float red = (cos(pi*i/10.0/0.5+time*3.0)+1.0)/2.0;
	float green = (sin(pi*i/10.0/0.5+time*3.0)+1.0)/2.0;
	float blue = (sin(+time*3.0)+1.0)/2.0;
	
		float luma = red*0.3 + green*0.59+ blue*0.11;
	float alpha = 0.6;
	red = red*(1.0-alpha) + luma*(alpha);
	green = green*(1.0-alpha) + luma*(alpha);
	blue = blue*(1.0-alpha) + luma*(alpha);
  
  
   final =final*(1.0-al2)+ al2* vec4(col2*red,col2*green, col2*blue,1.0);
   }
   //float alp = temp2.a;//* max(min(0.5+10*sin(time*1.2),1),0);
   //final =  final *(1-alp) +(alp)*temp2;
	
 return vec4(final.xyz, 1.0);
   }
  vec3 mod289(vec3 x) { return x - floor(x * (1.0 / 289.0)) * 289.0; }
vec2 mod289(vec2 x) { return x - floor(x * (1.0 / 289.0)) * 289.0; }
vec3 permute(vec3 x) { return mod289(((x*34.0)+1.0)*x); }
float snoise (vec2 v)
{
    const vec4 C = vec4(0.211324865405187,  // (3.0-sqrt(3.0))/6.0
                        0.366025403784439,  // 0.5*(sqrt(3.0)-1.0)
                        -0.577350269189626, // -1.0 + 2.0 * C.x
                        0.024390243902439); // 1.0 / 41.0

    // First corner
    vec2 i  = floor(v + dot(v, C.yy) );
    vec2 x0 = v -   i + dot(i, C.xx);

    // Other corners
    vec2 i1;
    i1 = (x0.x > x0.y) ? vec2(1.0, 0.0) : vec2(0.0, 1.0);
    vec4 x12 = x0.xyxy + C.xxzz;
    x12.xy -= i1;

    // Permutations
    i = mod289(i); // Avoid truncation effects in permutation
    vec3 p = permute( permute( i.y + vec3(0.0, i1.y, 1.0 ))
        + i.x + vec3(0.0, i1.x, 1.0 ));

    vec3 m = max(0.5 - vec3(dot(x0,x0), dot(x12.xy,x12.xy), dot(x12.zw,x12.zw)), 0.0);
    m = m*m ;
    m = m*m ;

    // Gradients: 41 points uniformly over a line, mapped onto a diamond.
    // The ring size 17*17 = 289 is close to a multiple of 41 (41*7 = 287)

    vec3 x = 2.0 * fract(p * C.www) - 1.0;
    vec3 h = abs(x) - 0.5;
    vec3 ox = floor(x + 0.5);
    vec3 a0 = x - ox;

    // Normalise gradients implicitly by scaling m
    // Approximation of: m *= inversesqrt( a0*a0 + h*h );
    m *= 1.79284291400159 - 0.85373472095314 * ( a0*a0 + h*h );

    // Compute final noise value at P
    vec3 g;
    g.x  = a0.x  * x0.x  + h.x  * x0.y;
    g.yz = a0.yz * x12.xz + h.yz * x12.yw;
    return 130.0 * dot(m, g);
}
      
      vec4  textureB(sampler2D s,vec2 pos) {
      vec4 final = texture(iChannel0,pos)*0.5;
      	 final.r += 0.4*texture(iChannel0,pos +0.5*vec2(+0.04, 0)).r;
	  final.g += 0.4*texture(iChannel0,pos +0.5*vec2(+0.02, 0)).g;
	   final.b += 0.4*texture(iChannel0,pos +0.5*vec2(+0.0, 0)).b;
	   
return final;
      }  

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{

	vec4 e1 = effect1(fragCoord);
	vec4 e2 = effect2(fragCoord);
	
		vec2 offset = iResolution.xy ;

   
   vec2 oldPos = (fragCoord.xy/offset);
 
 float a = min(max((5.0*sin(time+(fragCoord.x+fragCoord.y)*0.0005)+0.5),0.0),1.0);
 vec4 final =
  (e1*a + e2*(1.0-a));
  //final = final * 0.7
  
  final = final*0.8 + final *0.3*(1.0+snoise(oldPos*100.0+vec2(time*1312.2,time*1333.2)))/2.0;
   


   
    vec2 oldPos2 = (fragCoord.xy/iResolution.xy  );
    vec2 oldPos3 = (fragCoord.xy/iResolution.xy );
   // oldPos2 = oldPos2*vec2(2,2);
    float x = cos(6.0*time*0.8);
 	float y = sin(4.0*time*0.8);
    
    vec2 pos = vec2(0.5+0.3*x,0.5+ 0.2*y);
    //  final = texture(texCol,(oldPos2+vec2(time*0.1,time*0.1))*10);
    float radius = 0.35;//0.35
   //final= vec4(0);
    float offx=0.0;
    float offy=0.0;
    float MAG= 0.35*(1.0/radius);//0.35*(1/radius);
      vec2 texcoord = vec2((oldPos.x+offx),(oldPos.y+offy))*vec2(0.7,-1.)*vec2(0.6,1.8)+vec2(sin(8.0*time*.1),cos(4.0*time*.1));
  final=texture(iChannel0,vec2(mod(texcoord.x,0.14),mod(texcoord.y,0.9)))
   ;//*(1-smoothstep(radius-0.001, radius, length(oldPos2)));
  
// final = final *0.5  +(0.3*30.0*oldPos3.x*oldPos3.y*(1.0-oldPos3.x)*(1.0-oldPos3.y))
// -vec4(0.8,0.8,0.5,0)*0.1;
 
 //final = vec4(0);
	for(float i=0.0; i < 2.0; i++ ) {
  
       float x = cos(1.0*time*2.0+i*pi);
 	float y = sin(1.0*time*2.0+i*pi);
    
    vec2 pos = vec2(0.5+0.32*x,0.5+ 0.36*y);
  //  oldPos2 = oldPos2*vec2(0.8,0.8);
    if((oldPos2.x-pos.x)*(oldPos2.x-pos.x)*1.7*1.7 + (oldPos2.y-pos.y)*(oldPos2.y-pos.y) < radius *radius) {
   
   vec2 posi;
    float z =1.0-1.0/sqrt( -(oldPos2.x-pos.x)*1.7*1.7*(oldPos2.x-pos.x) - (oldPos2.y-pos.y)*(oldPos2.y-pos.y)+radius*radius );
    	posi.x=(oldPos.x-pos.x)/z*MAG+(oldPos.x);
    	posi.y=(oldPos.y-pos.y)/z*MAG+(oldPos.y);

 
 		float alpha = 0.0
 		+(1.0-smoothstep(radius-0.003,radius,sqrt((oldPos2.x-pos.x)*1.7*1.7*(oldPos2.x-pos.x) + (oldPos2.y-pos.y)*(oldPos2.y-pos.y))))
 		;
 		float exp = (sqrt((oldPos2.x-pos.x)*1.7*1.7*(oldPos2.x-pos.x) + (oldPos2.y-pos.y)*(oldPos2.y-pos.y)) / sqrt(radius *radius));
 		float exp2 =(sqrt((oldPos2.x-pos.x+radius*0.3)*1.7*1.7*(oldPos2.x-pos.x+radius*0.3) + (oldPos2.y-pos.y-radius*0.3)*(oldPos2.y-pos.y-radius*0.3)) / sqrt(radius*1.24 *radius*1.24));

 		
		vec2 texcoord = vec2((posi.x),(posi.y))*vec2(.7,-1.)*vec2(0.6,1.8)+vec2(sin(8.0*time*.1),cos(4.0*time*.1));
    	vec4 color=((
    	vec4(0.8,1.0,0.8,0)*(0.2+0.9*(1.0-exp*exp*exp)*
		texture(iChannel0,vec2(mod(texcoord.x,0.14),mod(texcoord.y,0.9))
				 )))
    	
    	)-0.1*(exp)*(1.0+snoise(18.0*vec2((oldPos.x-pos.x)*1.7/z*MAG, (oldPos.y-pos.y)/z*MAG)))/2.0;
    	 float a= alpha;
    	alpha *=1.0;
    	final = final *(1.0-alpha) + alpha* color+a*vec4(0.9,0.9,1.0,0)*1.00*(1.0-exp2)*(1.0-exp2);
    	
   
    	
    } 
    
   }

   
  final = final*0.8 + final *0.3*(1.0+snoise(oldPos*100.0+vec2(time*1312.2,time*1333.2)))/2.0;
    
  float col = texture(iChannel1,vec2(0.23,0.0)).x;
  fragColor = final-0.1+0.5*vec4(vec3((col-0.6)*3.3,0.,0.),0.0);
  

}
