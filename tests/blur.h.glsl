#include "../lib/uv.glsl"
#include "../lib/blur.glsl"

#iChannel0 "./media/@lopezrobin.jpg"


void main()
{
    vec2 uv, uvRatio;
    UVProvide(gl_FragCoord.xy, iResolution.xy, uv, uvRatio);
    UVFill(uv, uvRatio, uv);

    vec3 result;
    BlurGaussian2Pass(uv, iChannel0, 2.0, 1.0, 5, NORMALDIST2, result);


	gl_FragColor = vec4(result, 1.0);
}