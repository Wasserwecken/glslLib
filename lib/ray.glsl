#include "constants.glsl"


#ifndef RAY
#define RAY


void RayPerspective(in vec2 uv, in float fov, out vec3 ray)
{
    float stretch = tan(fov / 2.0);
    vec2 pos = (uv * 2.0 - 1.0) * stretch;
    ray = normalize(vec3(pos.x, pos.y, 1.0));
}


#endif