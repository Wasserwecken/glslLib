#include "./lib/random.glsl"
#include "./lib/noise.glsl"
#include "./lib/noise.fbm.glsl"
#include "./lib/noise.dimensions.glsl"
#include "./lib/shapes.glsl"
#include "./lib/easing.glsl"
#include "./lib/uv.glsl"


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


float noise_complex(vec2 point, vec2 seed)
{
    float result = 1.0;
    for(int i = 0; i < 3; i++)
    {
        float n = noise_perlin(point, seed++);
        n = noise_vallies(n);
        result = min(result, n);
    }

    return easing_power_out(result, 3.0);
}


void main() {
    vec2 uv = provide_uv_interactive();
    float time = iTime;
    vec3 result;


    float noise = noise_complex(uv * 0.3, vec2(33.33));
    result = vec3(noise);


	gl_FragColor = vec4(result, 1.0);
}