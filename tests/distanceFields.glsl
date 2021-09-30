#include "../lib/uv.glsl"
#include "../lib/distanceFields.glsl"


void main()
{
    vec2 uv, uvRatio;
    UVProvide(gl_FragCoord.xy, iResolution.xy, uv, uvRatio);

    vec2 tileUV, tileId;
    UVTile(uv, vec2(2.0, 2.0), tileUV, tileId);
    UVFill(tileUV, uvRatio, tileUV);

    float shape;
    vec2 origin = vec2(0.5); 
    float size = 0.0;


    if (tileId.x == 0.0 && tileId.y == 0.0)
        DF2DCircle(tileUV, origin, size, shape);

    else if (tileId.x == 0.0 && tileId.y == 1.0)
        DF2DBox(tileUV, origin, vec2(size), shape);
    
    else if (tileId.x == 1.0 && tileId.y == 0.0)
        DF2DBoxRound(tileUV, origin, vec2(size), vec4(0.1), shape);
    
    else if (tileId.x == 1.0 && tileId.y == 1.0)
        DF2DNgon(tileUV, origin, size, 5.0, shape);


    vec3 result = mix(
        vec3(0.2, 0.2, 0.2),
        vec3(0.6, 0.3, 0.0),
        step(shape, 0.2)
    ) - sin(shape * 300.0) * 0.05;


	gl_FragColor = vec4(vec3(result), 1.0);
}