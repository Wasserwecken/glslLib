#include "./lib/constants.glsl"
#include "./lib/helper.glsl"
#include "./lib/easing.glsl"
#include "./lib/shapes.glsl"
#include "./lib/noise.glsl"
#include "./lib/uv.glsl"
#include "./lib/color.glsl"


void main() {
    vec2 uv = gl_FragCoord.xy / iResolution.y;
    uv *= 1.0;

    vec2 seed = vec2(1.0 + floor(iTime / 5.0)) * 0.0;
    vec3 albedo;
    float height;
    float roughness;



    vec2 tile_id;
    vec2 tile_uv = uv_tilling(uv, tile_id, vec2(10.0));


    float tile = shape_rectangle(tile_uv, vec2(0.5), vec2(0.45), vec2(0.1));
    tile = easing_power_inout(tile, 2.0);

    albedo = vec3(tile);
    height = tile;

    float rand = random(tile_id);
    albedo *= mix(albedo, vec3(.0, .0, .9), step(0.7, rand));

    float ele = noise_value(tile_uv * 0.3, tile_id, 1.5);
    height -= ele * 0.5;

    float chalk = noise_perlin(uv, seed, 5, 0.5, 2.0);
    chalk = easing_power_inout(chalk, 4.0);
    chalk = easing_power_in(chalk, 3.0);


    vec3 color = vec3(1.0);
    color = vec3(1.0) * roughness;
    color = vec3(1.0) * albedo;
    color = vec3(1.0) * height;
    color = vec3(1.0) * chalk;
        
	gl_FragColor = vec4(color, 1.0);
}