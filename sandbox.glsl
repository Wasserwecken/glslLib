#include "./lib/random.glsl"
#include "./lib/noise.glsl"
#include "./lib/noise.fbm.glsl"
#include "./lib/noise.dimensions.glsl"
#include "./lib/shapes.glsl"
#include "./lib/easing.glsl"
#include "./lib/uv.glsl"


float g(float x, float y)
{
    float z = 0.0;

    z = PI * x / y;
    z = 1.0 + cos(z);
    z = y * z;

    return z;
}


float h(float x, float y)
{
    return 0.0;
}


float f(float x, float y)
{
    if (abs(y) > abs(x))
        return g(x,y);
    else
        return h(x,y);
}


void main() {
    vec2 uv = uv_provide() - vec2(0.5);
    vec2 seed = vec2(33.33);


    float val = f(uv.x ,uv.y);
    
    val = abs(val);
    vec3 result = vec3(val);
	gl_FragColor = vec4(result, 1.0);
}