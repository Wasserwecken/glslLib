#include "./lib/random.glsl"
#include "./lib/noise.glsl"
#include "./lib/noise.fbm.glsl"
#include "./lib/noise.dimensions.glsl"
#include "./lib/shapes.glsl"
#include "./lib/easing.glsl"
#include "./lib/uv.glsl"



float g(vec2 uv)
{
    return 2.0 * max(abs(uv.x), abs(uv.y));
}


float h(vec2 uv)
{
    uv = 2.0 * abs(uv);
    if (uv.x < uv.y)
        uv = uv.yx;

    float z = 0.0;
    vec2 o = vec2(7.0, 0.0);

    z = distance(o, uv);
    z = pow(z, 2.0);
    z = -0.5 * z + 10.0;

    return z;
}

float f(vec2 uv)
{
    return max(g(uv), h(uv));
}

void main() {
    vec2 uv = (uv_provide() - vec2(0.5)) * 10.0;
    vec2 seed = vec2(33.33);


    float val = f(uv);






    vec3 result = vec3(val / 10.0);
    //result = vec3(fract(uv), 0.0);


    result = vec3(length(uv));
    

	gl_FragColor = vec4(result, 1.0);
}