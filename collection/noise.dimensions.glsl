#include "noise.glsl"
#include "noise.fbm.glsl"


#ifndef NOISE_DIM
#define NOISE_DIM



// 2D value
vec2 noise_value_vec2(float point, float seed, float smoothness)
{
    return vec2(
        noise_value(point, seed++, smoothness),
        noise_value(point, seed, smoothness)
    );
}

vec2 noise_value_vec2(vec2 point, vec2 seed, float smoothness)
{
    return vec2(
        noise_value(point, seed++, smoothness),
        noise_value(point, seed, smoothness)
    );
}

vec2 noise_value_vec2(vec3 point, vec3 seed, float smoothness)
{
    return vec2(
        noise_value(point, seed++, smoothness),
        noise_value(point, seed++, smoothness)
    );
}

// 3D value
vec3 noise_value_vec3(float point, float seed, float smoothness)
{
    return vec3(
        noise_value(point, seed++, smoothness),
        noise_value(point, seed++, smoothness),
        noise_value(point, seed, smoothness)
    );
}

vec3 noise_value_vec3(vec2 point, vec2 seed, float smoothness)
{
    return vec3(
        noise_value(point, seed++, smoothness),
        noise_value(point, seed++, smoothness),
        noise_value(point, seed, smoothness)
    );
}

vec3 noise_value_vec3(vec3 point, vec3 seed, float smoothness)
{
    return vec3(
        noise_value(point, seed++, smoothness),
        noise_value(point, seed++, smoothness),
        noise_value(point, seed, smoothness)
    );
}



// 2D perlin
vec2 noise_perlin_vec2(float point, float seed)
{
    return vec2(
        noise_perlin(point, seed++),
        noise_perlin(point, seed)
    );
}

vec2 noise_perlin_vec2(vec2 point, vec2 seed)
{
    return vec2(
        noise_perlin(point, seed++),
        noise_perlin(point, seed)
    );
}

vec2 noise_perlin_vec2(vec3 point, vec3 seed)
{
    return vec2(
        noise_perlin(point, seed++),
        noise_perlin(point, seed)
    );
}

// 3D perlin
vec3 noise_perlin_vec3(float point, float seed)
{
    return vec3(
        noise_perlin(point, seed++),
        noise_perlin(point, seed++),
        noise_perlin(point, seed)
    );
}

vec3 noise_perlin_vec3(vec2 point, vec2 seed)
{
    return vec3(
        noise_perlin(point, seed++),
        noise_perlin(point, seed++),
        noise_perlin(point, seed)
    );
}

vec3 noise_perlin_vec3(vec3 point, vec3 seed)
{
    return vec3(
        noise_perlin(point, seed++),
        noise_perlin(point, seed++),
        noise_perlin(point, seed)
    );
}



// 2D voronoi
vec2 noise_voronoi_vec2(float point, float seed, out float cell_id, out float center_id, float strength)
{
    return vec2(
        noise_voronoi(point, seed++, cell_id, center_id, strength),
        noise_voronoi(point, seed++, cell_id, center_id, strength)
    );
}

vec2 noise_voronoi_vec2(vec2 point, vec2 seed, out vec2 cell_id, out vec2 center_id, vec2 strength)
{
    return vec2(
        noise_voronoi(point, seed++, cell_id, center_id, strength),
        noise_voronoi(point, seed++, cell_id, center_id, strength)
    );
}

vec2 noise_voronoi_vec2(vec3 point, vec3 seed, out vec3 cell_id, out vec3 center_id, vec3 strength)
{
    return vec2(
        noise_voronoi(point, seed++, cell_id, center_id, strength),
        noise_voronoi(point, seed++, cell_id, center_id, strength)
    );
}

// 3D voronoi
vec3 noise_voronoi_vec3(float point, float seed, out float cell_id, out float center_id, float strength)
{
    return vec3(
        noise_voronoi(point, seed++, cell_id, center_id, strength),
        noise_voronoi(point, seed++, cell_id, center_id, strength),
        noise_voronoi(point, seed++, cell_id, center_id, strength)
    );
}

vec3 noise_voronoi_vec3(vec2 point, vec2 seed, out vec2 cell_id, out vec2 center_id, vec2 strength)
{
    return vec3(
        noise_voronoi(point, seed++, cell_id, center_id, strength),
        noise_voronoi(point, seed++, cell_id, center_id, strength),
        noise_voronoi(point, seed++, cell_id, center_id, strength)
    );
}

vec3 noise_voronoi_vec3(vec3 point, vec3 seed, out vec3 cell_id, out vec3 center_id, vec3 strength)
{
    return vec3(
        noise_voronoi(point, seed++, cell_id, center_id, strength),
        noise_voronoi(point, seed++, cell_id, center_id, strength),
        noise_voronoi(point, seed++, cell_id, center_id, strength)
    );
}






// 2D value layered
vec2 noise_value_vec2(float point, float seed, float smoothness, int layers, float gain, float scale)
{
    return vec2(
        noise_value(point, seed++, smoothness, layers, gain, scale),
        noise_value(point, seed++, smoothness, layers, gain, scale)
    );
}

vec2 noise_value_vec2(vec2 point, vec2 seed, float smoothness, int layers, float gain, float scale)
{
    return vec2(
        noise_value(point, seed++, smoothness, layers, gain, scale),
        noise_value(point, seed++, smoothness, layers, gain, scale)
    );
}

vec2 noise_value_vec2(vec3 point, vec3 seed, float smoothness, int layers, float gain, float scale)
{
    return vec2(
        noise_value(point, seed++, smoothness, layers, gain, scale),
        noise_value(point, seed++, smoothness, layers, gain, scale)
    );
}

// 3D value layered
vec3 noise_value_vec3(float point, float seed, float smoothness, int layers, float gain, float scale)
{
    return vec3(
        noise_value(point, seed++, smoothness, layers, gain, scale),
        noise_value(point, seed++, smoothness, layers, gain, scale),
        noise_value(point, seed++, smoothness, layers, gain, scale)
    );
}

vec3 noise_value_vec3(vec2 point, vec2 seed, float smoothness, int layers, float gain, float scale)
{
    return vec3(
        noise_value(point, seed++, smoothness, layers, gain, scale),
        noise_value(point, seed++, smoothness, layers, gain, scale),
        noise_value(point, seed++, smoothness, layers, gain, scale)
    );
}

vec3 noise_value_vec3(vec3 point, vec3 seed, float smoothness, int layers, float gain, float scale)
{
    return vec3(
        noise_value(point, seed++, smoothness, layers, gain, scale),
        noise_value(point, seed++, smoothness, layers, gain, scale),
        noise_value(point, seed++, smoothness, layers, gain, scale)
    );
}



// 2D perlin layered
vec2 noise_perlin_vec2(float point, float seed, int layers, float gain, float scale)
{
    return vec2(
        noise_perlin(point, seed++, layers, gain, scale),
        noise_perlin(point, seed++, layers, gain, scale)
    );
}

vec2 noise_perlin_vec2(vec2 point, vec2 seed, int layers, float gain, float scale)
{
    return vec2(
        noise_perlin(point, seed++, layers, gain, scale),
        noise_perlin(point, seed++, layers, gain, scale)
    );
}

vec2 noise_perlin_vec2(vec3 point, vec3 seed, int layers, float gain, float scale)
{
    return vec2(
        noise_perlin(point, seed++, layers, gain, scale),
        noise_perlin(point, seed++, layers, gain, scale)
    );
}

// 3D perlin layered
vec3 noise_perlin_vec3(float point, float seed, int layers, float gain, float scale)
{
    return vec3(
        noise_perlin(point, seed++, layers, gain, scale),
        noise_perlin(point, seed++, layers, gain, scale),
        noise_perlin(point, seed++, layers, gain, scale)
    );
}

vec3 noise_perlin_vec3(vec2 point, vec2 seed, int layers, float gain, float scale)
{
    return vec3(
        noise_perlin(point, seed++, layers, gain, scale),
        noise_perlin(point, seed++, layers, gain, scale),
        noise_perlin(point, seed++, layers, gain, scale)
    );
}

vec3 noise_perlin_vec3(vec3 point, vec3 seed, int layers, float gain, float scale)
{
    return vec3(
        noise_perlin(point, seed++, layers, gain, scale),
        noise_perlin(point, seed++, layers, gain, scale),
        noise_perlin(point, seed++, layers, gain, scale)
    );
}



// 2D voronoi layered
vec2 noise_voronoi_vec2(float point, float seed, out float cell_id, out float center_id, float strength, int layers, float gain, float scale)
{
    return vec2(
        noise_voronoi(point, seed++, cell_id, center_id, strength, layers, gain, scale),
        noise_voronoi(point, seed++, cell_id, center_id, strength, layers, gain, scale)
    );
}

vec2 noise_voronoi_vec2(vec2 point, vec2 seed, out vec2 cell_id, out vec2 center_id, vec2 strength, int layers, float gain, float scale)
{
    return vec2(
        noise_voronoi(point, seed++, cell_id, center_id, strength, layers, gain, scale),
        noise_voronoi(point, seed++, cell_id, center_id, strength, layers, gain, scale)
    );
}

vec2 noise_voronoi_vec2(vec3 point, vec3 seed, out vec3 cell_id, out vec3 center_id, vec3 strength, int layers, float gain, float scale)
{
    return vec2(
        noise_voronoi(point, seed++, cell_id, center_id, strength, layers, gain, scale),
        noise_voronoi(point, seed++, cell_id, center_id, strength, layers, gain, scale)
    );
}

// 3D voronoi layered
vec3 noise_voronoi_vec3(float point, float seed, out float cell_id, out float center_id, float strength, int layers, float gain, float scale)
{
    return vec3(
        noise_voronoi(point, seed++, cell_id, center_id, strength, layers, gain, scale),
        noise_voronoi(point, seed++, cell_id, center_id, strength, layers, gain, scale),
        noise_voronoi(point, seed++, cell_id, center_id, strength, layers, gain, scale)
    );
}

vec3 noise_voronoi_vec3(vec2 point, vec2 seed, out vec2 cell_id, out vec2 center_id, vec2 strength, int layers, float gain, float scale)
{
    return vec3(
        noise_voronoi(point, seed++, cell_id, center_id, strength, layers, gain, scale),
        noise_voronoi(point, seed++, cell_id, center_id, strength, layers, gain, scale),
        noise_voronoi(point, seed++, cell_id, center_id, strength, layers, gain, scale)
    );
}

vec3 noise_voronoi_vec3(vec3 point, vec3 seed, out vec3 cell_id, out vec3 center_id, vec3 strength, int layers, float gain, float scale)
{
    return vec3(
        noise_voronoi(point, seed++, cell_id, center_id, strength, layers, gain, scale),
        noise_voronoi(point, seed++, cell_id, center_id, strength, layers, gain, scale),
        noise_voronoi(point, seed++, cell_id, center_id, strength, layers, gain, scale)
    );
}

#endif
