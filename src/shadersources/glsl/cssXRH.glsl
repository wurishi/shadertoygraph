const float n_tau = 6.283185;
float f_n_dist_circle_segment(
    //vec2 o_p_origin, 
    float n_radians_nor, 
    float n_radians_offset_nor, 
    float n_radius_nor, 
    vec2 o_pix_cor_nor
){
    float n_rad = n_radians_offset_nor * n_tau;
    o_pix_cor_nor = vec2(
            cos(n_rad)*o_pix_cor_nor.x + sin(n_rad)*o_pix_cor_nor.y,
            -sin(n_rad)*o_pix_cor_nor.x + cos(n_rad)*o_pix_cor_nor.y
    );
        
    vec2 o_p_origin = vec2(0.0); // was once used as a param, but translation can be applied by passing f(...,o_pix_cor_nor+translation)
    float n_dist_origin = length(o_p_origin - o_pix_cor_nor);
    vec2 o_delta = o_p_origin - o_pix_cor_nor;
    float n_angle_origin = atan(o_delta.x , o_delta.y)+(n_tau/2.0);
    float n_angle_origin_nor = n_angle_origin / n_tau;
  
    float n_dist_shortest = 1.0;
    
    vec2 o_p_center = o_p_origin;
    float n_dist_origin_max = min(n_radius_nor, n_dist_origin);
    vec2 o_p1 = vec2(
            sin(n_tau)*n_dist_origin_max,
            cos(n_tau)*n_dist_origin_max
    ) + o_p_origin;
    vec2 o_p2 = vec2(
            sin(n_tau+ n_tau * n_radians_nor)*n_dist_origin_max,
            cos(n_tau+ n_tau * n_radians_nor)*n_dist_origin_max
    ) + o_p_origin;
    float n_freq = min(n_angle_origin_nor*n_tau, n_radians_nor*n_tau);
    
    vec2 o_p_on_circumfence = vec2(
            sin(n_tau+n_freq)*n_radius_nor,
            cos(n_tau+n_freq)*n_radius_nor
    ) + o_p_origin;
    
    float n_dist1 = length(o_p1-o_pix_cor_nor);
    float n_dist2 = length(o_p2-o_pix_cor_nor);
    float n_dist_on_circumfence = length(o_p_on_circumfence-o_pix_cor_nor);
    
    float n_dist = min(n_dist1, n_dist2);
    n_dist = min(n_dist, n_dist_on_circumfence);

    // o_p1 = vec2(
    //         sin(n_tau * n_side_nor)*n_radius,
    //         cos(n_tau * n_side_nor)*n_radius
    // );
    // o_p2 = vec2(
    //         sin(n_tau * (n_side_nor+(1.0/n_sides)))*n_radius,
    //         cos(n_tau * (n_side_nor+(1.0/n_sides)))*n_radius
    // );
    // vec2 o_delta2 = o_p2-o_p1;
    // float n_m = o_delta2.y / o_delta2.x;
    // float n_q = -(n_m*o_p1.x) + o_p1.y;
    // float n_x = o_pix_cor_nor.x;
    // float n_y = n_m * n_x + n_q; 
    // float n_dist4 = abs(o_pix_cor_nor.y-n_y);
    // n_dist = min(n_dist, n_dist4);
    
    return n_dist;

}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 o_pix_cor_nor = (fragCoord.xy - iResolution.xy* 0.5) / iResolution.y;
    vec2 o_mou_cor_nor = (iMouse.xy - iResolution.xy* 0.5) / iResolution.y;
    
    float n_sides = 54.0*o_mou_cor_nor.x;
    vec2 o_delta = o_pix_cor_nor - 0.0;
    
    
    float n_angle_norm = atan(o_delta.x , o_delta.y)+(n_tau/2.0);
    float n_angle_origin_nor = n_angle_norm / n_tau;
    
    float n_side = floor(n_angle_origin_nor / (1.0/n_sides));
    
       
    float n_d2 = f_n_dist_circle_segment(
        0.2, //float n_radians_nor, 
        0.0, //float n_radians_offset_nor, 
        0.4, 
        o_pix_cor_nor
    );
    float n_d3 = f_n_dist_circle_segment(
        0.2, //float n_radians_nor, 
        0.2, //float n_radians_offset_nor, 
        0.4, 
        o_pix_cor_nor
    );
    float n_d4 = f_n_dist_circle_segment(
        0.2, //float n_radians_nor, 
        0.4, //float n_radians_offset_nor, 
        0.4, 
        o_pix_cor_nor
    );
    float n_d5 = f_n_dist_circle_segment(
        0.2, //float n_radians_nor, 
        0.6, //float n_radians_offset_nor, 
        0.4, 
        o_pix_cor_nor
    );
    float n_d6 = f_n_dist_circle_segment(
        0.2, //float n_radians_nor, 
        0.8, //float n_radians_offset_nor, 
        0.4, 
        o_pix_cor_nor
    );
    float n_dist = min(n_d2,n_d3);
    n_dist = min(n_dist,n_d4);
    n_dist = min(n_dist,n_d5);
    n_dist = min(n_dist,n_d6);
    fragColor = vec4(sqrt((n_dist)));
    //fragColor *= vec4(n_side/n_sides);
    float n_d = f_n_dist_circle_segment(
        (1./n_sides), //float n_radians_nor, 
        (1./n_sides)*(n_sides-n_side)+(0.5), //float n_radians_offset_nor, 
        0.4, 
        o_pix_cor_nor
    );
    fragColor = vec4(sqrt(n_d));
    
    //fragColor = vec4(sqrt((n_d)));
    
}