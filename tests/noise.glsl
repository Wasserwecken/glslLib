#include "../lib/uv.glsl"
#include "../lib/noise.glsl"


#ifndef NOISE_TESTS
#define NOISE_TESTS


float test_noise_value(vec2 uv, float time)
{
    vec2 tile_id;
    vec2 tile_uv = uv_tilling(uv, tile_id, vec2(4.0, 1.0));

    vec3 point, seed;
    float smoothness;

    point = vec3(tile_uv, time * 0.02);
    seed = vec3(floor(1.0 + iTime * 0.));
    smoothness = sin(iTime * 0.5) + 1.0;

    switch(int(tile_id.x))
    {
        case 0:
            return noise_value(point.x, seed.x, smoothness);
        case 1:
            return noise_value(point.xy, seed.xy, smoothness);
        case 2:
            return noise_value(point.xyz, seed.xyz, smoothness);
    }
}

float test_noise_perlin(vec2 uv, float time)
{
    vec2 tile_id;
    vec2 tile_uv = uv_tilling(uv, tile_id, vec2(4.0, 1.0));

    vec3 point, seed;

    point = vec3(tile_uv, time * 0.02);
    seed = vec3(floor(1.0 + iTime * 0.));


    switch(int(tile_id.x))
    {
        case 0:
            return noise_perlin(point.x, seed.x);
        case 1:
            return noise_perlin(point.xy, seed.xy);
        case 2:
            return noise_perlin(point.xyz, seed.xyz);
    }
}

float test_noise_voronoi(vec2 uv, float time)
{
    vec2 tile_id;
    vec2 tile_uv = uv_tilling(uv, tile_id, vec2(4.0, 1.0));

    vec3 noise, point, seed, id, center, strength;

    point = vec3(tile_uv, time * 0.02);
    seed = vec3(floor(1.0 + iTime * 0.));
    strength = vec3(sin(iTime * 0.5) * .5 + .5);


    switch(int(tile_id.x))
    {
        case 0:
            return noise_voronoi(point.x, seed.x, id.x, center.x, strength.x);
        case 1:
            return noise_voronoi(point.xy, seed.xy, id.xy, center.xy, strength.xy);
        case 2:
            return noise_voronoi(point.xyz, seed.xyz, id.xyz, center.xyz, strength.xyz);
    }
}

float test_noise_voronoi_edge(vec2 uv, float time)
{
    vec2 tile_id;
    vec2 tile_uv = uv_tilling(uv, tile_id, vec2(4.0, 1.0));

    vec3 point, seed, id, center, strength;
    float dist;

    point = vec3(tile_uv, time * 0.02);
    seed = vec3(floor(1.0 + iTime * 0.));
    strength = vec3(sin(iTime * 0.5) * .5 + .5);


    switch(int(tile_id.x))
    {
        case 1:
            return noise_voronoi_edge(point.xy, seed.xy, id.xy, center.xy, dist, strength.xy);
        case 2:
            return noise_voronoi_edge(point.xyz, seed.xyz, id.xyz, center.xyz, dist, strength.xyz);
    }
}


vec3 test_noise(vec2 uv, float time)
{
    vec2 tile_id;
    vec2 tile_uv = uv_tilling(uv, tile_id, vec2(1.0, 4.0));

    switch(int(tile_id.y))
    {
        case 0:
            return vec3(test_noise_value(tile_uv, time));
        case 1:
            return vec3(test_noise_perlin(tile_uv, time));
        case 2:
            return vec3(test_noise_voronoi(tile_uv, time));
        case 3:
            return vec3(test_noise_voronoi_edge(tile_uv, time));
    }
}

#endif
