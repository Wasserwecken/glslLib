#include "/collection/constants.glsl"
#include "/collection/helper.glsl"
#include "/collection/easing.glsl"
#include "/collection/shapes.glsl"
#include "/collection/noise.glsl"
#include "/collection/uv.glsl"
#include "/collection/color.glsl"


void main() {
    vec2 uv = gl_FragCoord.xy / iResolution.y;
    uv *= 1.0;

    vec2 seed = vec2(1.0 + floor(iTime / 5.0));
    vec3 albedo;
    float height;
    float roughness;



    vec3 cell_id;
    vec3 cell_center;
    float center_distance;
    vec3 gravel_seed = vec3(seed++, 1.0);
    vec3 gravel_uv = vec3(uv * 5.0, 0.2);
    height = noise_voronoi_edge(gravel_uv, gravel_seed++, cell_id, cell_center, center_distance, vec3(1.0));
    height = easing_power_out(height, 1.0 + 2.0 * random(cell_center + gravel_seed++));

    vec2 cell_seed = random_vec2(cell_id);
    roughness = value_remap_01(random(cell_seed + seed++), 0.5, 1.0);

    float pebble_turbulence = value_remap_01(random(cell_seed + seed++), 1.0, 5.0);
    vec3 pebble_color_brightness = vec3(1.0) * value_remap_01(random(cell_seed + seed++), 0.3, 1.0);
    vec3 pebble_color_1 = color_hex(0x809085);
    vec3 pebble_color_2 = color_hex(0xFFD0AC);
    vec3 pebble_color = mix(pebble_color_1, pebble_color_2, random(cell_seed + seed++));
    albedo = mix(pebble_color_brightness, pebble_color, random(cell_seed + seed++));




    vec3 color;
    uv.x -= uv.y * 0.5;
    if (uv.x < 1.0)
        color = vec3(height);
    if (uv.x < 0.5)
        color = vec3(roughness);
    if (uv.x < 0.0)
        color = albedo;
        
	gl_FragColor = vec4(color, 1.0);
}