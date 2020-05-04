#include "constants.glsl"
#include "easing.glsl"
#include "noise.glsl"
#include "noise.dimensions.glsl"

#ifndef COLOR
#define COLOR

//////////////////////////////
// Colors
//////////////////////////////

// https://stackoverflow.com/questions/22895237/hexadecimal-to-rgb-values-in-webgl-shader
vec3 color_hex(int hex_code)
{
    return vec3(
        mod(float(hex_code / 256 / 256), 256.0),
        mod(float(hex_code / 256), 256.0),
        mod(float(hex_code), 256.0)
    ) / 255.0;
}

vec3 color_256(int r, int g, int b)
{
    return vec3(float(r), float(g), float(b)) / vec3(256.0);
}

//https://stackoverflow.com/questions/15095909/from-rgb-to-hsv-in-opengl-glsl
vec3 color_hsv(vec3 hsv)
{
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(hsv.xxx + K.xyz) * 6.0 - K.www);
    return hsv.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), hsv.y);
}

//https://stackoverflow.com/questions/15095909/from-rgb-to-hsv-in-opengl-glsl
vec3 color_to_hsv(vec3 rgb)
{
    vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    vec4 p = mix(vec4(rgb.bg, K.wz), vec4(rgb.gb, K.xy), step(rgb.b, rgb.g));
    vec4 q = mix(vec4(p.xyw, rgb.r), vec4(rgb.r, p.yzx), step(p.x, rgb.r));

    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}


//https://www.iquilezles.org/www/articles/palettes/palettes.htm
vec3 gradient(float t, float s, vec3 a, vec3 b, vec3 c, vec3 d)
{
    return a + b * cos(PI2 * (c + d * s * t));
}

vec3 gradient(float point, float seed, vec3 color, float intensity, int layers, float gain, float scale)
{
    vec3 variation = noise_perlin_vec3(point, seed, layers, gain, scale);
    variation = easing_power_inout(variation, vec3(intensity));
    variation = variation * 2.0 - 1.0;
    
    return (color * variation) + color;
}

vec3 gradient(float point, float seed, vec3 colorA, vec3 colorB, float intensity)
{
    float variation = noise_perlin(point, seed++, 5, 0.5, 2.0);
    variation = easing_power_inout(variation, intensity);

    return mix(colorA, colorB, variation);
}

vec3 color_gradient_generated_perlin(
        float t,
        vec3 color,
        vec3 seed,
        vec3 scale,
        vec3 dist,
        vec3 layers,
        vec3 layers_scale,
        vec3 layers_weight)
{
    vec3 interpolation = vec3(
        noise_perlin(t * scale.x, random(seed.x), int(layers.x), layers_scale.x, layers_weight.x),
        noise_perlin(t * scale.y, random(seed.y), int(layers.y), layers_scale.y, layers_weight.y),
        noise_perlin(t * scale.z, random(seed.z), int(layers.z), layers_scale.z, layers_weight.z)
    );
    interpolation = easing_power_inout(interpolation, dist) * 2.0 - 1.0;
    return (color * interpolation) + color;
}


vec3 color_hsv_shift(vec3 color, float hue, float saturation, float value)
{
    vec3 hsv = color_to_hsv(color);

    hsv.x = fract(hsv.x + hue);
    hsv.y = clamp(hsv.y + saturation, 0.0, 1.0);
    hsv.z = clamp(hsv.z + value, 0.0, 1.0);
    
    return color_hsv(hsv);
}


vec3 color_contrast_gamma(vec3 color, float contrast)
{
    float mid = pow(0.5, 2.2);
    return (color - mid) * contrast + mid;
}

vec3 color_deviate(vec3 color, vec3 seed, vec3 strenght)
{
    vec3 deviation = vec3(
        random(seed.x),
        random(seed.y),
        random(seed.z)
    );
    deviation = deviation * 2.0 - 1.0;
    deviation *= strenght;

    return (color * deviation) + color;
}


#endif
