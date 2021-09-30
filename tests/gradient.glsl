#include "../lib/uv.glsl"
#include "../lib/gradient.glsl"

void main()
{
    vec2 uv, uvRatio;
    UVProvide(gl_FragCoord.xy, iResolution.xy, uv, uvRatio);

    vec2 tileUV, tileId;
    UVTile(uv, vec2(2.0, 2.0), tileUV, tileId);

    vec3 result;


    if (tileId.y < 1.0)
    {
        if (tileId.x < 1.0)
            GradientSpiral(tileUV - vec2(0.5), 0.0, result.x);

        else if (tileId.x < 2.0)
            GradientDirection(tileUV - vec2(0.5), vec2(0.25), result.y);
    }

    else if (tileId.y < 2.0)
    {
        if (tileId.x < 1.0)
            result = vec3(0.0);

        else if (tileId.x < 2.0)
            GradientPoints(tileUV, vec2(0.5), vec2(0.75), result.z);
    }


    gl_FragColor = vec4(result, 1.0);
}