#include "constants.glsl"
#include "easing.glsl"
#include "noise.glsl"
#include "noise.dimensions.glsl"


#ifndef COLOR
#define COLOR


//https://stackoverflow.com/questions/15095909/from-rgb-to-hsv-in-opengl-glsl
vec3 color_hsv_to_rgb(vec3 hsv)
{
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(hsv.xxx + K.xyz) * 6.0 - K.www);
    return hsv.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), hsv.y);
}


//https://stackoverflow.com/questions/15095909/from-rgb-to-hsv-in-opengl-glsl
vec3 color_rgb_to_hsv(vec3 rgb)
{
    vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    vec4 p = mix(vec4(rgb.bg, K.wz), vec4(rgb.gb, K.xy), step(rgb.b, rgb.g));
    vec4 q = mix(vec4(p.xyw, rgb.r), vec4(rgb.r, p.yzx), step(p.x, rgb.r));

    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}


//https://stackoverflow.com/questions/22895237/hexadecimal-to-rgb-values-in-webgl-shader
vec3 color_hex_to_rgb(int hex_code)
{
    return vec3(
        mod(float(hex_code / 256 / 256), 256.0),
        mod(float(hex_code / 256), 256.0),
        mod(float(hex_code), 256.0)
    ) / 255.0;
}


vec3 color_256_to_rgb(int r, int g, int b)
{
    return vec3(float(r), float(g), float(b)) / vec3(255.0);
}

#endif
