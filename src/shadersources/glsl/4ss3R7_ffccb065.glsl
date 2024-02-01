
//uniform float zoom, viewX, viewY, colorPick;
float zoom;
float viewX;
float viewY = 0.9562865;
float colorPick = 0.0;

vec2 fragCoord;
vec4 fragColor;

void drawSquare(vec2 square, float width, float girth);
void drawCircle(vec2 circle, float width, float girth);
void drawTriangle(vec2 triangle, float hypotenuse, float girth);
vec2 p = vec2(0.0, 0.0);
void mainImage( out vec4 oFragColor, in vec2 iFragCoord ) {
    zoom = 1.0/iTime;
    viewX =  -0.1010964/(iResolution.x/iResolution.y);
    fragCoord = iFragCoord;
    p.x = 2.0 * (fragCoord.x) * (1.0/iResolution.x)-1.0; p.y = 2.0 * (fragCoord.y) * (1.0/iResolution.y)-1.0;
    p.x = (pow(zoom, 5.0)) * p.x + viewX; p.y = (pow(zoom, 5.0)) * p.y + viewY;
p.x = (iResolution.x/iResolution.y) * p.x;
    vec2 z = vec2(0.0, 0.0); vec2 oldz = vec2(0.0, 0.0);
    int cnt = 0;
    for (int i = 0; i<100; i++) {
    if (z.x * z.x + z.y*z.y < 4.0) {
        cnt++; oldz = z;
        z.x = oldz.x * oldz.x - oldz.y * oldz.y + p.x; z.y = oldz.r * oldz.y + oldz.y * oldz.r + p.y;
    } else { break;}}
    if(colorPick == 0.0) {
        if(cnt == 100) { fragColor = vec4(0.0625, 0.25, 0.25, 1.0); }
        else if (mod(float(cnt), 30.0) < 15.0)
            { fragColor = vec4(0.0, (mod(float(cnt),30.0))/25.0, 0.5-(mod(float(cnt),30.0))/60.0, 1.0); }
        else { fragColor = vec4(0.0, 1.2-(mod(float(cnt),30.0))/25.0, (mod(float(cnt),30.0))/60.0, 1.0); }
    } else { 
        if(cnt == 100) { fragColor = vec4(0.25, 0.0625, 0.25, 1.0); }
        else if (mod(float(cnt), 30.0) < 15.0)
            { fragColor = vec4((mod(float(cnt),30.0))/25.0, 0.5-(mod(float(cnt),30.0))/60.0, 0.0, 1.0); }
        else { fragColor = vec4(1.2-(mod(float(cnt),30.0))/25.0, (mod(float(cnt),30.0))/60.0, 0.0, 1.0); }
    }
    drawSquare(vec2(-1.786511, 0.0), 0.1, 0.01);
    drawCircle(vec2(-0.1010964, 0.9562865), 0.1, 0.01);
    drawTriangle(vec2(0.2425, 0.5085), 0.1, 0.01);
    oFragColor = fragColor;
}
void drawSquare(vec2 square, float width, float girth) {
    float aw = width*pow(zoom, 5.0); float ag = girth*pow(zoom, 5.0);
    if (p.x >= (square.x-aw) && p.x <= (square.x+aw)
        && p.y <= (square.y+aw) && p.y >= (square.y-aw)
        && (p.x <= square.x-(aw-ag) || p.x >= square.x+(aw-ag)
            || p.y >= square.y+(aw-ag) || p.y <= square.y-(aw-ag)))
        { fragColor = vec4(1.0, 0.0, 0.0, 1.0); }
}
void drawCircle(vec2 circle, float radius, float girth) {
    float ar = radius*pow(zoom, 5.0); float ag = girth*pow(zoom, 5.0);
    float dist = sqrt(pow(p.x-circle.x, 2.0) + pow(p.y-circle.y, 2.0));
    if (dist <= ar && dist >= (ar-ag)) {fragColor = vec4(1.0, 0.0, 0.0, 1.0); }
}
void drawTriangle(vec2 triangle, float hypotenuse, float girth) {
    float ah = hypotenuse*pow(zoom, 5.0); float ag = girth*pow(zoom, 5.0);
    float op = ah*sin(radians(60.0)); float adj = ah*cos(radians(30.0)) ;
    float height = (sqrt(3.0)/2.0)*sqrt(pow((op+ah),2.0)+pow(adj,2.0));
    float bl = triangle.y-op-(height/adj)*(triangle.x-adj);
    float br = triangle.y-op+(height/adj)*(triangle.x+adj);
    if ((p.x >= triangle.x-adj && p.x <= triangle.x+adj) &&
        ((p.y <= triangle.y-op && p.y >= triangle.y-(op+ag)) ||
        (p.y <= p.x*(height/adj)+bl && p.y >= (p.x-ag)*(height/adj)+bl && p.x <= triangle.x) ||
        (p.y <= p.x*(-height/adj)+br && p.y >= (p.x+ag)*(-height/adj)+br && p.x >= triangle.x)))
        {fragColor = vec4(1.0, 0.0, 0.0, 1.0); }
    
}
