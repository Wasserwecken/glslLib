#include "/collection/constants.glsl"
#include "/collection/helper.glsl"
#include "/collection/easing.glsl"
#include "/collection/shapes.glsl"
#include "/collection/noise.glsl"
#include "/collection/uv.glsl"
#include "/collection/color.glsl"

void complex_granit(
    vec2 uv,
    vec2 seed,
    out vec3 albedo,
    float quartz_strength,
    vec3 color_base,
    vec3 color_tint,
    float turbulence_visibility)
{
    uv * 0.5;

    // GRAIN
    vec2 dist_id;
    vec2 dist_center;
    vec2 grain_id;
    vec2 grain_center;
    vec2 grain_uv = uv * 7.0;

    noise_voronoi(grain_uv, seed++, dist_id, dist_center, vec2(1.0));
    grain_uv = uv_distort_twirl(grain_uv, random(dist_id), vec2(0.5), 0.5);

    noise_voronoi(grain_uv, seed++, grain_id, grain_center, vec2(1.0));
    float grain = random(grain_id);
    grain = value_posterize(grain, 12.0);
    grain = easing_power_out(grain, quartz_strength);
    grain += (random(grain_id++) * 2.0 - 1.0) * 0.05;


    // GRAIN COLOR
    float colored_grains = grain * 2.0 - 1.0;
    colored_grains = 1.0 - abs(colored_grains);
    vec3 color_grain;
    color_grain = vec3(color_base * grain);
    color_grain = mix(color_grain, color_tint * 0.5, colored_grains);

    // COLOR TURBULENCE
    int turb_iterations = 4;
    float turb_strength = 0.1;
    vec2 turb_uv = uv * 0.1;

    vec2 turb_noise = noise_perlin_vec2(turb_uv * 0.5, seed++);
    turb_uv += turb_noise * turb_strength;

    turb_noise = noise_perlin_vec2(turb_uv * 2.0, seed++, turb_iterations, 0.5, 2.0);
    turb_noise = noise_vallies(turb_noise);
    turb_uv += turb_noise * turb_strength;

    float turb_gradient = noise_perlin(turb_uv, seed++, turb_iterations, 0.5, 2.0);
    turb_gradient = easing_power_inout(turb_gradient, 4.0);

    vec3 turb_color1 = color_base;
    vec3 turb_color2 = color_tint;
    vec3 turb_color3 = turb_color2 * 0.2;
    
    vec3 color_turbulence;
    color_turbulence = mix(turb_color1, turb_color2, turb_gradient);
    color_turbulence = mix(color_turbulence, turb_color3, turb_noise.x);
    color_turbulence = mix(color_turbulence, turb_color3, length(turb_noise));
    color_turbulence = mix(vec3(1.0), color_turbulence, turbulence_visibility);

    albedo = color_grain * color_turbulence;
}


void main() {
    vec2 uv = gl_FragCoord.xy / iResolution.y;
    uv *= 1.0;

    vec2 seed = vec2(1.0 + floor(iTime / 5.0));
    vec3 albedo;

    vec3 base = color_256(255, 253, 250);
    vec3 tint = color_256(212, 180, 121);
    complex_granit(uv * 3.0, seed, albedo, 7.0, base, tint, 1.0);

	gl_FragColor = vec4(albedo, 1.0);
}