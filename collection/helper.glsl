#include "constants.glsl"

#ifndef HELPER
#define HELPER


float value_manhatten_length(vec2 vector)
{
    vector = abs(vector);
    return vector.x + vector.y;
}

float value_remap(float value, float in_lower, float in_upper, float out_lower, float out_upper)
{
    value -= in_lower;
    value *= out_upper - out_lower;
    value /= in_upper - in_lower;
    value += out_lower;

    return value;
}

float value_remap_01(float value, float out_lower, float out_upper)
{
    return value * (out_upper - out_lower) + out_lower;
}

float value_linear_step(float value, float edge, float edge_width)
{
    float f = (value - edge + (edge_width * .5)) / edge_width;
    return clamp(f, 0.0, 1.0);
}

float value_posterize(float value, float steps)
{
    return floor(value * steps) / steps;
}

vec3 converter_height_to_normal(float height, float strength)
{
    float x = -dFdx(height);
    float y = -dFdy(height);
    float depth = 1.0 / strength;

    vec3 normal = vec3(x, y, depth);
    normal = normalize(normal);
    normal = normal * 0.5 + 0.5;

    return normal;
}

float ldot(vec2 a, vec2 b)
{
    return (1.0 - (acos(dot(a, b)) / PI)) * 2.0 - 1.0;
}



//------------------------------------------------------
//------------------------------------------------------
//      DIMENSION EXTENSIONS
//------------------------------------------------------
//------------------------------------------------------
vec2 value_remap(vec2 value, vec2 in_lower, vec2 in_upper, vec2 out_lower, vec2 out_upper)
{
    return vec2(
        value_remap(value.x, in_lower.x, in_upper.x, out_lower.x, out_upper.x),
        value_remap(value.y, in_lower.y, in_upper.y, out_lower.y, out_upper.y)
    );
}

vec3 value_remap(vec3 value, vec3 in_lower, vec3 in_upper, vec3 out_lower, vec3 out_upper)
{
    return vec3(
        value_remap(value.x, in_lower.x, in_upper.x, out_lower.x, out_upper.x),
        value_remap(value.y, in_lower.y, in_upper.y, out_lower.y, out_upper.y),
        value_remap(value.z, in_lower.z, in_upper.z, out_lower.z, out_upper.z)
    );
}

vec2 value_remap_01(vec2 value, vec2 out_lower, vec2 out_upper)
{
    return vec2(
        value_remap_01(value.x, out_lower.x, out_upper.x),
        value_remap_01(value.y, out_lower.y, out_upper.y)
    );
}

vec3 value_remap_01(vec3 value, vec3 out_lower, vec3 out_upper)
{
    return vec3(
        value_remap_01(value.x, out_lower.x, out_upper.x),
        value_remap_01(value.y, out_lower.y, out_upper.y),
        value_remap_01(value.z, out_lower.z, out_upper.z)
    );
}

vec2 value_linear_step(vec2 value, vec2 edge, vec2 edge_width)
{
    return vec2(
        value_linear_step(value.x, edge.x, edge_width.x),
        value_linear_step(value.y, edge.y, edge_width.y)
    );
}

vec3 value_linear_step(vec3 value, vec3 edge, vec3 edge_width)
{
    return vec3(
        value_linear_step(value.x, edge.x, edge_width.x),
        value_linear_step(value.y, edge.y, edge_width.y),
        value_linear_step(value.z, edge.z, edge_width.z)
    );
}

vec2 value_posterize(vec2 value, vec2 steps)
{
    return vec2(
        value_posterize(value.x, steps.x),
        value_posterize(value.y, steps.y)
    );
}

vec3 value_posterize(vec3 value, vec3 steps)
{
    return vec3(
        value_posterize(value.x, steps.x),
        value_posterize(value.y, steps.y),
        value_posterize(value.z, steps.z)
    );
}


#endif