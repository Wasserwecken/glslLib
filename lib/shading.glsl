#include "random.glsl"

#ifndef SHADING
#define SHADING


void BRDF_lambert(
    vec3 seed,
    vec3 normal,
    vec3 in_direction,
    vec3 in_color,
    out vec3 out_direction,
    out vec3 out_color,

    vec3 diffuse_color)
{
    float lambert = max(0.0, dot(-normal, in_direction));

    out_color = in_color * lambert * diffuse_color;
    out_direction = random_on_hemisphere(seed, normal);
}

void BRDF_phong(
    vec3 seed,
    vec3 normal,
    vec3 in_direction,
    vec3 in_color,
    out vec3 out_direction,
    out vec3 out_color,

    vec3 diffuse_color,
    vec3 specular_color,
    float specular_strength)
{
    BRDF_lambert(seed, normal,
        in_direction, in_color,
        out_direction, out_color,
        diffuse_color
    );

    float specular_angle = max(0.0, dot(-normal, in_direction));
    float specular = pow(specular_angle, specular_strength);

    out_direction = mix(reflect(in_direction, normal), out_direction, 1.0 / (1.0 + specular_strength));
    out_color += in_color * specular * specular_color;
}

#endif