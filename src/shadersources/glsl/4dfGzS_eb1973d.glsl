/* Created by Goksel Goktas, 2013
 * Uses code from Inigo Quilez such as the frequency addressing and the fog()
 * function. Inspired by other Shadertoy publications. */

#define MAXIMUM_ITERATIONS 128
#define MAXIMUM_DEPTH 7.
#define EPSILON .025

float aspect_ratio = 0.;
float frequencies[2];

float grain(in float seed)
{
        return fract(sin(seed) * 423145.92642);
}

float noise(in vec3 position)
{
        return texture(iChannel1, position.xy).r;
}

float smooth_noise(in vec3 position)
{
        vec3 integer = floor(position);
        vec3 fractional = fract(position);

        fractional = fractional * fractional * (3. - 2. * fractional);

        float seed = integer.x + integer.y * 57. + 113. * integer.z;
        return mix(mix(
                        mix(grain(seed), grain(seed + 1.),
                                fractional.x),
                        mix(grain(seed + 57.), grain(seed + 58.),
                                fractional.x),
                        fractional.y),
                mix(mix(grain(seed + 113.), grain(seed + 114.),
                                fractional.x),
                        mix(grain(seed + 170.), grain(seed + 171.),
                                fractional.x),
                        fractional.y),
                    fractional.z);
}

float brownian(in vec3 position)
{
        mat3 rotation = mat3(
                0.,  .8,  .6,
                -.8,  .36, -.48,
                -.6, -.48,  .64
        );

        float result = .5 * smooth_noise(position);
        position = rotation * position * 2.02;

        result += .25 * smooth_noise(position);
        position = rotation * position * 2.03;

        result += .125 * smooth_noise(position);
        position = rotation * position * 2.01;

        result += .0625 * smooth_noise(position);
        position = rotation * position;

        return result;
}

float vignette(in vec2 st)
{
        return 1. - pow(distance(st, vec2(.5 * aspect_ratio, .5)),
                2. + .05 * (.5 + .5 * sin(iTime * 60.)));
}

vec4 background(vec2 pixel_coordinates, vec2 fragCoord)
{
        vec4 sky_top_left = vec4(.129412, .172549, .262745, 1.);
        vec4 sky_top_right = vec4(.023529, .047058, .129412, 1.);

        vec2 star_field_uv = vec2(pixel_coordinates.x + .007 * iTime,
                pixel_coordinates.y);

        vec4 color = mix(sky_top_left, sky_top_right, pixel_coordinates.x);
        color += .3 * texture(iChannel0, star_field_uv).g;
        color += .3 * texture(iChannel2, .5 + vec2(star_field_uv.x + .003 *
                iTime, star_field_uv.y)).g;

        star_field_uv.x += .01 * grain(fragCoord.y * 60. * iTime);
        color.gb += .7 * texture(iChannel0, star_field_uv).g;

        star_field_uv.x = pixel_coordinates.x + .007 * iTime - .025 *
                grain(pixel_coordinates.y * 10. * iTime);
        color.r += 1.25 * texture(iChannel0, star_field_uv).r;

        return color;
}

float query(in vec3 position)
{
        float fbm = brownian(position * .75);

        float terrain = (.3 + .75 * fbm) + position.y;
        float sphere = length(position - vec3(0., 1., 0.)) - frequencies[0];
        sphere += fbm * (1. + 2. * (frequencies[0] * frequencies[1]) - 1.);

        return min(sphere, terrain);
}

vec3 calculate_normal(in vec3 position)
{
        return normalize(
                vec3(
                        query(position + vec3(EPSILON, 0., 0.)) -
                        query(position - vec3(EPSILON, 0., 0.)),
                        query(position + vec3(0., EPSILON, 0.)) -
                        query(position - vec3(0., EPSILON, 0.)),
                        query(position + vec3(0., 0., EPSILON)) -
                        query(position - vec3(0., 0., EPSILON))
                )
        );
}

float ambient_occlusion(in vec3 position, in vec3 normal, float step_size)
{
        float result = 0.;

        for (int k = 0; k < 3; k++) {
                float i = float(k);

                result += (i * step_size -
                        query(position + normal * i * step_size)) / exp2(i);
        }

        return 1. - clamp(result, 0., 1.);
}

float subsurface_scattering(in vec3 position, in vec3 normal,
                float step_size) {

        float result = 0.;

        for (int k = 4; k > 0; k--) {
                float i = float(k);
                result += (i * step_size + query(position + normal * i *
                        step_size)) / exp2(i);
        }

        return 1. - clamp(result, 0., 1.);
}

float shadow(in vec3 position, in vec3 light_source_position, float step_size)
{
        float result = 0.;
        vec3 normal = normalize(light_source_position - position);

        for (int k = 0; k < 3; k++) {
                float i = float(k);

                result += (i * step_size -
                        query(position + normal * i * step_size)) / exp2(i);
        }

        return 1. - clamp(result, 0., 1.);
}

/* Blatantly ripped off from Inigo's example:
 * https://iquilezles.org/articles/fog
 *
 * Modified and thorougly abused for the sauciest results. */
vec4 fog(in vec4 original, in float depth, in vec3 direction,
        in vec3 sun)
{
        float fog_factor = exp(-depth * .033);
        float sun_factor = max(dot(direction, sun), 0.);

        vec4 result = mix(original, vec4(1., .63, .3, 1.),
                pow(sun_factor, 8.));

    return mix(original, result, fog_factor);
}

float intersect(in vec3 origin, in vec3 direction, out float depth,
        out float iteration_count)
{
        float samplev = MAXIMUM_DEPTH;
        depth = 0.;

        iteration_count = 0.;

        vec3 position = origin;

        for (int i = 0; i < MAXIMUM_ITERATIONS; i++) {
                position = origin + direction * depth;
                samplev = query(position);

                if (samplev < EPSILON) {
                        break;
                }

                depth += max(EPSILON, samplev) + EPSILON * .5 * (.5 + .5 *
                        grain(position.z));

                if (depth >= MAXIMUM_DEPTH) {
                        break;
                }

                ++iteration_count;
        }

        return samplev;
}

vec4 shade(in vec3 origin, in vec3 direction, in float samplev, in float depth,
        in float iteration_count, in vec2 pixel_coordinates, in vec2 fragCoord)
{
        vec3 position = origin + direction * depth;
        float daylight = 7. * sin(iTime * .3);

        vec4 color = mix(background(pixel_coordinates,fragCoord), vec4(1., .7, .6, .1),
                daylight * .1);

        vec3 light_position = vec3(0., daylight, 10.);

        color.gb += pow(iteration_count * .021, 1.75) * vec2(1.75, 1.15);

        if (samplev < EPSILON) {
                vec3 normal = calculate_normal(position);

                float lambert_factor = dot(normal,
                        normalize(light_position));
                lambert_factor = .3 + .7 *
                        clamp(lambert_factor, 0., 1.);

                float shadow_factor =
                        pow(shadow(position, light_position, .3), 2.);

                color = texture(iChannel1, position.xz) *
                        pow(ambient_occlusion(position, normal, .3),
                                7.) * shadow_factor;

                color = .15 * color + .85 * lambert_factor * color;
                color *= 1.5 * vec4(1., .88, .47, 1.);
        }

        float weight = step(MAXIMUM_DEPTH, depth);
        return mix(color, fog(color, distance(position, origin), direction,
                normalize(light_position)), weight);
}

vec4 render(in vec3 origin, in vec3 direction, in vec2 pixel_coordinates, in vec2 fragCoord)
{
        float depth = 0.;
        float iteration_count = 0.;

        float samplev = intersect(origin, direction, depth, iteration_count);

        return shade(origin, direction, samplev, depth, iteration_count,
                pixel_coordinates, fragCoord);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
        aspect_ratio = iResolution.x / iResolution.y;

        frequencies[0] = texture(iChannel3, vec2(0.01, 0.25)).x;
        frequencies[1] = texture(iChannel3, vec2(0.07, 0.25)).x;

        vec2 pixel_coordinates = fragCoord.xy / iResolution.xy;
        vec2 texel_coordinates = pixel_coordinates - .5;

        pixel_coordinates.x *= aspect_ratio;
        texel_coordinates.x *= aspect_ratio;

        vec3 ray_origin = vec3(0., 0., -5.);
        vec3 ray_direction = normalize(vec3(texel_coordinates, 1.));

        vec4 color = render(ray_origin, ray_direction, pixel_coordinates, fragCoord);
        color = clamp(color, vec4(0.), vec4(1.));

        fragColor = color *
                vignette(pixel_coordinates);
}
