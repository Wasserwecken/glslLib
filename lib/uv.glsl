#include "constants.glsl"
#include "gradients.glsl"


#ifndef UV
#define UV


vec2 uv_provide_stretch(vec2 fragCoord, vec2 resolution)
{
    return (fragCoord / resolution);
}

vec2 uv_provide_fit(vec2 fragCoord, vec2 resolution)
{
    if (resolution.x > resolution.y)
    {
        fragCoord.x += (resolution.y - resolution.x) * 0.5;
        resolution.x = resolution.y;
    }
    else
    {
        fragCoord.y += (resolution.x - resolution.y) * 0.5;
        resolution.y = resolution.x;
    }

    return (fragCoord / resolution);
}

vec2 uv_provide_fill(vec2 fragCoord, vec2 resolution)
{
    if (resolution.x > resolution.y)
    {
        fragCoord.y += (resolution.x - resolution.y) * 0.5;
        resolution.y = resolution.x;
    }
    else
    {
        fragCoord.x += (resolution.y - resolution.x) * 0.5;
        resolution.x = resolution.y;
    }

    return (fragCoord / resolution);
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
