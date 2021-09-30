#include "constants.glsl"


#ifndef RAY
#define RAY


void RayPerspective(in vec2 uv, in float fov, out vec3 ray)
{
    float stretch = tan(fov / 2.0);
    vec2 pos = (uv * 2.0 - 1.0) * stretch;
    ray = normalize(vec3(pos.x, pos.y, 1.0));
}

void RayDDADirection(mat4 projectionToView, vec2 originSS, vec3 originWS, vec3 directionWS, out vec2 pixelDirection)
{
    // to view space
    vec4 projectionSpace = projectionToView * vec4(originWS + (directionWS * 0.1), 1.0);
    projectionSpace = (projectionSpace / projectionSpace.w) * 0.5 + 0.5;

    // SS direction
    pixelDirection = projectionSpace.xy - originSS;

    // normalize to 1.0 on the dominant axis
    if (abs(pixelDirection.x) > abs(pixelDirection.y))
        pixelDirection *= (1.0 / abs(pixelDirection.x));
    else
        pixelDirection *= (1.0 / abs(pixelDirection.y));
}


#endif