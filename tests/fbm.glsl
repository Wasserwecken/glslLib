#include "../lib/uv.glsl"
#include "../lib/noise.fbm.glsl"


void main()
{
    vec2 uv, uvRatio;
    UVProvide(gl_FragCoord.xy, iResolution.xy, uv, uvRatio);

    vec2 tileUV, tileId;
    UVTile(uv, vec2(3.0, 4.0), tileUV, tileId);
    UVFill(tileUV, uvRatio, tileUV);

    vec3 point, seed, id, center, strength;
    int depth;
    float noise, smoothness, gain, scale, dist;

    point = vec3(tileUV, iTime * 0.02);
    seed = vec3(floor(1.0 + iTime * 0.));
    strength = vec3(sin(iTime * 0.5) * .5 + .5);
    smoothness = sin(iTime * 0.5) + 1.0;

    depth = 3;
    gain = 0.5;
    scale = 2.0;


    if (tileId.x < 1.0 && tileId.y < 1.0)
    {
        noise = noise_value(point.x, seed.x, smoothness, depth, gain, scale);
    }    
    else if (tileId.x < 2.0 && tileId.y < 1.0)
    {
        noise = noise_value(point.xy, seed.xy, smoothness, depth, gain, scale);
    }   
    else if (tileId.x < 3.0 && tileId.y < 1.0)
    {
        noise = noise_value(point.xyz, seed.xyz, smoothness, depth, gain, scale);
    }


    else if (tileId.x < 1.0 && tileId.y < 2.0)
    {
        noise = noise_perlin(point.x, seed.x, depth, gain, scale);
    }    
    else if (tileId.x < 2.0 && tileId.y < 2.0)
    {
        noise = noise_perlin(point.xy, seed.xy, depth, gain, scale);
    }   
    else if (tileId.x < 3.0 && tileId.y < 2.0)
    {
        noise = noise_perlin(point.xyz, seed.xyz, depth, gain, scale);
    }


    else if (tileId.x < 1.0 && tileId.y < 3.0)
    {
        noise = noise_voronoi(point.x, seed.x, id.x, center.x, strength.x, depth, gain, scale);
    }    
    else if (tileId.x < 2.0 && tileId.y < 3.0)
    {
        noise = noise_voronoi(point.xy, seed.xy, id.xy, center.xy, strength.xy, depth, gain, scale);
    }   
    else if (tileId.x < 3.0 && tileId.y < 3.0)
    {
        noise = noise_voronoi(point.xyz, seed.xyz, id.xyz, center.xyz, strength.xyz, depth, gain, scale);
    }


    else if (tileId.x < 1.0 && tileId.y < 4.0)
    {
        noise = noise_voronoi(point.xy, seed.xy, id.xy, center.xy, strength.xy, depth, gain, scale);
    }    
    else if (tileId.x < 2.0 && tileId.y < 4.0)
    {
        noise = noise_voronoi_edge(point.xy, seed.xy, id.xy, center.xy, dist, strength.xy, depth, gain, scale);
    }   
    else if (tileId.x < 3.0 && tileId.y < 4.0)
    {
        noise = noise_voronoi_edge(point.xyz, seed.xyz, id.xyz, center.xyz, dist, strength.xyz, depth, gain, scale);
    }

	gl_FragColor = vec4(vec3(noise), 1.0);
}
