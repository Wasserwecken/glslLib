#include "constants.glsl"
#include "shapes.glsl"

#ifndef UV
#define UV

//////////////////////////////
// UV
//////////////////////////////
vec2 uv_translate(vec2 uv, vec2 diff)
{
    return uv + diff;
}

vec2 uv_scale(vec2 uv, vec2 scale)
{
    return uv * scale;
}

vec2 uv_rotate(vec2 uv, vec2 origin, float angle)
{
    angle *= DEGTORAD;
    float s = sin(angle);
	float c = cos(angle);
	mat2 m = mat2(c, -s, s, c);

    uv -= origin;
    uv = m * uv;
    uv += origin;

	return uv;
}

vec2 uv_to_polar(vec2 uv, vec2 origin)
{
    float len = length(uv - origin);
    float angle = shape_spiral(uv, origin, 0.0);

    return vec2(angle, len);
}

vec2 uv_tilling(vec2 uv, out vec2 tile_id, vec2 tiles)
{
    uv *= tiles;
    tile_id = floor(uv);

    return fract(uv);
}

vec2 uv_tilling_tile_offset(vec2 uv, out vec2 tile_id, float offset, float offset_step)
{
    uv += tile_id;
    uv.x += offset * floor(tile_id.y * (1.0 / offset_step));
    tile_id = floor(uv);

    return fract(uv);
}


vec2 uv_tilling_01(vec2 uv, out vec2 tile_id, vec2 tiles, float offset_step, float offset)
{
    uv *= tiles;
    tile_id = floor(uv);
    uv.x -= offset * floor(tile_id.y * (1.0 / offset_step));
    tile_id = floor(uv);
    
    return fract(uv);
}

vec2 uv_tilling_0X(vec2 uv, out vec2 tile_id, vec2 tiles, float offset_step, float offset)
{
    uv *= tiles;
    tile_id = floor(uv);
    uv.x -= offset * floor(tile_id.y * (1.0 / offset_step));
    tile_id = floor(uv);
    
    return fract(uv) * tiles.yx;
}

vec2 uv_distort_twirl(vec2 uv, float distortion, vec2 offset, float strength)
{
    distortion = ((distortion * 360.0) - 180.0);
    distortion *= strength * length(offset);
    return uv_rotate(uv, uv + offset, distortion);
}

vec2 uv_distort_spherize(vec2 uv, vec2 center, float strength)
{
    vec2 delta = uv - center;
    float distortion = dot(delta, delta);
    distortion *= distortion;
    
    return uv + (delta * distortion * strength);
}


#endif
