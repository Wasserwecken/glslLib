#include "../lib/uv.glsl"
#include "../lib/noise.glsl"


void main()
{
    vec2 uv, uvRatio;
    uv_provide(gl_FragCoord.xy, iResolution.xy, uv, uvRatio);

    vec2 tileUV, tileId;
    uv_tile(uv, vec2(3.0, 4.0), tileUV, tileId);
    uv_fill(tileUV, uvRatio, tileUV);

    vec3 point, seed, id, center, strength;
    float smoothness, noise, dist;

    point = vec3(tileUV, iTime * 0.02);
    seed = vec3(floor(1.0 + iTime * 0.));
    smoothness = sin(iTime * 0.5) + 1.0;
    strength = vec3(sin(iTime * 0.5) * .5 + .5);


    if (tileId.x < 1.0 && tileId.y < 1.0)
    {
        noise = noise_value(point.x, seed.x, smoothness);
    }    
    else if (tileId.x < 2.0 && tileId.y < 1.0)
    {
        noise = noise_value(point.xy, seed.xy, smoothness);
    }   
    else if (tileId.x < 3.0 && tileId.y < 1.0)
    {
        noise = noise_value(point.xyz, seed.xyz, smoothness);
    }


    else if (tileId.x < 1.0 && tileId.y < 2.0)
    {
        noise = noise_perlin(point.x, seed.x);
    }    
    else if (tileId.x < 2.0 && tileId.y < 2.0)
    {
        noise = noise_perlin(point.xy, seed.xy);
    }   
    else if (tileId.x < 3.0 && tileId.y < 2.0)
    {
        noise = noise_perlin(point.xyz, seed.xyz);
    }


    else if (tileId.x < 1.0 && tileId.y < 3.0)
    {
        noise = noise_voronoi(point.x, seed.x, id.x, center.x, strength.x);
    }    
    else if (tileId.x < 2.0 && tileId.y < 3.0)
    {
        noise = noise_voronoi(point.xy, seed.xy, id.xy, center.xy, strength.xy);
    }   
    else if (tileId.x < 3.0 && tileId.y < 3.0)
    {
        noise = noise_voronoi(point.xyz, seed.xyz, id.xyz, center.xyz, strength.xyz);
    }


    else if (tileId.x < 1.0 && tileId.y < 4.0)
    {
        noise = 0.0;
    }    
    else if (tileId.x < 2.0 && tileId.y < 4.0)
    {
        noise = noise_voronoi_edge(point.xy, seed.xy, id.xy, center.xy, dist, strength.xy);
    }   
    else if (tileId.x < 3.0 && tileId.y < 4.0)
    {
        noise = noise_voronoi_edge(point.xyz, seed.xyz, id.xyz, center.xyz, dist, strength.xyz);
    }


	gl_FragColor = vec4(vec3(noise), 1.0);
}