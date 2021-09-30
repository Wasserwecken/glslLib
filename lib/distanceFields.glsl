#include "constants.glsl"

#ifndef DISTANCEFIELDS
#define DISTANCEFIELDS


//https://www.iquilezles.org/www/articles/distfunctions2d/distfunctions2d.htm
void DF2DCircle(vec2 point, vec2 origin, float radius, out float result)
{
    result = length(point - origin) -radius;
}


//https://www.iquilezles.org/www/articles/distfunctions2d/distfunctions2d.htm
void DF2DLine(vec2 point, vec2 start, vec2 end, out float result)
{
    float h = clamp(dot(start, end) / dot(end, end), 0.0, 1.0);
    result = length(start - end * h);
}


//https://www.iquilezles.org/www/articles/distfunctions2d/distfunctions2d.htm
void DF2DBox(vec2 point, vec2 origin, vec2 size, out float result)
{
    vec2 diff = abs(point - origin) - size;
    result = max(diff.x, diff.y);
}


//https://www.iquilezles.org/www/articles/distfunctions2d/distfunctions2d.htm
void DF2DBoxRound(vec2 point, vec2 origin, vec2 size, vec4 radius, out float result)
{
    point -= origin;

    radius.xy = (point.x > 0.0) ? radius.xy : radius.zw;
    radius.x  = (point.y > 0.0) ? radius.x  : radius.y;
    vec2 q = abs(point) - size + radius.x;
    result = min(max(q.x,q.y), 0.0) + length(max(q,0.0)) - radius.x;
}


//https://www.iquilezles.org/www/articles/distfunctions2d/distfunctions2d.htm
void DF2DNgon(vec2 point, vec2 origin, float radius, float edges, out float result)
{
    point -= origin;

    float dist = length(point);
    float spiral = (atan(point.x, point.y) + PI) / PI2;

    spiral = fract(spiral * edges) * 2.0 - 1.0;
    dist *= cos(spiral * PI / edges);
    result = dist - radius;
}

#endif