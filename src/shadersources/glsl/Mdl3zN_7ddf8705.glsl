// Simple raytracer in C64 graphics style
// 
// Version 1.0 (2013-04-01)
// Simon Stelling-de San Antonio


void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
  float camtime = 1.23*iTime;

  vec2 p = fragCoord.xy / iResolution.xy;
  p.y = 1.0 - p.y;
  p *= 200.0;
  p.x *= (iResolution.x / iResolution.y);
  p.x /= 2.0;
  p = floor(p);
  p.x *= 2.0;

  vec2 an = vec2( sin(iTime), cos(iTime) )*2700.0;

  // OK, starting here the code looks kind of funny
  // because it's a very straight port from a C128 BASIC 7.0 program. :)
  float c = 2500.0;
  float k = c/2.0;
  float e = 0.0;
  float f = -3000.0;
  float g = 0.0;
  float h = p.x-160.0;
  float j = 112.0-p.y;
  float s = sqrt(h*h+67600.0+j*j);
  h /= s;
  float i = 260.0/s;
  j /= s;
  float pp = i*3000.0+j*150.0;
  float d = pp*pp-8120000.0;
  if (d >= 0.0) {
    float l = pp-sqrt(d);
    if (l > 0.0) {
      e = l*h;
      f = f+l*i;
      g = l*j;
      float n = g-150.0;
      s = e*e+f*f+n*n;
      s = 2.0*(e*h+f*i+n*j)/s;
      h -= s*e;
      i -= s*f;
      j -= s*n;
    }
  }
  float b = 2.0;
  float q = 107.0-190.0*j;
  if (d >= 0.0) {
    q -= 40.0;
  }
  if (j < 0.0) {
    b = 1.0;
    float l = (g+2000.0)/j;
    float t = e-l*h+c/4.0+an.x;
    float u = f-l*i+an.y;
    t = floor((t-c*floor(t/c))/k);
    u = floor((u-c*floor(u/c))/k);
    q = 40.0 + 40.0*j;
    if (t == u) {
      q += 180.0*j - 88.0;
    }
  }
  float r = 88.0 - 19.0*(mod(p.y,4.0)+mod(p.x,4.0));
  float z = 3.0;
  if (q > -r) {
    if (q > r) {
      z -= 3.0;
    } else {
      z -= b;
    }
  }
  if ((j < 0.0) && (z == 3.0)) {
    z = 4.0;
  }

  float cc;
  if        (z ==  0.0) { cc =  3.0;
  } else if (z ==  1.0) { cc = 14.0;
  } else if (z ==  2.0) { cc = 10.0;
  } else if (z ==  3.0) { cc =  6.0;
  } else                { cc =  9.0;
  }
  vec3 col;
  if        (cc ==  0.0) { col = vec3(0.0);
  } else if (cc ==  1.0) { col = vec3(1.0);
  } else if (cc ==  2.0) { col = vec3(137.0,  64.0,  54.0)/256.0;
  } else if (cc ==  3.0) { col = vec3(122.0, 191.0, 199.0)/256.0;
  } else if (cc ==  4.0) { col = vec3(138.0,  70.0, 174.0)/256.0;
  } else if (cc ==  5.0) { col = vec3(104.0, 169.0,  65.0)/256.0;
  } else if (cc ==  6.0) { col = vec3( 62.0,  49.0, 162.0)/256.0;
  } else if (cc ==  7.0) { col = vec3(208.0, 220.0, 113.0)/256.0;
  } else if (cc ==  8.0) { col = vec3(144.0,  95.0,  37.0)/256.0;
  } else if (cc ==  9.0) { col = vec3( 92.0,  71.0,   0.0)/256.0;
  } else if (cc == 10.0) { col = vec3(187.0, 119.0, 109.0)/256.0;
  } else if (cc == 11.0) { col = vec3( 85.0,  85.0,  85.0)/256.0;
  } else if (cc == 12.0) { col = vec3(128.0, 128.0, 128.0)/256.0;
  } else if (cc == 13.0) { col = vec3(172.0, 234.0, 136.0)/256.0;
  } else if (cc == 14.0) { col = vec3(124.0, 112.0, 218.0)/256.0;
  } else                 { col = vec3(171.0, 171.0, 171.0)/256.0;
  }
  fragColor = vec4(col,1.0);
}
