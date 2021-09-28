#include "../lib/uv.glsl"
void main()
{
    vec2 uv, uvRatio;
    uv_provide(gl_FragCoord.xy, iResolution.xy, uv, uvRatio);

    vec2 tileUV, tileId;
    uv_tile(uv, vec2(3.0, 3.0), tileUV, tileId);
    uv_fit(tileUV, uvRatio, tileUV);


    vec2 result;
    if (tileId.x < 1.0 && tileId.y < 1.0)
    {
        uv_rotate(tileUV, vec2(0.5), 33.33, result);
    }
    else if (tileId.x < 2.0 && tileId.y < 1.0)
    {
        uv_to_polar(tileUV, vec2(0.5), result);
    }
    else if (tileId.x < 3.0 && tileId.y < 1.0)
    {
        uv_tile(tileUV, vec2(4.0), result, tileId);
    }


    else if (tileId.x < 1.0 && tileId.y < 2.0)
    {
        uv_distort_spherize(tileUV, vec2(0.5), 10.0, result);
    }
    else if (tileId.x < 2.0 && tileId.y < 2.0)
    {
        float distortion = sin(tileUV.x * 20.0);
        float strength = cos(tileUV.y * 20.0);
        uv_distort_twirl(tileUV, distortion, vec2(0.1), strength, result);
    }
    else if (tileId.x < 3.0 && tileId.y < 2.0)
    {
        uv_tile(tileUV, vec2(4.0), result, tileId);
        uv_tile_offset(result, tileId, 0.5, 2.0, result, tileId);
    }


    else if (tileId.x < 1.0 && tileId.y < 3.0)
    {
        result = tileUV;
    }
    else if (tileId.x < 2.0 && tileId.y < 3.0)
    {
        uv_tile(uv, vec2(3.0, 3.0), tileUV, tileId);
        uv_fill(tileUV, uvRatio, result);
        result = fract(result);
    }
    else if (tileId.x < 3.0 && tileId.y < 3.0)
    {
        uv_tile(uv, vec2(3.0, 3.0), tileUV, tileId);
        uv_fit(tileUV, uvRatio, result);
        result = fract(result);
    }


	gl_FragColor = vec4(result, 0.0, 1.0);
}