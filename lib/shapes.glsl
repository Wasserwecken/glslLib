#include "constants.glsl"
#include "helper.glsl"
#include "distanceFields.glsl"

#ifndef SHAPES
#define SHAPES


float shape_line(vec2 uv, vec2 p1, vec2 p2, float blur)
{
    float df = df_line(uv, p1, p2);
    return value_linear_step(0.0, df, blur);
}

float shape_circle(vec2 uv, vec2 origin, float radius, float blur)
{
    float df = df_circle(uv, origin, radius);
    return value_linear_step(0.0, df, blur);
}

float shape_box(vec2 uv, vec2 origin, vec2 size, float blur)
{
    float df = df_box(uv, origin, size);
    return value_linear_step(df, 0.0, blur);
}

float shape_box(vec2 uv, vec2 origin, vec2 size, vec2 blur)
{
    uv = abs(uv - origin);
    vec2 isRectangle = value_linear_step(size, uv, blur);
    return min(isRectangle.x, isRectangle.y);
}

float shape_box_rounded(vec2 uv, vec2 origin, vec2 size, float blur, vec4 radius)
{
    float df = df_box_rounded(uv, origin, size, radius);
    return value_linear_step(0.0, df, blur);
}

float shape_ngon(vec2 uv, vec2 origin, float radius, float edges, float blur)
{
    float df = df_ngon(uv, origin, radius, edges);
    return value_linear_step(0.0, df, blur);
}

#endif
