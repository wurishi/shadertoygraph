int cmlookup(int c, int y) {
	int val = c * 8 + 7 - y;
	if(val<168){if(val<84){if(val<42){if(val<21){if(val<10){if(val<5){if(val<2){if(val<1){return 198;}else{return 230;}}else{if(val<3){return 246;}else{if(val<4){return 222;}else{return 206;}}}}else{if(val<7){if(val<6){return 198;}else{return 198;}}else{if(val<8){return 0;}else{if(val<9){return 0;}else{return 0;}}}}}else{if(val<15){if(val<12){if(val<11){return 124;}else{return 198;}}else{if(val<13){return 198;}else{if(val<14){return 198;}else{return 124;}}}}else{if(val<18){if(val<16){return 0;}else{if(val<17){return 224;}else{return 96;}}}else{if(val<19){return 124;}else{if(val<20){return 102;}else{return 102;}}}}}}else{if(val<31){if(val<26){if(val<23){if(val<22){return 102;}else{return 220;}}else{if(val<24){return 0;}else{if(val<25){return 28;}else{return 12;}}}}else{if(val<28){if(val<27){return 124;}else{return 204;}}else{if(val<29){return 204;}else{if(val<30){return 204;}else{return 118;}}}}}else{if(val<36){if(val<33){if(val<32){return 0;}else{return 0;}}else{if(val<34){return 0;}else{if(val<35){return 198;}else{return 198;}}}}else{if(val<39){if(val<37){return 198;}else{if(val<38){return 126;}else{return 6;}}}else{if(val<40){return 252;}else{if(val<41){return 0;}else{return 0;}}}}}}}else{if(val<63){if(val<52){if(val<47){if(val<44){if(val<43){return 0;}else{return 0;}}else{if(val<45){return 0;}else{if(val<46){return 0;}else{return 0;}}}}else{if(val<49){if(val<48){return 0;}else{return 0;}}else{if(val<50){return 0;}else{if(val<51){return 124;}else{return 198;}}}}}else{if(val<57){if(val<54){if(val<53){return 254;}else{return 192;}}else{if(val<55){return 124;}else{if(val<56){return 0;}else{return 0;}}}}else{if(val<60){if(val<58){return 0;}else{if(val<59){return 198;}else{return 108;}}}else{if(val<61){return 56;}else{if(val<62){return 108;}else{return 198;}}}}}}else{if(val<73){if(val<68){if(val<65){if(val<64){return 0;}else{return 0;}}else{if(val<66){return 0;}else{if(val<67){return 220;}else{return 102;}}}}else{if(val<70){if(val<69){return 102;}else{return 124;}}else{if(val<71){return 96;}else{if(val<72){return 240;}else{return 0;}}}}}else{if(val<78){if(val<75){if(val<74){return 0;}else{return 124;}}else{if(val<76){return 198;}else{if(val<77){return 192;}else{return 198;}}}}else{if(val<81){if(val<79){return 124;}else{if(val<80){return 0;}else{return 48;}}}else{if(val<82){return 48;}else{if(val<83){return 252;}else{return 48;}}}}}}}}else{if(val<126){if(val<105){if(val<94){if(val<89){if(val<86){if(val<85){return 48;}else{return 54;}}else{if(val<87){return 28;}else{if(val<88){return 0;}else{return 0;}}}}else{if(val<91){if(val<90){return 0;}else{return 126;}}else{if(val<92){return 192;}else{if(val<93){return 124;}else{return 6;}}}}}else{if(val<99){if(val<96){if(val<95){return 252;}else{return 0;}}else{if(val<97){return 224;}else{if(val<98){return 96;}else{return 108;}}}}else{if(val<102){if(val<100){return 118;}else{if(val<101){return 102;}else{return 102;}}}else{if(val<103){return 230;}else{if(val<104){return 0;}else{return 60;}}}}}}else{if(val<115){if(val<110){if(val<107){if(val<106){return 102;}else{return 192;}}else{if(val<108){return 192;}else{if(val<109){return 206;}else{return 102;}}}}else{if(val<112){if(val<111){return 58;}else{return 0;}}else{if(val<113){return 240;}else{if(val<114){return 96;}else{return 96;}}}}}else{if(val<120){if(val<117){if(val<116){return 96;}else{return 98;}}else{if(val<118){return 102;}else{if(val<119){return 254;}else{return 0;}}}}else{if(val<123){if(val<121){return 60;}else{if(val<122){return 102;}else{return 48;}}}else{if(val<124){return 24;}else{if(val<125){return 12;}else{return 102;}}}}}}}else{if(val<147){if(val<136){if(val<131){if(val<128){if(val<127){return 60;}else{return 0;}}else{if(val<129){return 24;}else{if(val<130){return 0;}else{return 56;}}}}else{if(val<133){if(val<132){return 24;}else{return 24;}}else{if(val<134){return 24;}else{if(val<135){return 60;}else{return 0;}}}}}else{if(val<141){if(val<138){if(val<137){return 0;}else{return 0;}}else{if(val<139){return 220;}else{if(val<140){return 102;}else{return 102;}}}}else{if(val<144){if(val<142){return 102;}else{if(val<143){return 102;}else{return 0;}}}else{if(val<145){return 0;}else{if(val<146){return 0;}else{return 220;}}}}}}else{if(val<157){if(val<152){if(val<149){if(val<148){return 118;}else{return 96;}}else{if(val<150){return 96;}else{if(val<151){return 240;}else{return 0;}}}}else{if(val<154){if(val<153){return 56;}else{return 24;}}else{if(val<155){return 24;}else{if(val<156){return 24;}else{return 24;}}}}}else{if(val<162){if(val<159){if(val<158){return 24;}else{return 60;}}else{if(val<160){return 0;}else{if(val<161){return 24;}else{return 60;}}}}else{if(val<165){if(val<163){return 60;}else{if(val<164){return 24;}else{return 24;}}}else{if(val<166){return 0;}else{if(val<167){return 24;}else{return 0;}}}}}}}}}else{if(val<252){if(val<210){if(val<189){if(val<178){if(val<173){if(val<170){if(val<169){return 60;}else{return 24;}}else{if(val<171){return 24;}else{if(val<172){return 24;}else{return 24;}}}}else{if(val<175){if(val<174){return 24;}else{return 60;}}else{if(val<176){return 0;}else{if(val<177){return 198;}else{return 198;}}}}}else{if(val<183){if(val<180){if(val<179){return 198;}else{return 214;}}else{if(val<181){return 214;}else{if(val<182){return 254;}else{return 108;}}}}else{if(val<186){if(val<184){return 0;}else{if(val<185){return 0;}else{return 0;}}}else{if(val<187){return 120;}else{if(val<188){return 12;}else{return 124;}}}}}}else{if(val<199){if(val<194){if(val<191){if(val<190){return 204;}else{return 118;}}else{if(val<192){return 0;}else{if(val<193){return 126;}else{return 126;}}}}else{if(val<196){if(val<195){return 90;}else{return 24;}}else{if(val<197){return 24;}else{if(val<198){return 24;}else{return 60;}}}}}else{if(val<204){if(val<201){if(val<200){return 0;}else{return 252;}}else{if(val<202){return 102;}else{if(val<203){return 102;}else{return 124;}}}}else{if(val<207){if(val<205){return 108;}else{if(val<206){return 102;}else{return 230;}}}else{if(val<208){return 0;}else{if(val<209){return 0;}else{return 0;}}}}}}}else{if(val<231){if(val<220){if(val<215){if(val<212){if(val<211){return 198;}else{return 198;}}else{if(val<213){return 198;}else{if(val<214){return 108;}else{return 56;}}}}else{if(val<217){if(val<216){return 0;}else{return 0;}}else{if(val<218){return 0;}else{if(val<219){return 0;}else{return 126;}}}}}else{if(val<225){if(val<222){if(val<221){return 0;}else{return 0;}}else{if(val<223){return 0;}else{if(val<224){return 0;}else{return 252;}}}}else{if(val<228){if(val<226){return 102;}else{if(val<227){return 102;}else{return 124;}}}else{if(val<229){return 96;}else{if(val<230){return 96;}else{return 240;}}}}}}else{if(val<241){if(val<236){if(val<233){if(val<232){return 0;}else{return 0;}}else{if(val<234){return 0;}else{if(val<235){return 236;}else{return 254;}}}}else{if(val<238){if(val<237){return 214;}else{return 214;}}else{if(val<239){return 214;}else{if(val<240){return 0;}else{return 0;}}}}}else{if(val<246){if(val<243){if(val<242){return 0;}else{return 0;}}else{if(val<244){return 0;}else{if(val<245){return 0;}else{return 24;}}}}else{if(val<249){if(val<247){return 24;}else{if(val<248){return 0;}else{return 60;}}}else{if(val<250){return 102;}else{if(val<251){return 192;}else{return 192;}}}}}}}}else{if(val<294){if(val<273){if(val<262){if(val<257){if(val<254){if(val<253){return 192;}else{return 102;}}else{if(val<255){return 60;}else{if(val<256){return 0;}else{return 102;}}}}else{if(val<259){if(val<258){return 102;}else{return 36;}}else{if(val<260){return 0;}else{if(val<261){return 0;}else{return 0;}}}}}else{if(val<267){if(val<264){if(val<263){return 0;}else{return 0;}}else{if(val<265){return 0;}else{if(val<266){return 0;}else{return 118;}}}}else{if(val<270){if(val<268){return 204;}else{if(val<269){return 204;}else{return 124;}}}else{if(val<271){return 12;}else{if(val<272){return 248;}else{return 248;}}}}}}else{if(val<283){if(val<278){if(val<275){if(val<274){return 108;}else{return 102;}}else{if(val<276){return 102;}else{if(val<277){return 102;}else{return 108;}}}}else{if(val<280){if(val<279){return 248;}else{return 0;}}else{if(val<281){return 224;}else{if(val<282){return 96;}else{return 102;}}}}}else{if(val<288){if(val<285){if(val<284){return 108;}else{return 120;}}else{if(val<286){return 108;}else{if(val<287){return 230;}else{return 0;}}}}else{if(val<291){if(val<289){return 0;}else{if(val<290){return 0;}else{return 198;}}}else{if(val<292){return 214;}else{if(val<293){return 214;}else{return 254;}}}}}}}else{if(val<315){if(val<304){if(val<299){if(val<296){if(val<295){return 108;}else{return 0;}}else{if(val<297){return 0;}else{if(val<298){return 0;}else{return 0;}}}}else{if(val<301){if(val<300){return 0;}else{return 0;}}else{if(val<302){return 24;}else{if(val<303){return 24;}else{return 48;}}}}}else{if(val<309){if(val<306){if(val<305){return 60;}else{return 102;}}else{if(val<307){return 96;}else{if(val<308){return 248;}else{return 96;}}}}else{if(val<312){if(val<310){return 96;}else{if(val<311){return 240;}else{return 0;}}}else{if(val<313){return 0;}else{if(val<314){return 0;}else{return 204;}}}}}}else{if(val<325){if(val<320){if(val<317){if(val<316){return 204;}else{return 204;}}else{if(val<318){return 204;}else{if(val<319){return 118;}else{return 0;}}}}else{if(val<322){if(val<321){return 198;}else{return 198;}}else{if(val<323){return 198;}else{if(val<324){return 198;}else{return 198;}}}}}else{if(val<330){if(val<327){if(val<326){return 108;}else{return 56;}}else{if(val<328){return 0;}else{if(val<329){return 254;}else{return 98;}}}}else{if(val<333){if(val<331){return 104;}else{if(val<332){return 120;}else{return 104;}}}else{if(val<334){return 98;}else{if(val<335){return 254;}else{return 0;}}}}}}}}}

}

int line0Lookup(int val) {
	if(val<96){if(val<48){if(val<24){if(val<12){if(val<6){if(val<3){if(val<1){return 0;}else{if(val<2){return 1;}else{return 2;}}}else{if(val<4){return 1;}else{if(val<5){return 3;}else{return 4;}}}}else{if(val<9){if(val<7){return 5;}else{if(val<8){return 6;}else{return 7;}}}else{if(val<10){return 8;}else{if(val<11){return 6;}else{return 9;}}}}}else{if(val<18){if(val<15){if(val<13){return 10;}else{if(val<14){return 11;}else{return 5;}}}else{if(val<16){return 10;}else{if(val<17){return 12;}else{return 6;}}}}else{if(val<21){if(val<19){return 5;}else{if(val<20){return 13;}else{return 14;}}}else{if(val<22){return 15;}else{if(val<23){return 14;}else{return 5;}}}}}}else{if(val<36){if(val<30){if(val<27){if(val<25){return 11;}else{if(val<26){return 16;}else{return 17;}}}else{if(val<28){return 6;}else{if(val<29){return 11;}else{return 9;}}}}else{if(val<33){if(val<31){return 18;}else{if(val<32){return 1;}else{return 19;}}}else{if(val<34){return 19;}else{if(val<35){return 6;}else{return 18;}}}}}else{if(val<42){if(val<39){if(val<37){return 20;}else{if(val<38){return 5;}else{return 5;}}}else{if(val<40){return 5;}else{if(val<41){return 5;}else{return 21;}}}}else{if(val<45){if(val<43){return 5;}else{if(val<44){return 22;}else{return 23;}}}else{if(val<46){return 17;}else{if(val<47){return 10;}else{return 5;}}}}}}}else{if(val<72){if(val<60){if(val<54){if(val<51){if(val<49){return 24;}else{if(val<50){return 1;}else{return 5;}}}else{if(val<52){return 25;}else{if(val<53){return 6;}else{return 26;}}}}else{if(val<57){if(val<55){return 6;}else{if(val<56){return 18;}else{return 10;}}}else{if(val<58){return 5;}else{if(val<59){return 27;}else{return 5;}}}}}else{if(val<66){if(val<63){if(val<61){return 28;}else{if(val<62){return 18;}else{return 16;}}}else{if(val<64){return 29;}else{if(val<65){return 16;}else{return 10;}}}}else{if(val<69){if(val<67){return 16;}else{if(val<68){return 26;}else{return 6;}}}else{if(val<70){return 30;}else{if(val<71){return 5;}else{return 31;}}}}}}else{if(val<84){if(val<78){if(val<75){if(val<73){return 1;}else{if(val<74){return 3;}else{return 6;}}}else{if(val<76){return 5;}else{if(val<77){return 23;}else{return 17;}}}}else{if(val<81){if(val<79){return 3;}else{if(val<80){return 5;}else{return 32;}}}else{if(val<82){return 3;}else{if(val<83){return 6;}else{return 11;}}}}}else{if(val<90){if(val<87){if(val<85){return 16;}else{if(val<86){return 33;}else{return 17;}}}else{if(val<88){return 32;}else{if(val<89){return 5;}else{return 2;}}}}else{if(val<93){if(val<91){return 4;}else{if(val<92){return 5;}else{return 34;}}}else{if(val<94){return 23;}else{if(val<95){return 6;}else{return 35;}}}}}}}}else{if(val<144){if(val<120){if(val<108){if(val<102){if(val<99){if(val<97){return 6;}else{if(val<98){return 17;}else{return 30;}}}else{if(val<100){return 5;}else{if(val<101){return 5;}else{return 5;}}}}else{if(val<105){if(val<103){return 5;}else{if(val<104){return 5;}else{return 5;}}}else{if(val<106){return 5;}else{if(val<107){return 5;}else{return 5;}}}}}else{if(val<114){if(val<111){if(val<109){return 0;}else{if(val<110){return 6;}else{return 36;}}}else{if(val<112){return 5;}else{if(val<113){return 9;}else{return 1;}}}}else{if(val<117){if(val<115){return 29;}else{if(val<116){return 8;}else{return 1;}}}else{if(val<118){return 37;}else{if(val<119){return 5;}else{return 11;}}}}}}else{if(val<132){if(val<126){if(val<123){if(val<121){return 23;}else{if(val<122){return 29;}else{return 6;}}}else{if(val<124){return 5;}else{if(val<125){return 1;}else{return 19;}}}}else{if(val<129){if(val<127){return 3;}else{if(val<128){return 27;}else{return 11;}}}else{if(val<130){return 9;}else{if(val<131){return 12;}else{return 1;}}}}}else{if(val<138){if(val<135){if(val<133){return 1;}else{if(val<134){return 19;}else{return 5;}}}else{if(val<136){return 38;}else{if(val<137){return 39;}else{return 17;}}}}else{if(val<141){if(val<139){return 30;}else{if(val<140){return 5;}else{return 5;}}}else{if(val<142){return 5;}else{if(val<143){return 5;}else{return 5;}}}}}}}else{if(val<168){if(val<156){if(val<150){if(val<147){if(val<145){return 5;}else{if(val<146){return 5;}else{return 5;}}}else{if(val<148){return 5;}else{if(val<149){return 13;}else{return 18;}}}}else{if(val<153){if(val<151){return 6;}else{if(val<152){return 6;}else{return 10;}}}else{if(val<154){return 11;}else{if(val<155){return 5;}else{return 10;}}}}}else{if(val<162){if(val<159){if(val<157){return 1;}else{if(val<158){return 5;}else{return 34;}}}else{if(val<160){return 23;}else{if(val<161){return 18;}else{return 35;}}}}else{if(val<165){if(val<163){return 19;}else{if(val<164){return 16;}else{return 10;}}}else{if(val<166){return 6;}else{if(val<167){return 37;}else{return 5;}}}}}}else{if(val<180){if(val<174){if(val<171){if(val<169){return 15;}else{if(val<170){return 40;}else{return 23;}}}else{if(val<172){return 10;}else{if(val<173){return 13;}else{return 37;}}}}else{if(val<177){if(val<175){return 5;}else{if(val<176){return 41;}else{return 7;}}}else{if(val<178){return 9;}else{if(val<179){return 6;}else{return 11;}}}}}else{if(val<186){if(val<183){if(val<181){return 11;}else{if(val<182){return 37;}else{return 5;}}}else{if(val<184){return 31;}else{if(val<185){return 1;}else{return 17;}}}}else{if(val<189){if(val<187){return 11;}else{if(val<188){return 8;}else{return 16;}}}else{if(val<191){if(val<190){return 18;}else{return 23;}}else{if(val<192){return 9;}else{return 4;}}}}}}}}

}

bool checkPixel(int c, int x, int y) {
	if(x < 0 || y < 0 || x > 7 || y > 7)
		return false;
	int pix = cmlookup(c, y);
	return mod(floor(float(pix) / pow(2.0, float(7 - x))), 2.0) == 1.0;
}

float charPixel(int c, int x, int y, vec2 dist) {
	if(checkPixel(c, x, y))
		return 1.0;
	
	return 0.0;
}

// Animated nyan cat lookup stolen shamelessly from https://www.shadertoy.com/view/4slGWH

vec4 getNyanCatColor( vec2 p )
{
	p = clamp(p,0.0,1.0);
	p.x = p.x*40.0/256.0;
	p.y = 0.5 + 1.2*(0.5-p.y);
	p = clamp(p,0.0,1.0);
	float fr = floor( mod( 20.0*iTime, 6.0 ) );
	p.x += fr*40.0/256.0;
	return texture( iChannel0, p );
}

vec4 subback(vec2 p) {
	float angle = iTime + length(p);
	p = vec2(p.x * cos(angle) - p.y * sin(angle), p.y * cos(angle) + p.x * sin(angle));
	p *= sin(iTime) * 5.0;
	p = floor(mod(p, 2.0));
	if(p == vec2(1.0, 0.0) || p == vec2(0.0, 1.0))
		return vec4(0.0, 0.0, 0.0, 1.0);
	else
		return vec4(1.0, 1.0, 1.0, 1.0);
}

vec4 background(vec2 p) {
	float angle = cos(iTime)*3.1416;
	p -= 0.5;
	vec2 op = p;
	p = vec2(p.x * cos(angle) - p.y * sin(angle), p.y * cos(angle) + p.x * sin(angle));
	p /= 1.3;
	p *= (sin(iTime) + 1.0) / 2.0 * 2.2 + 0.8;
	p += 0.5;
	p = 1.0 - p;
	vec4 c = getNyanCatColor(p);
	if(iTime > 25.0 && c.g == 1.0)
		return subback(op);
	return c;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 p = fragCoord.xy / iResolution.xy - 0.5;
	if(iResolution.x > iResolution.y)
		p.x /= iResolution.y / iResolution.x;
	else
		p.y /= iResolution.x / iResolution.y;
	p += 0.5;
	vec2 op = p;
	
	p.x *= 10.0;
	p.x += iTime * 4.0 - 2.0;
	p.y *= 8.0;
	p.y -= (sin(iTime) + 1.0) / 2.0 * 5.0 + 1.0;
	
	int c = int(floor(p.x));
	int px = int(floor(mod(p.x, 1.0) * 8.0));
	p.y += sin(iTime + float(c) / 1.5);
	int py = int(floor(p.y * 8.0));
	
	if(c < 193)
		c = line0Lookup(c);
	else
		c = -1;
	
	float x;
	if(p.x < 0.0 || c == -1)
		x = 0.0;
	else
		x = charPixel(c, px, py, mod(p * 8.0, 1.0));
	if(x == 1.0 || iTime < 8.0) {
		fragColor = vec4(0.0, x, 0.0, 1.0);
	} else
		fragColor = background(op) * clamp(iTime - 8.0, 0.0, 1.0);
	fragColor *= 1.0 - clamp((iTime - 50.0) / 3.0, 0.0, 1.0);
}






