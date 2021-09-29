#include "../lib/uv.glsl"
#include "../lib/blur.glsl"

#iChannel0 "./blur.h.glsl"


void main()
{
    vec2 uv, uvRatio;
    uv_provide(gl_FragCoord.xy, iResolution.xy, uv, uvRatio);

    vec3 result;
    GaussianBlur2Pass(uv, iChannel0, 2.0, 0.0, 5, NORMALDIST4, result);

	gl_FragColor = vec4(result, 1.0);
}