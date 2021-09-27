#include "constants.glsl"
#include "gradients.glsl"

#ifndef UV
#define UV



vec2 uv_provide()
{
    vec2 uv = gl_FragCoord.xy / iResolution.y;
    float offset = (1.0 - (iResolution.x / iResolution.y)) * 0.5;

    return uv + vec2(offset, 0.0);
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

void uv_tilling(inout vec2 uv, out vec2 tile_id, vec2 tiles)
{
    uv *= tiles;

    tile_id = floor(uv);
    uv = fract(uv);
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
