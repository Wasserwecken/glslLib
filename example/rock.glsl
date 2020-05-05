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




    height = noise_perlin(uv, seed++, 6, 0.5, 2.0);
    height = easing_power_in(height, 2.0);
    height = easing_power_inout(height, 2.0);
    height *= 2.0;

    vec3 colorA = color_hex(0xB0A398);
    vec3 colorB = color_hex(0x778294);
    float foo = noise_perlin(uv * 1.0, seed++, 5, 0.5, 2.0);
    foo = easing_power_inout(foo, 3.0);
    albedo = mix(colorA, colorB, foo);

    float flechten = noise_perlin(uv, seed++, 2, 0.5, 2.0);
    flechten = easing_power_inout(flechten, 3.0);
    float flechten_mask = noise_perlin(uv, seed++);
    flechten_mask = value_linear_step(flechten_mask, 0.7, 0.2);
    vec3 flechten_color = color_hex(0xA3A67A);
    albedo = mix(albedo, flechten_color, flechten_mask);

    roughness = easing_power_in(1.0 - height, 5.0);
    roughness = value_remap(roughness, 0.0, 1.0, 0.3, 1.0);
    roughness = clamp(roughness + flechten_mask, 0.0, 1.0);



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