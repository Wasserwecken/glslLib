#include "../lib/uv.glsl"
#include "../lib/easing.glsl"

void main()
{
    vec2 uv, uvRatio;
    UVProvide(gl_FragCoord.xy, iResolution.xy, uv, uvRatio);

    vec2 tileUV, tileId;
    UVTile(uv, vec2(2.0, 3.0), tileUV, tileId);

    vec3 result;
    if (tileId.x < 1.0 && tileId.y < 1.0)
        result = vec3(
            easing_expo_in(tileUV.x),
            easing_expo_out(tileUV.x),
            easing_expo_inout(tileUV.x)
        );

    else if (tileId.x < 2.0 && tileId.y < 1.0)
        result = vec3(
            easing_power_in(tileUV.x, 3.0),
            easing_power_out(tileUV.x, 3.0),
            easing_power_inout(tileUV.x, 3.0)
        );

    else if (tileId.x < 1.0 && tileId.y < 2.0)
        result = vec3(
            easing_sinus_in(tileUV.x),
            easing_sinus_out(tileUV.x),
            easing_sinus_inout(tileUV.x)
        );

    else if (tileId.x < 2.0 && tileId.y < 2.0)
        result = vec3(
            easing_circular_in(tileUV.x),
            easing_circular_out(tileUV.x),
            easing_circular_inout(tileUV.x)
        );

    else if (tileId.x < 1.0 && tileId.y < 3.0)
        result = vec3(
            easing_smooth(tileUV.x, 1),
            easing_smooth(tileUV.x, 3),
            easing_smooth(tileUV.x, 5)
        );

    gl_FragColor = vec4(step(vec3(tileUV.y), result), 1.0);
}