#include "constants.glsl"
#include "gradients.glsl"


#ifndef UV
#define UV


void uv_provide(in vec2 fragCoord, in vec2 resolution, out vec2 uvResult, out vec2 uvRatio)
{
    uvResult = (fragCoord / resolution);
    uvRatio = resolution / min(resolution.x, resolution.y);
}


void uv_fit(in vec2 uv, in vec2 size, out vec2 uvResult)
{
    uvResult = uv;

    if (size.x > size.y)
    {
        uvResult.x *= size.x / size.y;
        uvResult.x += (size.y - size.x) * 0.5;
    }
    else
    {
        uvResult.y *= size.y / size.x;
        uvResult.y += (size.x - size.y) * 0.5;
    }
}


void uv_fill(in vec2 uv, in vec2 size, out vec2 uvResult)
{
    uvResult = uv;

    if (size.x < size.y)
    {
        uvResult.x += (size.y - size.x) * 0.5;
        uvResult.x *= size.x / size.y;
    }
    else
    {
        uvResult.y += (size.x - size.y) * 0.5;
        uvResult.y *= size.y / size.x;
    }
}

void uv_rotate(in vec2 uv, in vec2 origin, in float angle, out vec2 uvResult)
{
    angle *= DEGTORAD;
    float s = sin(angle);
	float c = cos(angle);
	mat2 m = mat2(c, -s, s, c);

    uv -= origin;
    uv = m * uv;
    uv += origin;

    uvResult = uv;
}

void uv_to_polar(in vec2 uv, in vec2 origin, out vec2 uvResult)
{
    float len = length(uv - origin);
    float angle = gradient_spiral(uv, origin, 0.0);

    uvResult = vec2(angle, len);
}

void uv_tile(in vec2 uv, in vec2 tiles, out vec2 tileUV, out vec2 tileID)
{
    tileUV = uv * tiles;

    tileID = floor(tileUV);
    tileUV = fract(tileUV);
}

void uv_tile_offset(in vec2 uv, in vec2 id, in float offset, in float offsetStep, out vec2 offsetUV, out vec2 offsetID)
{
    uv += id;
    uv.x += offset * floor(id.y * (1.0 / offsetStep));

    offsetUV = fract(uv);
    offsetID = floor(uv);
}

void uv_distort_twirl(in vec2 uv, in float distortion, in vec2 offset, in float strength, out vec2 uvResult)
{
    distortion = ((distortion * 360.0) - 180.0);
    distortion *= strength * length(offset);
    uv_rotate(uv, uv + offset, distortion, uvResult);
}

void uv_distort_spherize(inout vec2 uv, vec2 center, float strength, out vec2 uvResult)
{
    vec2 delta = uv - center;
    float distortion = dot(delta, delta) * dot(delta, delta);
    
    uvResult = uv + delta * distortion * strength;
}


#endif
