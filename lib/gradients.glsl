#include "constants.glsl"
#include "helper.glsl"
#include "distanceFields.glsl"

#ifndef GRADIENTS
#define GRADIENTS


float gradient_spiral(vec2 uv, vec2 origin, float start)
{
    uv -= origin;

    float spiral = (atan(uv.x, uv.y) + PI) / PI2;
    spiral = fract(spiral + 0.5 - start);

    return spiral;  
}

float gradient_direction(vec2 uv, vec2 origin, vec2 direction)
{
    direction = -direction;
    uv = origin - uv;

    float stretch = dot(direction, direction);
    float gradient = dot(uv, direction);

    return gradient / stretch + 0.5;
}

float gradient_points(vec2 uv, vec2 from, vec2 to)
{
    vec2 origin = (from + to) * 0.5;
    vec2 direction = (to - origin) * 2.0;

    return gradient_direction(uv, origin, direction);
}

//https://www.iquilezles.org/www/articles/palettes/palettes.htm
vec3 gradient_cosine(float t, float s, vec3 a, vec3 b, vec3 c, vec3 d)
{
    return a + b * cos(PI2 * (c + d * s * t));
}

#endif