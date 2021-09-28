#include "constants.glsl"

#ifndef DISTANCEFIELDS
#define DISTANCEFIELDS


//https://www.iquilezles.org/www/articles/distfunctions2d/distfunctions2d.htm
float df_2D_circle(vec2 point, vec2 origin, float radius)
{
    return length(point - origin) -radius;
}


//https://www.iquilezles.org/www/articles/distfunctions2d/distfunctions2d.htm
float df_2D_line(vec2 point, vec2 start, vec2 end)
{
    float h = clamp(dot(start, end) / dot(end, end), 0.0, 1.0);
    return length(start - end * h);
}


//https://www.iquilezles.org/www/articles/distfunctions2d/distfunctions2d.htm
float df_2D_box(vec2 point, vec2 origin, vec2 size)
{
    vec2 diff = abs(point - origin) - size;
    return max(diff.x, diff.y);
}


//https://www.iquilezles.org/www/articles/distfunctions2d/distfunctions2d.htm
float df_2D_box_rounded(vec2 point, vec2 origin, vec2 size, vec4 radius)
{
    point -= origin;

    radius.xy = (point.x > 0.0) ? radius.xy : radius.zw;
    radius.x  = (point.y > 0.0) ? radius.x  : radius.y;
    vec2 q = abs(point) - size + radius.x;
    return min(max(q.x,q.y), 0.0) + length(max(q,0.0)) - radius.x;
}


//https://www.iquilezles.org/www/articles/distfunctions2d/distfunctions2d.htm
float df_2D_ngon(vec2 point, vec2 origin, float radius, float edges)
{
    point -= origin;

    float dist = length(point);
    float spiral = (atan(point.x, point.y) + PI) / PI2;

    spiral = fract(spiral * edges) * 2.0 - 1.0;
    dist *= cos(spiral * PI / edges);
    return dist - radius;
}

#endif