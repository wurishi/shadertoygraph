// The MIT License
// Copyright © 2013 Inigo Quilez
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software. THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
// https://www.youtube.com/c/InigoQuilez
// https://iquilezles.org/

// Naive texture fetching of atan() based UVs can create some
// discontinuities in the derivatives (see a line of weird pixels
// on the left side of the sccren if you enable NAIVE_IMPLEMENTATION
// and if the viewport resolution is an odd number).
//
// This shader shows one way to fix it, in lines 41 and 42. More info:
//
// https://iquilezles.org/articles/tunnel


//#define NAIVE_IMPLEMENTATION


void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // normalized coordinates (-1 to 1 vertically)
    // 归一化坐标（竖直方向取值为-1.0~1.0）
    vec2 p = (-iResolution.xy + 2.0*fragCoord)/iResolution.y;

    // angle of each pixel to the center of the screen
    // 每个像素到屏幕中心的角度 返回值为弧度，多少多少pi
    float a = atan(p.y,p.x);

    #if 1
    // cylindrical tunnel
    // 圆柱隧道
    float r = length(p);
    #else
    // square tunnel
    // 正方形隧道
    float r = pow( pow(p.x*p.x,4.0) + pow(p.y*p.y,4.0), 1.0/8.0 );
    #endif
    
    // index texture by (animated inverse) radious and angle
    // 索引纹理的（动画反方向）半径和角度
    vec2 uv = vec2( 0.3/r + 0.2*iTime, a/3.1415927 );

    #ifdef NAIVE_IMPLEMENTATION
        // naive fetch color
        // 传统的采样
        vec3 col =  texture( iChannel0, uv ).xyz;
	#else
        // fetch color with correct texture gradients, to prevent discontinutity
        // 用正确的纹理梯度取颜色，以防止不连续性
        vec2 uv2 = vec2( uv.x, atan(p.y,abs(p.x))/3.1415927 );
        vec3 col = textureGrad( iChannel0, uv, dFdx(uv2), dFdy(uv2) ).xyz;
	#endif
    
    // darken at the center
    // 使中间变暗
    col = col*r;
    
    fragColor = vec4( col, 1.0 );
}
