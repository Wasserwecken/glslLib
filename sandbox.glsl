#include "./lib/uv.glsl"


void main()
{
    vec2 uv, uvRatio;
    uv_provide(gl_FragCoord.xy, iResolution.xy, uv, uvRatio);


    vec3 result = vec3(0.0);


	gl_FragColor = vec4(result, 1.0);
}