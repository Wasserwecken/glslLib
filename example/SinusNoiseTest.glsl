#include "/collection/constants.glsl"
#include "/collection/helper.glsl"
#include "/collection/easing.glsl"
#include "/collection/shapes.glsl"
#include "/collection/noise.glsl"
#include "/collection/uv.glsl"
#include "/collection/color.glsl"


float noise_sine(float point, float seed, int layers, float offset)
{
    point *= NOISE_SCALE * 10.0;

    float result = 0.0;
    for(int layer = 1; layer <= layers; layer++)
    {
        float phase = random(seed++) * PI2;
        float frequency = random(seed++) * PI2;
        result += sin(point * frequency + phase);
    }

    result /= float(layers);
    return result * 0.5 + 0.5;
}

float noise_sine(vec2 point, vec2 seed, int layers, float offset)
{
    point *= NOISE_SCALE;

    float result = 0.0;
    for(int layer = 1; layer <= layers; layer++)
    {
        vec2 phase = random_vec2(seed++) * PI2;
        vec2 frequency = random_vec2(seed++) * PI2;
        vec2 waves = sin(point * frequency + phase);
        result += waves.x * waves.y;
    }

    result /= float(layers);
    return result * 0.5 + 0.5;
}



void main() {
    vec2 uv = gl_FragCoord.xy / iResolution.y;
    uv *= 1.0;

    vec2 seed = vec2(1.0 + floor(iTime / 5.0)) * 0.0 + 1.0;
    vec3 albedo;
    float height;
    float roughness;

    height = noise_sine(uv, seed, 10, iTime);    




    vec3 color;
    uv.x -= uv.y * 0.5;
    if (uv.x < 1.0)
        color = vec3(height);
    if (uv.x < 0.5)
        color = vec3(roughness);
    if (uv.x < 0.0)
        color = albedo;
        
    color = vec3(height);
	gl_FragColor = vec4(color, 1.0);
}