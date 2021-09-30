#include "../lib/uv.glsl"
#include "../lib/easing.glsl"

void main()
{
    vec2 uv, uvRatio;
    UVProvide(gl_FragCoord.xy, iResolution.xy, uv, uvRatio);

    vec2 tileUV, tileId;
    UVTile(uv, vec2(2.0, 3.0), tileUV, tileId);

    vec3 result;
    if (tileId.y < 1.0)
    {
        if (tileId.x < 1.0)
        {
            EasingExpoIn(tileUV.x, result.x);
            EasingExpoOut(tileUV.x, result.y);
            EasingExpoInOut(tileUV.x, result.z);
        }
        else if (tileId.x < 2.0)
        {
            EasingPowerIn(tileUV.x, 3.0, result.x);
            EasingPowerOut(tileUV.x, 3.0, result.y);
            EasingPowerInOut(tileUV.x, 3.0, result.z);
        }
    }
    else if (tileId.y < 2.0)
    {
        if (tileId.x < 1.0)
        {
            EasingSinusIn(tileUV.x, result.x);
            EasingSinusOut(tileUV.x, result.y);
            EasingSinusInOut(tileUV.x, result.z);
        }
        else if (tileId.x < 2.0)
        {
            EasingCircularIn(tileUV.x, result.x);
            EasingCircularOut(tileUV.x, result.y);
            EasingCircularInOut(tileUV.x, result.z);
        }
    }
    else if (tileId.y < 3.0)
    {
        if (tileId.x < 1.0)
        {
            EasingSmooth(tileUV.x, 1, result.x);
            EasingSmooth(tileUV.x, 3, result.y);
            EasingSmooth(tileUV.x, 5, result.z);
        }
        else if (tileId.x < 2.0)
        {
        }
    }

    gl_FragColor = vec4(step(vec3(tileUV.y), result), 1.0);
}