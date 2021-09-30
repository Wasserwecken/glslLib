#include "constants.glsl"

#ifndef HELPER
#define HELPER


void ManhattenLength(in vec2 vector, out float result)
{
    vector = abs(vector);
    result = vector.x + vector.y;
}

void Remap(in float value, in float inLower, in float inUpper, in float outLower, in float outUpper, out float result)
{
    value -= inLower;
    value *= outUpper - outLower;
    value /= inUpper - inLower;
    result = value + outLower;
}

void RemapTo01(in float value, in float outLower, in float outUpper, out float result)
{
    result = value * (outUpper - outLower) + outLower;
}

void LinearStep(in float value, in float edge, in float width, out float result)
{
    float f = (value - edge + (width * .5)) / width;
    result = clamp(f, 0.0, 1.0);
}

void Posterize(in float value, in float steps, out float result)
{
    result = floor(value * steps) / steps;
}

void ZigZag(in float value, in float size, out float result)
{
    result = mod(value - size * 0.5, size);
    result = abs(result - size * 0.5);
}

void NormalFromHeightTexture(in sampler2D source, in vec2 uv, in float sampleSize, in float strength, out vec3 normal)
{
    vec2 texelSize = sampleSize * (1.0 / vec2(textureSize(source, 0)));

    float current = texture(source, uv).x;
    float top = texture(source, uv + vec2(0.0, texelSize.y)).x;
    float right = texture(source, uv + vec2(texelSize.x, 0.0)).x;

    normal = normalize(vec3(current - vec2(right, top), strength));
}

void NormalFromHeightDerivative(float height, float strength, out vec3 normal)
{
    normal = normalize(vec3(-dFdx(height), -dFdy(height), strength));
}

void ldot(in vec2 a, in vec2 b, out float result)
{
    result = (1.0 - (acos(dot(a, b)) / PI)) * 2.0 - 1.0;
}

#endif