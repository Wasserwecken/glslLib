#include "/lib/constants.glsl"
#include "/lib/helper.glsl"
#include "/lib/easing.glsl"
#include "/lib/shapes.glsl"
#include "/lib/noise.glsl"
#include "/lib/uv.glsl"
#include "/lib/color.glsl"


vec2 provide_uv()
{
    vec2 uv = gl_FragCoord.xy / iResolution.y;
    float offset = (1.0 - (iResolution.x / iResolution.y)) * 0.5;

    return uv + vec2(offset, 0.0);
}

vec2 provide_uv_interactive()
{
    vec2 uv = gl_FragCoord.xy / iResolution.y;
    uv = uv * 2.0 - 1.0;
    
    vec2 mouse = iMouse.xy / iResolution.y;
    uv *= mouse.y;

    return uv;
}



void main() {
    vec2 uv = provide_uv();
    vec3 result = vec3(1.0, 0.0, 1.0);

    //...

	gl_FragColor = vec4(result, 1.0);
}