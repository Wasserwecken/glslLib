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





    vec2 tile_id;
    vec2 tile_uv = uv_tilling(uv, tile_id, vec2(10.0));

    float tile_rotation = 0.5 * (random(tile_id + seed++) * 2.0 - 1.0);
    tile_uv = uv_rotate(tile_uv, vec2(0.5), tile_rotation);

    float tile_shape = shape_rectangle(tile_uv, vec2(0.5), vec2(0.925), vec2(0.05));
    tile_shape = easing_circular_out(tile_shape);

    vec2 tile_surface_uv = uv * 4.0;
    float tile_surface = noise_perlin(tile_surface_uv, tile_id + seed++);

    vec2 tilt_direction = normalize(random_vec2(tile_id + seed++) - 0.5);
    float tile_tilt = shape_gradient_direction(tile_uv, vec2(0.5), tilt_direction);
    height = clamp((tile_shape - tile_surface * 0.2 - tile_tilt * 0.2), 0.0, 1.0);


    vec2 chalk_uv = uv * 0.75;
    float chalk = noise_perlin(chalk_uv, seed++, 6, 0.5, 2.0);
    chalk = easing_power_in(chalk, 3.0);
    roughness = clamp(1.0 - (tile_shape) + chalk, 0.0, 1.0);

    albedo = mix(vec3(0.9), vec3(0.8), random(tile_id + seed++));
    albedo = mix(albedo, vec3(0.0, 0.0, 0.9), step(0.95, random(tile_id + seed++)));

    float tile_mask = value_linear_step(tile_shape, tile_surface * 0.5, 0.25);
    albedo = mix(vec3(0.2), albedo, tile_mask);






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