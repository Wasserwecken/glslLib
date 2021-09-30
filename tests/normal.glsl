#include "../lib/uv.glsl"
#include "../lib/color.glsl"
#include "../lib/helper.glsl"

#iChannel0 "./blur.h.glsl"


void main()
{
    vec2 uv, uvRatio;
    UVProvide(gl_FragCoord.xy, iResolution.xy, uv, uvRatio);
    
    vec2 tileUV, tileId;
    UVTile(uv, vec2(4.0, 1.0), tileUV, tileId); 

    vec3 result, hsv, normalTexture, normalDerivative;
    ColorRgbToHsv(texture(iChannel0, uv).xyz, hsv);

    result = vec3(hsv.z);

    if (tileId.x > 0.0)
    {
        if (tileId.x < 2.0)
        {
            NormalFromHeightTexture(iChannel0, uv, 1.0, 0.1, normalTexture);
            result = normalTexture;
        }

        else if (tileId.x < 3.0)
        {
            NormalFromHeightDerivative(hsv.z, 0.1, normalDerivative);
            result = normalDerivative;
        }

        else if (tileId.x < 4.0)
        {
            result = abs(normalTexture - normalDerivative);
        }
    }


	gl_FragColor = vec4(result, 1.0);
}