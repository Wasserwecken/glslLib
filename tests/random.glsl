#include "../lib/uv.glsl"
#include "../lib/random.glsl"

void main()
{
    vec2 uv, uvRatio;
    UVProvide(gl_FragCoord.xy, iResolution.xy, uv, uvRatio);

    vec2 tileUV, tileId;
    UVTile(uv, vec2(3.0, 2.0), tileUV, tileId);
    UVFill(tileUV, uvRatio, tileUV);
    

    vec3 point = vec3(tileUV, 0.5);
    vec3 seed = vec3(floor(1.0 + iTime * 0.));
    float scale = mix (0.0001, 1000.0, sin(iTime * 0.0001) * 0.5 + 0.5);
    float result;


    if (tileId.x < 1.0 && tileId.y < 1.0)
    {
        result = random(point.x);
    }    
    else if (tileId.x < 2.0 && tileId.y < 1.0)
    {
        result = random(point.xy);
    }   
    else if (tileId.x < 3.0 && tileId.y < 1.0)
    {
        result = random(point.xyz);
    }    
    
    
    else if (tileId.x < 1.0 && tileId.y < 2.0)
    {
        result = random(point.x * scale);
    }    
    else if (tileId.x < 2.0 && tileId.y < 2.0)
    {
        result = random(point.xy * scale);
    }   
    else if (tileId.x < 3.0 && tileId.y < 2.0)
    {
        result = random(point.xyz * scale);
    }


	gl_FragColor = vec4(vec3(result), 1.0);
}