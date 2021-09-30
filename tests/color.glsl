#include "../lib/uv.glsl"
#include "../lib/color.glsl"

#iChannel0 "./media/@lopezrobin.jpg"


void main()
{
    vec2 uv, uvRatio;
    UVProvide(gl_FragCoord.xy, iResolution.xy, uv, uvRatio);
    
    vec2 tileUV, tileId;
    UVTile(uv, vec2(5.0, 5.0), tileUV, tileId); 
    
    UVFill(uv, uvRatio, uv);
    vec3 picColor = texture(iChannel0, uv).xyz;



    vec3 result = vec3(0.0);
    vec3 picHsv = color_rgb_to_hsv(picColor);
    vec3 picRestored = color_hsv_to_rgb(picHsv);


    if (tileId.x < 1.0)
        result.xyz = picColor;

    else if (tileId.x < 2.0)
        result.xyz = vec3(picHsv.x, 0.0, 0.0);

    else if (tileId.x < 3.0)
        result.xyz = vec3(0.0, picHsv.y, 0.0);

    else if (tileId.x < 4.0)
        result.xyz = vec3(0.0, 0.0, picHsv.z);

    else if (tileId.x < 5.0)
        result.xyz = abs(picColor - picRestored) * 100.0;



	gl_FragColor = vec4(result, 1.0);
}