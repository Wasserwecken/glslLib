#include "constants.glsl"
#include "gradients.glsl"


#ifndef UV
#define UV


void UVProvide(in vec2 fragCoord, in vec2 resolution, out vec2 resultUV, out vec2 resultRatio)
{
    resultUV = (fragCoord / resolution);
    resultRatio = resolution / min(resolution.x, resolution.y);
}


void UVFit(in vec2 uv, in vec2 size, out vec2 resultUV)
{
    resultUV = uv;

    if (size.x > size.y)
    {
        resultUV.x *= size.x / size.y;
        resultUV.x += (size.y - size.x) * 0.5;
    }
    else
    {
        resultUV.y *= size.y / size.x;
        resultUV.y += (size.x - size.y) * 0.5;
    }
}


void UVFill(in vec2 uv, in vec2 size, out vec2 resultUV)
{
    resultUV = uv;

    if (size.x < size.y)
    {
        resultUV.x += (size.y - size.x) * 0.5;
        resultUV.x *= size.x / size.y;
    }
    else
    {
        resultUV.y += (size.x - size.y) * 0.5;
        resultUV.y *= size.y / size.x;
    }
}

void UVRotate(in vec2 uv, in vec2 origin, in float angle, out vec2 resultUV)
{
    angle *= DEGTORAD;
    float s = sin(angle);
	float c = cos(angle);
	mat2 m = mat2(c, -s, s, c);

    uv -= origin;
    uv = m * uv;
    uv += origin;

    resultUV = uv;
}

void UVPolar(in vec2 uv, in vec2 origin, out vec2 resultUV)
{
    float len = length(uv - origin);
    float angle = gradient_spiral(uv, origin, 0.0);

    resultUV = vec2(angle, len);
}

void UVTile(in vec2 uv, in vec2 tiles, out vec2 tileUV, out vec2 tileID)
{
    tileUV = uv * tiles;

    tileID = floor(tileUV);
    tileUV = fract(tileUV);
}

void UVTileOffset(in vec2 uv, in vec2 id, in float offset, in float offsetStep, out vec2 offsetUV, out vec2 offsetID)
{
    uv += id;
    uv.x += offset * floor(id.y * (1.0 / offsetStep));

    offsetUV = fract(uv);
    offsetID = floor(uv);
}

void UVDistortTwirl(in vec2 uv, in float distortion, in vec2 offset, in float strength, out vec2 resultUV)
{
    distortion = ((distortion * 360.0) - 180.0);
    distortion *= strength * length(offset);
    UVRotate(uv, uv + offset, distortion, resultUV);
}

void UVDistortSpherize(inout vec2 uv, vec2 center, float strength, out vec2 resultUV)
{
    vec2 delta = uv - center;
    float distortion = dot(delta, delta) * dot(delta, delta);
    
    resultUV = uv + delta * distortion * strength;
}


#endif
