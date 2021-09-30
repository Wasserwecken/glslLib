#include "helper.glsl"
#include "constants.glsl"
#include "distanceFields.glsl"

#ifndef GRADIENTS
#define GRADIENTS


void GradientSpiral(vec2 uv, float start, out float result)
{
    float spiral = (atan(uv.x, uv.y) + PI) / PI2;
    spiral = fract(spiral + 0.5 - start);

    result = spiral;  
}

void GradientDirection(vec2 uv, vec2 direction, out float result)
{
    float stretch = dot(direction, direction);
    float gradient = dot(uv, direction);

    result = gradient / stretch;
}

void GradientPoints(vec2 uv, vec2 from, vec2 to, out float result)
{
    vec2 center = 0.5 * (from + to);

    GradientDirection(uv - from, to - from, result);
}

//https://www.iquilezles.org/www/articles/palettes/palettes.htm
void GradientCosine(float t, float s, vec3 a, vec3 b, vec3 c, vec3 d, out vec3 result)
{
    result = a + b * cos(PI2 * (c + d * s * t));
}

#endif