#include "../lib/uv.glsl"
#include "../lib/color.glsl"

#iChannel0 "./media/@lopezrobin.jpg"


void main()
{
    vec2 uv, uvRatio;
    uv_provide(gl_FragCoord.xy, iResolution.xy, uv, uvRatio);
    uv_fill(uv, uvRatio, uv);



	gl_FragColor = vec4(result, 1.0);
}