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

void uv_rotate(inout vec2 uv, vec2 origin, float angle)
{
    angle *= DEGTORAD;
    float s = sin(angle);
	float c = cos(angle);
	mat2 m = mat2(c, -s, s, c);

    uv -= origin;
    uv = m * uv;
    uv += origin;
}

void uv_to_polar(inout vec2 uv, vec2 origin)
{
    float len = length(uv - origin);
    float angle = gradient_spiral(uv, origin, 0.0);

    uv = vec2(angle, len);
}

void uv_tilling(in vec2 uv, in vec2 tiles, out vec2 tile_uv, out vec2 tile_id)
{
    tile_uv = uv * tiles;

    tile_id = floor(tile_uv);
    tile_uv = fract(tile_uv);
}

void uv_fit(in vec2 uvOuter, in float ratioOuter, in vec2 uvInner, in float ratioInner)
{
    
}

void uv_tilling_tile_offset(inout vec2 uv, out vec2 tile_id, float offset, float offset_step)
{
    uv += tile_id;
    uv.x += offset * floor(tile_id.y * (1.0 / offset_step));

    tile_id = floor(uv);
    uv = fract(uv);
}

void uv_distort_twirl(inout vec2 uv, float distortion, vec2 offset, float strength)
{
    distortion = ((distortion * 360.0) - 180.0);
    distortion *= strength * length(offset);
    uv_rotate(uv, uv + offset, distortion);
}

void uv_distort_spherize(inout vec2 uv, vec2 center, float strength)
{
    vec2 delta = uv - center;
    float distortion = dot(delta, delta) * dot(delta, delta);
    
    uv += delta * distortion * strength;
}


#endif
