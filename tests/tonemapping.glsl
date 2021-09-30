#include "../lib/uv.glsl"
#include "../lib/blur.glsl"



void main()
{
    vec2 uv, uvRatio;
    UVProvide(gl_FragCoord.xy, iResolution.xy, uv, uvRatio);


    vec3 result = vec3(0.0);

	gl_FragColor = vec4(result, 1.0);
}