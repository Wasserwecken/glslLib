#include "../lib/uv.glsl"
#include "../lib/random.glsl"

void main()
{
    vec2 uv, uvRatio;
    UVProvide(gl_FragCoord.xy, iResolution.xy, uv, uvRatio);

    vec2 tileUV, tileId;
    UVTile(uv, vec2(2.0, 2.0), tileUV, tileId);
    UVFill(tileUV, uvRatio, tileUV);
    

    vec3 result[128];
    vec2 seed = tileId + iTime * 0.0;

    if (tileId.y < 1.0)
    {
        if (tileId.x < 1.0)
        {
            for (int i = 0; i < 128; i++)
                result[i].xy = random_in_circle(seed + 1.0 / float(i)) * 0.25;
        }
        else if (tileId.x < 2.0)
        {
            for (int i = 0; i < 128; i++)
                result[i].xy = random_on_circle(seed + 1.0 / float(i)) * 0.25;
        }
    }
    
    else if (tileId.y < 2.0)
    {
        if (tileId.x < 1.0)
        {
            for (int i = 0; i < 128; i++)
                result[i] = random_in_sphere(vec3(seed + 1.0 / float(i), 1.0)) * 0.25;
        }
        else if (tileId.x < 2.0)
        {
            for (int i = 0; i < 128; i++)
                result[i] = random_on_sphere(vec3(seed + 1.0 / float(i), 1.0)) * 0.25;
        }
    }


    vec3 color = vec3(0.0);
    for (int i = 0; i < 128; i++)
    {
        if (distance(result[i].xy + vec2(0.5), tileUV) < 0.01)
        {
            color = vec3(1.0);
            break;
        }
    }

	gl_FragColor = vec4(vec3(color), 1.0);
}