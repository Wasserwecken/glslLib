#include "constants.glsl"
#include "random.glsl"
#include "helper.glsl"
#include "easing.glsl"

#ifndef NOISE
#define NOISE


const float NOISE_SCALE = 12.0;
const float LAYERED_SCALE = 1.0;



//------------------------------------------------------
//------------------------------------------------------
//      TOOLS
//------------------------------------------------------
//------------------------------------------------------
float noise_vallies(float noise)
{
    return abs(noise * 2.0 -1.0);
}

vec2 noise_vallies(vec2 noise)
{
    return abs(noise * 2.0 -1.0);
}

vec3 noise_vallies(vec3 noise)
{
    return abs(noise * 2.0 -1.0);
}

float noise_creases(float noise)
{
    return 1.0 - noise_vallies(noise);
}

vec2 noise_creases(vec2 noise)
{
    return 1.0 - noise_vallies(noise);
}

vec3 noise_creases(vec3 noise)
{
    return 1.0 - noise_vallies(noise);
}



//------------------------------------------------------
//------------------------------------------------------
//      VALUE
//------------------------------------------------------
//------------------------------------------------------
float noise_value(float point, float seed, float smoothness)
{
    point += random(seed++) - 1.0;
    point *= NOISE_SCALE;

    float corner = floor(point);
    float interpolation = easing_power_inout(fract(point), smoothness);

    float A = random(corner + 0.0 + seed);
    float B = random(corner + 1.0 + seed);

    return mix(A, B, interpolation);
}

float noise_value(vec2 point, vec2 seed, float smoothness)
{
    point += random_vec2(seed++) - 1.0;
    point *= NOISE_SCALE;
    
    vec2 corner = floor(point);
    vec2 interpolation = easing_power_inout(fract(point), vec2(smoothness));
    
    float A = random(corner + vec2(0.0, 0.0) + seed);
    float B = random(corner + vec2(1.0, 0.0) + seed);
    float C = random(corner + vec2(0.0, 1.0) + seed);
    float D = random(corner + vec2(1.0, 1.0) + seed);

    return mix(
        mix(A, B, interpolation.x),
        mix(C, D, interpolation.x),
        interpolation.y
    );
}

float noise_value(vec3 point, vec3 seed, float smoothness)
{
    point += random_vec3(seed++) - 1.0;
    point *= NOISE_SCALE;
    
    vec3 corner = floor(point);
    vec3 interpolation = easing_power_inout(fract(point), vec3(smoothness));
    
    float A = random(corner + vec3(0.0, 0.0, 0.0) + seed);
    float B = random(corner + vec3(1.0, 0.0, 0.0) + seed);
    float C = random(corner + vec3(0.0, 1.0, 0.0) + seed);
    float D = random(corner + vec3(1.0, 1.0, 0.0) + seed);
    float E = random(corner + vec3(0.0, 0.0, 1.0) + seed);
    float F = random(corner + vec3(1.0, 0.0, 1.0) + seed);
    float G = random(corner + vec3(0.0, 1.0, 1.0) + seed);
    float H = random(corner + vec3(1.0, 1.0, 1.0) + seed);

    return mix(
            mix(
                mix(A, B, interpolation.x),
                mix(C, D, interpolation.x),
                interpolation.y
            ),
            mix(
                mix(E, F, interpolation.x),
                mix(G, H, interpolation.x),
                interpolation.y
            ),
            interpolation.z
        );
}

//------------------------------------------------------
//------------------------------------------------------
//      PERLIN NOISE
//------------------------------------------------------
//------------------------------------------------------
float noise_perlin(float point, float seed)
{
    point += random(seed++) - 1.0;
    point *= NOISE_SCALE;

    float corner = floor(point);
    float A = random(corner + 0.0 + seed) * 2.0 - 1.0;
    float B = random(corner + 1.0 + seed) * 2.0 - 1.0;

    point = fract(point);
    float interpolation = easing_smooth(point, 2);

    float noise = mix(
        dot(A, point - 0.0),
        dot(B, point - 1.0),
        interpolation
    );
    
    return noise * 0.5 + 0.5;
}

float noise_perlin(vec2 point, vec2 seed)
{
    point += random_vec2(seed++) - 1.0;
    point *= NOISE_SCALE;

    vec2 corner = floor(point);
    vec2 A = random_vec2(corner + vec2(0.0, 0.0) + seed) * 2.0 - 1.0;
    vec2 B = random_vec2(corner + vec2(1.0, 0.0) + seed) * 2.0 - 1.0;
    vec2 C = random_vec2(corner + vec2(0.0, 1.0) + seed) * 2.0 - 1.0;
    vec2 D = random_vec2(corner + vec2(1.0, 1.0) + seed) * 2.0 - 1.0;

    point = fract(point);
    vec2 interpolation = easing_smooth(point, ivec2(2));

    float noise = mix(
            mix(
                dot(A, point - vec2(0.0, 0.0)),
                dot(B, point - vec2(1.0, 0.0)),
                interpolation.x
            ),
            mix(
                dot(C, point - vec2(0.0, 1.0)),
                dot(D, point - vec2(1.0, 1.0)),
                interpolation.x
            ),
            interpolation.y
    );

    return noise * 0.5 + 0.5;
}

float noise_perlin(vec3 point, vec3 seed)
{
    point += random_vec3(seed++) - 1.0;
    point *= NOISE_SCALE;

    vec3 corner = floor(point);
    vec3 A = random_vec3(corner + vec3(0.0, 0.0, 0.0) + seed) * 2.0 - 1.0;
    vec3 B = random_vec3(corner + vec3(1.0, 0.0, 0.0) + seed) * 2.0 - 1.0;
    vec3 C = random_vec3(corner + vec3(0.0, 1.0, 0.0) + seed) * 2.0 - 1.0;
    vec3 D = random_vec3(corner + vec3(1.0, 1.0, 0.0) + seed) * 2.0 - 1.0;
    vec3 E = random_vec3(corner + vec3(0.0, 0.0, 1.0) + seed) * 2.0 - 1.0;
    vec3 F = random_vec3(corner + vec3(1.0, 0.0, 1.0) + seed) * 2.0 - 1.0;
    vec3 G = random_vec3(corner + vec3(0.0, 1.0, 1.0) + seed) * 2.0 - 1.0;
    vec3 H = random_vec3(corner + vec3(1.0, 1.0, 1.0) + seed) * 2.0 - 1.0;

    point = fract(point);
    vec3 interpolation = easing_smooth(point, ivec3(2));

    float noise = mix(
        mix(
            mix(
                dot(A, point - vec3(0.0, 0.0, 0.0)),
                dot(B, point - vec3(1.0, 0.0, 0.0)),
                interpolation.x
            ),
            mix(
                dot(C, point - vec3(0.0, 1.0, 0.0)),
                dot(D, point - vec3(1.0, 1.0, 0.0)),
                interpolation.x
            ),
            interpolation.y),
        mix(
            mix(
                dot(E, point - vec3(0.0, 0.0, 1.0)),
                dot(F, point - vec3(1.0, 0.0, 1.0)),
                interpolation.x
            ),
            mix(
                dot(G, point - vec3(0.0, 1.0, 1.0)),
                dot(H, point - vec3(1.0, 1.0, 1.0)),
                interpolation.x
            ),
            interpolation.y),
        interpolation.z
    );

    return noise * 0.5 + 0.5;
}

//------------------------------------------------------
//------------------------------------------------------
//      VORONOI DISTANCE
//------------------------------------------------------
//------------------------------------------------------
float noise_voronoi(
        float point,
        float seed,
        out float cell_id,
        out float cell_center,
        float strength)
{
    point += random(seed++) - 1.0;
    point *= NOISE_SCALE;

    float tile_id = floor(point);
    float tile_pos = fract(point);

    float min_magnitude = 10.0;
    for(int x = -1; x <= 1; x++)
    {
        float offset = float(x);
        float random_point = random(tile_id + offset + seed);
        float center = offset + 0.5 + (random_point - 0.5) * strength;
        float diff_magnitude = abs(center - tile_pos);
        
        if (min_magnitude > diff_magnitude)
        {
            min_magnitude = diff_magnitude;
            cell_id = offset;
            cell_center = center;
        }
    }

    cell_id += tile_id;
    cell_center = (cell_center + tile_id) / NOISE_SCALE;

    return min_magnitude;
}

float noise_voronoi(
        vec2 point,
        vec2 seed,
        out vec2 cell_id,
        out vec2 cell_center,
        vec2 strength)
{
    point += random_vec2(seed++) - 1.0;
    point *= NOISE_SCALE;

    vec2 tile_id = floor(point);
    vec2 tile_pos = fract(point);

    float min_magnitude = 10.0;
    for(int x = -1; x <= 1; x++)
    {
        for(int y = -1; y <= 1; y++)
        {
            vec2 offset = vec2(x, y);
            vec2 random_point = random_vec2(tile_id + offset + seed);
            vec2 center = offset + 0.5 + (random_point - 0.5) * strength;
            vec2 diff = center - tile_pos;
            float diff_magnitude = dot(diff, diff);
            
            if (min_magnitude > diff_magnitude)
            {
                min_magnitude = diff_magnitude;
                cell_id = offset;
                cell_center = center;
            }
        }
    }

    cell_id += tile_id;
    cell_center = (cell_center + tile_id) / NOISE_SCALE;

    return sqrt(min_magnitude);
}

float noise_voronoi(
        vec3 point,
        vec3 seed,
        out vec3 cell_id,
        out vec3 cell_center,
        vec3 strength)
{
    point += random_vec3(seed++) - 1.0;
    point *= NOISE_SCALE;

    vec3 tile_id = floor(point);
    vec3 tile_pos = fract(point);

    float min_magnitude = 10.0;
    for(int x = -1; x <= 1; x++)
    {
        for(int y = -1; y <= 1; y++)
        {
            for(int z = -1; z <= 1; z++)
            {
                vec3 offset = vec3(x, y, z);
                vec3 random_point = random_vec3(tile_id + offset + seed);
                vec3 center = offset + 0.5 + (random_point - 0.5) * strength;
                vec3 diff = center - tile_pos;
                float diff_magnitude = dot(diff, diff);
                
                if (min_magnitude > diff_magnitude)
                {
                    min_magnitude = diff_magnitude;
                    cell_id = offset;
                    cell_center = center;
                }
            }
        }
    }

    cell_id += tile_id;
    cell_center = (cell_center + tile_id) / NOISE_SCALE;

    return pow(min_magnitude, 1.0 / 3.0);
}


//------------------------------------------------------
//------------------------------------------------------
//      VORONOI EDGE
//------------------------------------------------------
//------------------------------------------------------
//https://www.iquilezles.org/www/articles/voronoilines/voronoilines.htm
//https://www.ronja-tutorials.com/2018/09/29/voronoi-noise.html
float noise_voronoi_edge(
        vec2 point,
        vec2 seed,
        out vec2 cell_id,
        out vec2 cell_center,
        out float distance_center,
        vec2 strength)
{
    point += random_vec2(seed++) - 1.0;
    point *= NOISE_SCALE;

    vec2 tile_id = floor(point);
    vec2 tile_pos = fract(point);

    vec2 cell_offset;
    float min_magnitude = 10.0;
    for(int x = -1; x <= 1; x++)
    {
        for(int y = -1; y <= 1; y++)
        {
            vec2 offset = vec2(x, y);
            vec2 random_point = random_vec2(tile_id + offset + seed);
            vec2 center = offset + 0.5 + (random_point - 0.5) * strength;
            vec2 diff = center - tile_pos;
            float diff_magnitude = dot(diff, diff);
            
            if (min_magnitude > diff_magnitude)
            {
                min_magnitude = diff_magnitude;
                cell_center = center;
                cell_offset = offset;
            }
        }
    }

    float min_edge_dist = 10.0;
    for(int x = -2; x <= 2; x++)
    {
        for(int y = -2; y <= 2; y++)
        {
            vec2 offset = cell_offset - vec2(x, y);
            vec2 random_point = random_vec2(tile_id + offset + seed);
            vec2 other_center = offset + 0.5 + (random_point - 0.5) * strength;

            vec2 edge = (cell_center + other_center) * 0.5;
            vec2 edge_dir = normalize(other_center - cell_center);
            vec2 edge_diff = edge - tile_pos;
            float edge_dist = dot(edge_diff, edge_dir);

            min_edge_dist = min(min_edge_dist, edge_dist);
        }
    }

    cell_id = tile_id + cell_offset;
    cell_center = (cell_center + tile_id) / NOISE_SCALE;
    distance_center = sqrt(min_magnitude);

    return min_edge_dist;
}

float noise_voronoi_edge(
        vec3 point,
        vec3 seed,
        out vec3 cell_id,
        out vec3 cell_center,
        out float distance_center,
        vec3 strength)
{
    point += random_vec3(seed++) - 1.0;
    point *= NOISE_SCALE;

    vec3 tile_id = floor(point);
    vec3 tile_pos = fract(point);

    vec3 cell_offset;
    float min_magnitude = 10.0;
    for(int x = -1; x <= 1; x++)
    {
        for(int y = -1; y <= 1; y++)
        {
            for(int z = -1; z <= 1; z++)
            {
                vec3 offset = vec3(x, y, z);
                vec3 random_point = random_vec3(tile_id + offset + seed);
                vec3 center = offset + 0.5 + (random_point - 0.5) * strength;
                vec3 diff = center - tile_pos;
                float diff_magnitude = dot(diff, diff);
                
                if (min_magnitude > diff_magnitude)
                {
                    min_magnitude = diff_magnitude;
                    cell_center = center;
                    cell_offset = offset;
                }
            }
        }
    }

    float min_edge_dist = 10.0;
    for(int x = -2; x <= 2; x++)
    {
        for(int y = -2; y <= 2; y++)
        {
            for(int z = -2; z <= 2; z++)
            {
                vec3 offset = cell_offset - vec3(x, y, z);
                vec3 random_point = random_vec3(tile_id + offset + seed);
                vec3 other_center = offset + 0.5 + (random_point - 0.5) * strength;

                vec3 edge = (cell_center + other_center) * 0.5;
                vec3 edge_dir = normalize(other_center - cell_center);
                vec3 edge_diff = edge - tile_pos;
                float edge_dist = dot(edge_diff, edge_dir);

                min_edge_dist = min(min_edge_dist, edge_dist);
            }
        }
    }

    cell_id = tile_id + cell_offset;
    cell_center = (cell_center + tile_id) / NOISE_SCALE;
    distance_center = pow(min_magnitude, 1.0 / 3.0);

    return min_edge_dist;
}

//------------------------------------------------------
//------------------------------------------------------
//      VORONOI MANHATTAN
//------------------------------------------------------
//------------------------------------------------------
float noise_voronoi_manhattan(vec2 point, vec2 seed)
{
    point *= NOISE_SCALE;

    vec2 tile_id = floor(point);
    vec2 tile_pos = fract(point);

    vec2 neighbour;
    vec2 center;
    float dist = 10.0;

    for(float x = -1.0; x < 2.0; x++)
    {
        for(float y = -1.0; y < 2.0; y++)
        {
            neighbour = vec2(x, y);
            center = random_vec2(tile_id + seed + neighbour);
            dist = min(dist, value_manhatten_length(center - tile_pos + neighbour));
        }
    }

    return dist * 0.5;
}


#endif
