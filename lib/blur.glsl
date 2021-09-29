#include "constants.glsl"
#include "easing.glsl"


#ifndef BLUR
#define BLUR


void BlurGaussian2Pass(in vec2 uv, in sampler2D source, in float stepSize, in float horizontal, in int kernelSize, float[11] weights, out vec3 result)
{
    vec2 texelSize = stepSize * (1.0 / vec2(textureSize(source, 0)));
    float weightSum = weights[0];
    result = texture(source, uv).xyz * weights[0];

    vec2 offset;
    if (horizontal > 0.5)
        offset = vec2(texelSize.x, 0.0);
    else
        offset = vec2(0.0, texelSize.y);

    for(int i = 1; i < kernelSize; ++i)
    {
        weightSum += 2.0 * weights[i];
        result += texture(source, uv + (offset * float(i))).xyz * weights[i];
        result += texture(source, uv - (offset * float(i))).xyz * weights[i];
    }

    result /= weightSum;
}

#endif