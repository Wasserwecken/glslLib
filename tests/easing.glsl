#include "../easing.glsl"


#ifndef EASING_TESTS
#define EASING_TESTS



vec3 test_easing(vec2 uv, float time)
{
    float t = uv.x;
    vec3 result;

    result.x = easing_smooth(t, 1);
    result.y = easing_smooth(t, 2);
    result.z = easing_smooth(t, 3);

    result.x = easing_power_in(t, 3.0);
    result.y = easing_power_out(t, 3.0);
    result.z = easing_power_inout(t, 3.0);
    
    result.x = easing_circular_in(t);
    result.y = easing_circular_out(t);
    result.z = easing_circular_inout(t);

    result.x = easing_sinus_in(t);
    result.y = easing_sinus_out(t);
    result.z = easing_sinus_inout(t);

    result.x = easing_expo_in(t);
    result.y = easing_expo_out(t);
    result.z = easing_expo_inout(t);


    return step(vec3(uv.y), result);
}


#endif