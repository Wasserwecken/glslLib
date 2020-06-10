#ifndef DISTANCEFIELDS
#define DISTANCEFIELDS

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