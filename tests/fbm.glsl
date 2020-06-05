#include "../collection/uv.glsl"
#include "../collection/noise.glsl"
#include "../collection/noise.fbm.glsl"



const float FBM_RESCALE = 1.0;

float test_fbm_value(vec2 uv, float time)
{
    vec2 tile_id;
    vec2 tile_uv = uv_tilling(uv, tile_id, vec2(4.0, 1.0));

    vec3 point, seed;
    int depth;
    float smoothness, gain, scale;

    point = vec3(tile_uv, time * 0.02);
    seed = vec3(floor(1.0 + iTime * 0.));
    smoothness = sin(iTime * 0.5) + 1.0;

    depth = 3;
    gain = 0.5;
    scale = 2.0;


    switch(int(tile_id.x))
    {
        case 0:
            return noise_value(point.x, seed.x, smoothness, depth, gain, scale);
        case 1:
            return noise_value(point.xy, seed.xy, smoothness, depth, gain, scale);
        case 2:
            return noise_value(point.xyz, seed.xyz, smoothness, depth, gain, scale);
    }
}

float test_fbm_perlin(vec2 uv, float time)
{
    vec2 tile_id;
    vec2 tile_uv = uv_tilling(uv, tile_id, vec2(4.0, 1.0));

    vec3 point, seed;
    int depth;
    float gain, scale;

    point = vec3(tile_uv, time * 0.02);
    seed = vec3(floor(1.0 + iTime * 0.));

    depth = 3;
    gain = 0.5;
    scale = 2.0;


    switch(int(tile_id.x))
    {
        case 0:
            return noise_perlin(point.x, seed.x, depth, gain, scale);
        case 1:
            return noise_perlin(point.xy, seed.xy, depth, gain, scale);
        case 2:
            return noise_perlin(point.xyz, seed.xyz, depth, gain, scale);
    }
}

float test_fbm_voronoi(vec2 uv, float time)
{
    vec2 tile_id;
    vec2 tile_uv = uv_tilling(uv, tile_id, vec2(4.0, 1.0));

    vec3 noise, point, seed, id, center, strength;
    int depth;
    float gain, scale;

    point = vec3(tile_uv, time * 0.02);
    seed = vec3(floor(1.0 + iTime * 0.));
    strength = vec3(sin(iTime * 0.5) * .5 + .5);

    depth = 3;
    gain = 0.5;
    scale = 2.0;


    switch(int(tile_id.x))
    {
        case 0:
            return noise_voronoi(point.x, seed.x, id.x, center.x, strength.x, depth, gain, scale);
        case 1:
            return noise_voronoi(point.xy, seed.xy, id.xy, center.xy, strength.xy, depth, gain, scale);
        case 2:
            return noise_voronoi(point.xyz, seed.xyz, id.xyz, center.xyz, strength.xyz, depth, gain, scale);
    }
}

float test_fbm_voronoi_edge(vec2 uv, float time)
{
    vec2 tile_id;
    vec2 tile_uv = uv_tilling(uv, tile_id, vec2(4.0, 1.0));

    vec3 point, seed, id, center, strength;
    int depth;
    float gain, scale, dist;

    point = vec3(tile_uv, time * 0.02);
    seed = vec3(floor(1.0 + iTime * 0.));
    strength = vec3(sin(iTime * 0.5) * .5 + .5);

    depth = 3;
    gain = 0.5;
    scale = 2.0;


    switch(int(tile_id.x))
    {
        case 1:
            return noise_voronoi_edge(point.xy, seed.xy, id.xy, center.xy, dist, strength.xy, depth, gain, scale);
        case 2:
            return noise_voronoi_edge(point.xyz, seed.xyz, id.xyz, center.xyz, dist, strength.xyz, depth, gain, scale);
    }
}

vec3 test_fbm(vec2 uv, float time)
{
    vec2 tile_id;
    vec2 tile_uv = uv_tilling(uv, tile_id, vec2(1.0, 4.0));

    switch(int(tile_id.y))
    {
        case 0:
            return vec3(test_fbm_value(tile_uv, time));
        case 1:
            return vec3(test_fbm_perlin(tile_uv, time));
        case 2:
            return vec3(test_fbm_voronoi(tile_uv, time));
        case 3:
            return vec3(test_fbm_voronoi_edge(tile_uv, time));
    }
}
