#include "constants.glsl"
#include "helper.glsl"

#ifndef SHAPES
#define SHAPES


//////////////////////////////
// Shapes
//////////////////////////////
float shape_spiral(vec2 uv, vec2 origin, float start)
{
    uv -= origin;

    float spiral = (atan(uv.x, uv.y) + PI) / PI2;
    spiral = fract(spiral + 0.5 - start);

    return spiral;  
}

float shape_gradient_direction(vec2 uv, vec2 origin, vec2 direction)
{
    direction = -direction;
    uv = origin - uv;

    float stretch = dot(direction, direction);
    float gradient = dot(uv, direction);

    return gradient / stretch + 0.5;
}

float shape_gradient_points(vec2 uv, vec2 from, vec2 to)
{
    vec2 origin = (from + to) * 0.5;
    vec2 direction = (to - origin) * 2.0;

    return shape_gradient_direction(uv, origin, direction);
}

float shape_circle(vec2 uv, vec2 origin, float radius, float blur)
{
    float len = length(uv - origin);
    return 1.0 - value_linear_step(len, radius, blur);
}

float shape_rectangle(vec2 uv, vec2 origin, vec2 size, vec2 blur)
{
    size *= 0.5;
    uv = abs(uv - origin);
    
    vec2 isRectangle = value_linear_step(size, uv, blur);
    return min(isRectangle.x, isRectangle.y);
}

float shape_rectangle_rounded(vec2 uv, vec2 origin, vec2 size, float blur, vec4 radius)
{
    uv -= origin;
    size *= 0.5;

    radius.xy = (uv.x > 0.0) ? radius.xy : radius.zw;
    radius.x  = (uv.y > 0.0) ? radius.x  : radius.y;
    vec2 q = abs(uv)-size+radius.x;
    float df = min(max(q.x,q.y),0.0) + length(max(q,0.0)) - radius.x;
    return value_linear_step(0.0, df, blur);
}

float shape_ngon(vec2 uv, vec2 origin, float radius, float edges, float bend, float blur)
{
    float dist = length(uv - origin);
    float spiral = shape_spiral(uv, origin, 0.0); 

    bend = (bend + 1.0) * 0.5 * PI2;
    spiral = fract(spiral * edges) * 2.0 - 1.0;
    dist *= cos(spiral * (bend / edges));

    return 1.0 - value_linear_step(dist, radius, blur);
}

#endif
