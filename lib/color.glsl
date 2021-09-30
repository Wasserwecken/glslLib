#include "constants.glsl"
#include "easing.glsl"
#include "noise.glsl"
#include "noise.dimensions.glsl"

#ifndef COLOR
#define COLOR


void ColorGamma(in vec3 color, in float gamma, out vec3 result)
{
    result = pow(color, vec3(gamma));
}

//https://stackoverflow.com/questions/15095909/from-rgb-to-hsv-in-opengl-glsl
void ColorHsvToRgb(vec3 hsv, out vec3 result)
{
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(hsv.xxx + K.xyz) * 6.0 - K.www);
    result = hsv.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), hsv.y);
}


//https://stackoverflow.com/questions/15095909/from-rgb-to-hsv-in-opengl-glsl
void ColorRgbToHsv(vec3 rgb, out vec3 result)
{
    vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    vec4 p = mix(vec4(rgb.bg, K.wz), vec4(rgb.gb, K.xy), step(rgb.b, rgb.g));
    vec4 q = mix(vec4(p.xyw, rgb.r), vec4(rgb.r, p.yzx), step(p.x, rgb.r));

    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    result = vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}


//https://stackoverflow.com/questions/22895237/hexadecimal-to-rgb-values-in-webgl-shader
void ColorHexToRgb(int hex_code, out vec3 result)
{
    result = vec3(
        mod(float(hex_code / 256 / 256), 256.0),
        mod(float(hex_code / 256), 256.0),
        mod(float(hex_code), 256.0)
    ) / 255.0;
}


void Color256ToRgb(int r, int g, int b, out vec3 result)
{
    result = vec3(float(r), float(g), float(b)) / vec3(255.0);
}

#endif
