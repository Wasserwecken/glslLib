#include "../noise.glsl"
#include "../noise.fbm.glsl"
#include "../noise.dimensions.glsl"


#ifndef NOISE_TESTS
#define NOISE_TESTS


vec3 test_noise_value(vec2 uv, float time)
{
    vec3 noise, point, seed;
    int depth;
    float smoothness, gain, scale;

    point = vec3(uv, time * 0.02);
    seed = vec3(floor(1.0 + iTime * 0.));
    smoothness = sin(iTime * 0.5) + 1.0;

    depth = 3;
    gain = 0.5;
    scale = 2.0;


    // 1D
    noise.x = noise_value(point.x, seed.x, smoothness);
    noise.x = noise_value(point.xy, seed.xy, smoothness);
    noise.x = noise_value(point.xyz, seed.xyz, smoothness);
    noise = vec3(noise.x);
    
    // 1D FBM
    noise.x = noise_value(point.x, seed.x, smoothness, depth, gain, scale);
    noise.x = noise_value(point.xy, seed.xy, smoothness, depth, gain, scale);
    noise.x = noise_value(point.xyz, seed.xyz, smoothness, depth, gain, scale);
    noise = vec3(noise.x);


    return noise;
}

vec3 test_noise_perlin(vec2 uv, float time)
{
    vec3 noise, point, seed;
    int depth;
    float gain, scale;

    point = vec3(uv, time * 0.02);
    seed = vec3(floor(1.0 + iTime * 0.));

    depth = 3;
    gain = 0.5;
    scale = 2.0;


    // 1D
    noise.x = noise_perlin(point.x, seed.x);
    noise.x = noise_perlin(point.xy, seed.xy);
    noise.x = noise_perlin(point.xyz, seed.xyz);
    noise = vec3(noise.x);
    
    // 1D FBM
    noise.x = noise_perlin(point.x, seed.x, depth, gain, scale);
    noise.x = noise_perlin(point.xy, seed.xy, depth, gain, scale);
    noise.x = noise_perlin(point.xyz, seed.xyz, depth, gain, scale);
    noise = vec3(noise.x);


    return noise;
}

vec3 test_noise_voronoi(vec2 uv, float time)
{
    vec3 noise, point, seed, id, center, strength;
    int depth;
    float gain, scale;

    point = vec3(uv, time * 0.02);
    seed = vec3(floor(1.0 + iTime * 0.));
    strength = vec3(sin(iTime * 0.5) * .5 + .5);

    depth = 3;
    gain = 0.5;
    scale = 2.0;


    // 1D
    noise.x = noise_voronoi(point.x, seed.x, id.x, center.x, strength.x);
    noise.x = noise_voronoi(point.xy, seed.xy, id.xy, center.xy, strength.xy);
    noise.x = noise_voronoi(point.xyz, seed.xyz, id.xyz, center.xyz, strength.xyz);
    noise = vec3(noise.x);
    
    // 1D FBM
    noise.x = noise_voronoi(point.x, seed.x, id.x, center.x, strength.x, depth, gain, scale);
    noise.x = noise_voronoi(point.xy, seed.xy, id.xy, center.xy, strength.xy, depth, gain, scale);
    noise.x = noise_voronoi(point.xyz, seed.xyz, id.xyz, center.xyz, strength.xyz, depth, gain, scale);
    noise = vec3(noise.x);

    return noise;
}

vec3 test_noise_voronoi_edge(vec2 uv, float time)
{
    vec3 noise, point, seed, id, center, strength;
    int depth;
    float gain, scale, dist;

    point = vec3(uv, time * 0.02);
    seed = vec3(floor(1.0 + iTime * 0.));
    strength = vec3(sin(iTime * 0.5) * .5 + .5);

    depth = 3;
    gain = 0.5;
    scale = 2.0;


    // 1D
    noise.x = noise_voronoi_edge(point.xy, seed.xy, id.xy, center.xy, dist, strength.xy);
    noise.x = noise_voronoi_edge(point.xyz, seed.xyz, id.xyz, center.xyz, dist, strength.xyz);
    noise = vec3(noise.x);
 
    // 1D FBM
    noise.x = noise_voronoi_edge(point.xy, seed.xy, id.xy, center.xy, dist, strength.xy, depth, gain, scale);
    noise.x = noise_voronoi_edge(point.xyz, seed.xyz, id.xyz, center.xyz, dist, strength.xyz, depth, gain, scale);
    noise = vec3(noise.x);


    return noise;
}

#endif
