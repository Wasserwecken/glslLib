#include "constants.glsl"
#include "uv.glsl"

#ifndef CAMERA
#define CAMERA

vec3 camera_gamma_correction(vec3 linearColor)
{
    linearColor = linearColor / (linearColor + vec3(1.0));
    return pow(linearColor, vec3(0.45454545)); // (1.0 / 2.2) --> 0.45454545...
}

void camera_ray(
    vec2 resolution,
    vec2 pixel,
    out vec3 ray_origin,
    out vec3 ray_direction,
    vec3 position,
    vec3 direction,
    float fov)
{
    vec2 uv = uv_create(resolution, pixel, 1.0);

    // ray spread
    float stretch = tan(fov * DEGTORAD / 2.0);
    vec2 tilt = (uv * 2.0 - 1.0) * stretch;
    vec3 rawDirection = normalize(vec3(tilt.x, tilt.y, 1.0));

    // rotate towards view direction
    vec3 s = normalize(cross(-direction, vec3_up));
    vec3 u = cross(s, -direction);
    mat3 rotationMatrix = mat3(s, u, direction);

    ray_origin = position;
    ray_direction = rotationMatrix * rawDirection;
}

#endif