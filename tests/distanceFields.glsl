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
        shape = df_2D_circle(tileUV, origin, size);

    else if (tileId.x == 0.0 && tileId.y == 1.0)
        shape = df_2D_box(tileUV, origin, vec2(size));
    
    else if (tileId.x == 1.0 && tileId.y == 0.0)
        shape = df_2D_box_rounded(tileUV, origin, vec2(size), vec4(0.1));
    
    else if (tileId.x == 1.0 && tileId.y == 1.0)
        shape = df_2D_ngon(tileUV, origin, size, 5.0);


    vec3 result = mix(
        vec3(0.2, 0.2, 0.2),
        vec3(0.6, 0.3, 0.0),
        step(shape, 0.2)
    ) - sin(shape * 300.0) * 0.05;


	gl_FragColor = vec4(vec3(result), 1.0);
}