#include "noise.glsl"
#include "shapes.glsl"
#include "easing.glsl"


vec2 provide_uv()
{
    vec2 uv = gl_FragCoord.xy / iResolution.y;

    return uv;
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
    float time = iTime;
    vec3 result;


    //result = test_noise_value(uv, time);
    //result = test_noise_perlin(uv, time);
    //result = test_noise_voronoi(uv, time);
    result = test_noise_voronoi_edge(uv, time);

    //result = test_shapes(uv, time);
    //result = test_easing(uv, time);


	gl_FragColor = vec4(result, 1.0);
}