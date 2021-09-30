#include "../lib/uv.glsl"
#include "../lib/color.glsl"
#include "../lib/constants.glsl"
#include "../lib/tonemapping.glsl"



void main()
{
    vec2 uv, uvRatio;
    UVProvide(gl_FragCoord.xy, iResolution.xy, uv, uvRatio);
    
    vec2 tileUV, tileId;
    UVTile(uv, vec2(7.0, 1.0), tileUV, tileId);

    vec3 result = vec3(0.0);
    vec3 color = 8.0 * vec3(tileUV.y) * ColorHsvToRgb(vec3(tileUV.x, 1.0, 1.0));

    if (tileId.x < 1.0)
    {
        color = ToneAces(color);
        ColorGamma(color, GAMMAADD, color);
    }
    else if (tileId.x < 2.0)
    {
        color = ToneFilmic(color);
        ColorGamma(color, GAMMAADD, color);
    }
    else if (tileId.x < 3.0)
    {
        color = ToneLottes(color);
        ColorGamma(color, GAMMAADD, color);
    }
    else if (tileId.x < 4.0)
    {
        color = ToneReinhard2(color, 5.0);
        ColorGamma(color, GAMMAADD, color);
    }
    else if (tileId.x < 5.0)
    {
        color = ToneUchimura(color);
        ColorGamma(color, GAMMAADD, color);
    }
    else if (tileId.x < 6.0)
    {
        color = ToneUncharted2(color);
        ColorGamma(color, GAMMAADD, color);
    }
    else if (tileId.x < 7.0)
    {
        color = ToneUnreal(color);
    }

	gl_FragColor = vec4(color, 1.0);
}