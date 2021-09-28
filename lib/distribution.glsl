#include "./random.glsl"
#include "./ray.glsl"
#include "./constants.glsl"

#ifndef DISTRIBUTION
#define DISTRIBUTION


void VogelDiskPoint(in float index, in float count, in float phi, out vec2 result)
{
    float theta = index * GOLDANGLE + phi;
    float r = sqrt(index + 0.5) / sqrt(count);
    result = vec2(r * cos(theta), r * sin(theta));
}

void VogelConePoint(in float index, in float count, in float phi, in float angle, out vec3 result)
{
    vec2 vogelPoint;
    VogelDiskPoint(index, count, phi, vogelPoint);
    RayPerspective(vogelPoint * 0.5 + 0.5, angle, result);
}

void VogelSpherePoint(in float index, in float count, in float phi, out vec3 result)
{
    float theta = index * GOLDANGLE + phi;
    float z = (index / count) * 2.0 - 1.0;
    float r = sqrt(1.0 - z * z);
    result = vec3(r * cos(theta), r * sin(theta), z);
}

void VogelHemispherePoint(in float index, in float count, in float phi, in float angle, out vec3 result)
{
    float theta = index * GOLDANGLE + phi;
    float limit = angle / PI;
    float z = (1.0 - ((index / count) * limit)) * 2.0 - 1.0;
    float r = sqrt(1.0 - z * z);
    result = vec3(r * cos(theta), r * sin(theta), z);
}

void NormalDistribution(in float point, in float deviation, in float mean, out float result)
{
    float a = 1.0 / (deviation * sqrt(PI2));
    float b = (point - mean) / deviation;

    result = a * exp(-0.5 * b * b);
}



#endif