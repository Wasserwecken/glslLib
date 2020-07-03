#include "constants.glsl"

#ifndef DISTANCEFIELDS
#define DISTANCEFIELDS


//https://www.iquilezles.org/www/articles/distfunctions2d/distfunctions2d.htm


float df_circle(vec2 point, vec2 origin, float radius)
{
    return length(point - origin) -radius;
}

float df_line(vec2 point, vec2 start, vec2 end)
{
    float h = clamp(dot(start, end) / dot(end, end), 0.0, 1.0);
    return length(start - end * h);
}

float df_box(vec2 point, vec2 origin, vec2 size)
{
    vec2 diff = abs(point - origin) - size;
    return min(diff.x, diff.y);
}

float df_box_rounded(vec2 point, vec2 origin, vec2 size, vec4 radius)
{
    point -= origin;

    radius.xy = (point.x > 0.0) ? radius.xy : radius.zw;
    radius.x  = (point.y > 0.0) ? radius.x  : radius.y;
    vec2 q = abs(point) - size + radius.x;
    return min(max(q.x,q.y), 0.0) + length(max(q,0.0)) - radius.x;
}

float df_ngon(vec2 point, vec2 origin, float radius, float edges)
{
    point -= origin;

    float dist = length(point);
    float spiral = (atan(point.x, point.y) + PI) / PI2;

    spiral = fract(spiral * edges) * 2.0 - 1.0;
    dist *= cos(spiral * PI / edges);
    return dist - radius;
}







float df_plane(vec3 point, vec3 origin, vec3 normal)
{
    return abs(dot((point - origin), normal));
}

float df_box(vec3 point, vec3 origin, vec3 size, float roundness)
{
    vec3 delta = abs(point - origin) - size + roundness;

    return length(max(delta,0.0))
        + min(max(delta.x,max(delta.y,delta.z)),0.0)
        - roundness;
}

float df_sphere(vec3 point, vec3 origin, float radius)
{
    return length(point - origin) - radius;
}

#endif