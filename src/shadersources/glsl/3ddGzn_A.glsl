// ================================================ Intro ================================================


const int QN = 100;
const int QD = 50;

const float QNs = 45./float(QN);
const float QNq = 1.35/float(QN);
const float QDs = 30./float(QD);
const float QDq = .9/float(QD);


int seq_code;
ivec3 iA;
float cb(int n) {
	return float((seq_code>>n)&1);
}

vec3 lpos3;
float camz, destr, sprog;	// scene progress








vec3 map(vec3 p)
{
	float
		a=.5*iTime*cb(11),
		n0 = noise(73.*p+a),
		n1 = noise(10.*p+a+a),
		n2 = noise(2.*p+a)-.5,
		n3 = noise(.4*p+a)-.5,
		h;
	float
		wn1 = .2*n0+n1,
		wn2 = sat(10.*n2),
		wn3 = sat(10.*n3)*sat(.2*p.x*p.x-.1+.3*n2);
	float wallnoise = wn1*(.02+wn2),
        	eclipse=sat(5.*sprog-3.)*cb(7);
	vec3 d = vec3(1, 0, 0), q, t;

	dmin(d, 6.-p.y-.1*n1+.3*n2-.4*n3,
		(2.-.4*cb(12)-1.*eclipse+1.5*sat(1000.*
		(1.3-length((p-7.*lpos3).xz))*cb(4)	// enl
		))*(.12+.3*n0+.5*n1+.5*n2+.5*n3),		// ebase,
		0.); 		// common sky


	h = mix(.05*n0+.07*n1+.3*n2+n3,					// terrain
		.002*n0+.04*n1+.2*n2+.4*n3, cb(11));	// water
	if( cb(3)==0. )
		dmin(d, .8+p.y-.1*wallnoise, .01+.9*wn2, 0.);	// forrest floor
	else if( cb(2)==0. )
		dmin(d, 1.2-.6*cb(11)+p.y-h, mix(.8+h*(1.-eclipse), .01, cb(11)), 0.);	// terrain
	else
		dmin(d, .6+p.y-(wn1/3.+n2+.5+3.*sat(4.*n3-1.))*(.02+wn3), .01+.9*wn3, 0.);	// rocks



	h = sat(mix(.85*sprog, 1., cb(5))*2.*cb(6)-.5+.2*p.y);
	h*=2.*(n0-.2)*h;
	if( cb(3)==0. )
		if( cb(2)==0. )
		{
			// trees
			q=rep(abs(p)-1.6, 3.2);
			q.y = abs(p.y)-3.;
			dmin(d,
				max(p.y-3.5+wn2, vines(
					q,
					.1*wn1+.5+10./pow(1.+.95*q.y*q.y, 1.5)
				) -
					mix(.02+.08*wn1, -.1, (.55+p.y/3.)*sat(-15.-p.z))
				), .9, .0);
		}
		else {
			// city
			q=p;
			q.xz=rep(q-3., 6.).xz;

			dmin(d,
				(max(
					min(lattice(rep(q, .17))-.01, lattice(rep(q, .3))-.03),
					length(max(abs(q) - vec3(1, 3, 1), 0.))+sat(wallnoise+q.y/10.-.25)
				)-h), .7, 0.);
		}


		q=p;
		q.y-=1.5*n0*sprog*cb(15);
		if( camz<30. )
			if( cb(2)==0. )
				// circle
				if( cb(4)==0. )
					dmin(d,
						length(vec2(q.z, length(q.xy)-.5))-.025,
						2.5, -.3);
				else
					dmin(d,
						length(q)-.6,
						1.8+eclipse*(p.z+.4*(p.y+p.x)<0. ? -.8 : .5),
						.0);
			else
				// glowing triangle/square
				if( cb(4)==0. )
					for( float i=0.; i<.99; i+=1./(3.+cb(3)) ) {
						t=q;
						pR(t.xy, i);
						t.y -= .3+.22*cb(3);
						dmin(d,
							max(length(t.yz)-.025, abs(t.x)-.532),
							2.5, -.3);
					}
				else
				{
					pR(q.xz, .05);
					q.y -= .5;
					dmin(d,
						max(q.y, dot(abs(q), normalize(vec3(1, .6, 1)))-.4),
						1.4, .0);
				}


		// destruction
		vec2 r=p.xz+p.xy, s = vec2(.5, -.5), vd=50.*vcore(vcore(vcore(vcore(vec2(1), r, s.xx), r, s.xy), r, s.yx), r, s.yy);
		h = vd.y-vd.x+sat(p.y)+1.-1.5*sat((destr-length(p.xz)));
		d.yz = mix(d.yz, vec2(3., -.3), sat(1.-h));

		return d;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
	vec2 uv = fragCoord.xy / iResolution.xy;
	fragColor = vec4(0);
    
    // sequencing
	{
		int spos = 0;
		float stim = iTime*1000.*441./10./(9586.*2.);
		int istim = int(stim);
        while( SCENES[spos].x<255 && stim>=float(SCENES[spos].x) )
            stim -= float(SCENES[spos++].x);
        iA.y = seq_code = SCENES[spos].y;
        sprog = sat(stim / float(SCENES[spos].x));
	}

	camz = mix((15.+10.*cb(0)+20.*cb(1)+5.*cb(10))*(1.-.1*sprog)-10., .6, pow(sprog,6.)*cb(7));
	destr = sprog*cb(9)*(3.+5.*cb(5));



	fragColor = vec4(0);
	if( uv.y>.11 && uv.y<.89 )
	{
		float t1 = 0., t2 = 0., seed = uv.x*uv.y+uv.y+uv.x+fract(iTime);
		vec3 ro1 = vec3(0, 0, -.1),
			rd1 = normalize(vec3((2.*fragCoord.xy-iResolution.xy)/iResolution.y/1.8, 1)),
			scol=vec3(0), m1, m2, nor1, pos1, pos2;

		// camera angle
		vec2 ca=vec2(.1, .07)*cb(8), e = vec2(0, .0001);
		pR(ro1.zy, ca.y); pR(rd1.zy, ca.y);
		pR(ro1.zx, ca.x); pR(rd1.zx, ca.x);
		ro1.z-=camz;

		lpos3 = normalize(mix(vec3(.5, 1, 0), vec3(0, -1, 0), sat(destr)));

		t1 = .2*fract(seed);

		for( int i = 0; i < QN; i++ )
		{
			pos1 = ro1+rd1*t1;
			m1 = map(pos1);
			t1+=QNs*m1.x;

			if( m1.x<.005 )
			{
				if( m1.z<0. )
					scol+= vec3(1.+m1.z, 1., 1.-m1.z)*step(1., m1.y)*float(QN-i);
				break;
			}
			pos2=pos1+mix(lpos3, hashHs(lpos3, seed), .04)*t2;
			m2 = map(pos2);
			t2+=m2.x;

			scol +=
				max(0., m1.z) +
				vec3(1.+m1.z, 1., 1.-m1.z)*max(0., m1.y-1.) +
				(.5+5.*m1.x*noise(7.*pos1+vec3(iTime)))*max(0., m2.y-1.)*(1.-cb(12));
		}
		scol *= QNq;

		nor1 = normalize(m1.x-vec3(map(pos1 - e.yxx).x, map(pos1 - e.xyx).x, map(pos1 - e.xxy).x));

		t2=1.;
		for( int i = 0; i < QD; i++ )
		{
			pos2 = pos1 + mix(reflect(rd1, nor1), hashHs(nor1, seed), sat(m1.y))*t2;
			m2 = map(pos2);
			t2+=QDs*m2.x;

			scol += vec3(1.+m2.z, 1., 1.-m2.z)*max(0., m2.y-1.)*QDq;

		}
		scol=clamp(scol, 0., 1.)
			*sat(cb(14)+15.*sprog)
			*sat(cb(13)+5.-5.*sprog)
			-float(iA.y==128)
			;

		fragColor = mix(scol.xyzz, texture(iChannel0, uv), pow(.0001, iTimeDelta));
	}
}
