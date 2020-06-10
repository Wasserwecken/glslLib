#include "noise.glsl"


#ifndef NOISE_FBM
#define NOISE_FBM



float noise_value(
        float point,
        float seed,
        float smoothness,
        int layers,
        float gain,
        float scale)
{
    point *= LAYERED_SCALE;

    float result = 0.0;
    float height_sum = 0.0;
    
    float frequency = 1.0;
    float amplitude = 1.0;

    for(int layer = 0; layer < layers; layer++)
    {
        result += noise_value(point * frequency, seed++, smoothness) * amplitude;
        height_sum += amplitude;
        
        frequency *= scale;
        amplitude *= gain;
    }

    return result / height_sum;
}

float noise_value(
        vec2 point,
        vec2 seed,
        float smoothness,
        int layers,
        float gain,
        float scale)
{  
    point *= LAYERED_SCALE;

    float result = 0.0;
    float height_sum = 0.0;
    
    float frequency = 1.0;
    float amplitude = 1.0;

    for(int layer = 0; layer < layers; layer++)
    {
        result += noise_value(point * frequency, seed++, smoothness) * amplitude;
        height_sum += amplitude;
        
        frequency *= scale;
        amplitude *= gain;
    }

    return result / height_sum;
}

float noise_value(
        vec3 point,
        vec3 seed,
        float smoothness,
        int layers,
        float gain,
        float scale)
{  
    point *= LAYERED_SCALE;

    float result = 0.0;
    float height_sum = 0.0;
    
    float frequency = 1.0;
    float amplitude = 1.0;

    for(int layer = 0; layer < layers; layer++)
    {
        result += noise_value(point * frequency, seed++, smoothness) * amplitude;
        height_sum += amplitude;
        
        frequency *= scale;
        amplitude *= gain;
    }

    return result / height_sum;
}

float noise_perlin(
        float point,
        float seed,
        int layers,
        float gain,
        float scale)
{
    point *= LAYERED_SCALE;

    float result = 0.0;
    float height_sum = 0.0;
    
    float frequency = 1.0;
    float amplitude = 1.0;

    for(int layer = 0; layer < layers; layer++)
    {
        result += noise_perlin(point * frequency, seed++) * amplitude;
        height_sum += amplitude;
        
        frequency *= scale;
        amplitude *= gain;
    }

    return result / height_sum;
}

float noise_perlin(
        vec2 point,
        vec2 seed,
        int layers,
        float gain,
        float scale)
{
    point *= LAYERED_SCALE;

    float result = 0.0;
    float height_sum = 0.0;
    
    float frequency = 1.0;
    float amplitude = 1.0;

    for(int layer = 0; layer < layers; layer++)
    {
        result += noise_perlin(point * frequency, seed++) * amplitude;
        height_sum += amplitude;
        
        frequency *= scale;
        amplitude *= gain;
    }

    return result / height_sum;
}

float noise_perlin(
        vec3 point,
        vec3 seed,
        int layers,
        float gain,
        float scale)
{
    point *= LAYERED_SCALE;

    float result = 0.0;
    float height_sum = 0.0;
    
    float frequency = 1.0;
    float amplitude = 1.0;

    for(int layer = 0; layer < layers; layer++)
    {
        result += noise_perlin(point * frequency, seed++) * amplitude;
        height_sum += amplitude;
        
        frequency *= scale;
        amplitude *= gain;
    }

    return result / height_sum;
}

float noise_voronoi(
        float point,
        float seed,
        out float cell_id,
        out float center_id,
        float strength,
        int layers,
        float gain,
        float scale)
{
    point *= LAYERED_SCALE;

    float result = 0.0;
    float height_sum = 0.0;
    
    float frequency = 1.0;
    float amplitude = 1.0;

    float id;
    float center;

    for(int layer = 0; layer < layers; layer++)
    {
        result += noise_voronoi(
                point * frequency, seed++,
                id, center,
                strength
            ) * amplitude;
        
        height_sum += amplitude;
        frequency *= scale;
        amplitude *= gain;

        float digit = pow(10.0, -float(layer));
        cell_id += digit * id;
        center_id += digit * center;
    }

    return result / height_sum;
}

float noise_voronoi(
        vec2 point,
        vec2 seed,
        out vec2 cell_id,
        out vec2 center_id,
        vec2 strength,
        int layers,
        float gain,
        float scale)
{
    point *= LAYERED_SCALE;

    float result = 0.0;
    float height_sum = 0.0;
    
    float frequency = 1.0;
    float amplitude = 1.0;

    vec2 id;
    vec2 center;

    for(int layer = 0; layer < layers; layer++)
    {
        result += noise_voronoi(
                point * frequency, seed++,
                id, center,
                strength
            ) * amplitude;
        
        height_sum += amplitude;
        frequency *= scale;
        amplitude *= gain;

        float digit = pow(10.0, -float(layer));
        cell_id += digit * id;
        center_id += digit * center;
    }

    return result / height_sum;
}

float noise_voronoi(
        vec3 point,
        vec3 seed,
        out vec3 cell_id,
        out vec3 center_id,
        vec3 strength,
        int layers,
        float gain,
        float scale)
{
    point *= LAYERED_SCALE;

    float result = 0.0;
    float height_sum = 0.0;
    
    float frequency = 1.0;
    float amplitude = 1.0;

    vec3 id;
    vec3 center;

    for(int layer = 0; layer < layers; layer++)
    {
        result += noise_voronoi(
                point * frequency, seed++,
                id, center,
                strength
            ) * amplitude;
        
        height_sum += amplitude;
        frequency *= scale;
        amplitude *= gain;

        float digit = pow(10.0, -float(layer));
        cell_id += digit * id;
        center_id += digit * center;
    }

    return result / height_sum;
}

float noise_voronoi_edge(
        vec2 point,
        vec2 seed,
        out vec2 cell_id,
        out vec2 cell_center,
        out float distance_center,
        vec2 strength,
        int layers,
        float gain,
        float scale)
{
    point *= LAYERED_SCALE;

    float result = 0.0;
    float height_sum = 0.0;
    
    float frequency = 1.0;
    float amplitude = 1.0;

    vec2 id;
    vec2 center;
    float dist;

    for(int layer = 0; layer < layers; layer++)
    {
        result += noise_voronoi_edge(
                point * frequency, seed++,
                id, center, dist,
                strength
            ) * amplitude;
        cell_center += center;
        distance_center += dist * amplitude;
        
        height_sum += amplitude;
        frequency *= scale;
        amplitude *= gain;

        float digit = pow(10.0, -float(layer));
        cell_id += digit * pow(10.0, -float(layer));
    }

    cell_center /= float(layers);
    return result / height_sum;
}

float noise_voronoi_edge(
        vec3 point,
        vec3 seed,
        out vec3 cell_id,
        out vec3 cell_center,
        out float distance_center,
        vec3 strength,
        int layers,
        float gain,
        float scale)
{
    point *= LAYERED_SCALE;

    float result = 0.0;
    float height_sum = 0.0;
    
    float frequency = 1.0;
    float amplitude = 1.0;

    vec3 id;
    vec3 center;
    float dist;

    for(int layer = 0; layer < layers; layer++)
    {
        result += noise_voronoi_edge(
                point * frequency, seed++,
                id, center, dist,
                strength
            ) * amplitude;
        cell_center += center;
        distance_center += dist * amplitude;
        
        height_sum += amplitude;
        frequency *= scale;
        amplitude *= gain;

        float digit = pow(10.0, -float(layer));
        cell_id += digit * pow(10.0, -float(layer));
    }

    cell_center /= float(layers);
    return result / height_sum;
}

#endif
