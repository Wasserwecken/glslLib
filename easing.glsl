#include "constants.glsl"

#ifndef EASING
#define EASING


//////////////////////////////
// Easing (http://gizma.com/easing/)
//////////////////////////////
float easing_smooth(float x, int order)
{
    switch(order)
    {
        case 1:
            return x*x * (x * -2.0 + 3.0);
        case 2:
            return x*x*x * (x * (x*6.0 -15.0) +10.0);
        case 3:
            return x*x*x*x * (x* (x* (x*-20.0 +70.0) -84.0) +35.0);
        case 4:
            return x*x*x*x*x * (x* (x* (x* (x*70.0 -315.0) +540.0) -420.0) +126.0);
        case 5:
            return x*x*x*x*x*x * (x* (x* (x* (x* (x*-252.0 +1386.0) -3080.0) +3465.0) -1980.0) +462.0);
        
        default:
            return x;
    }
}

float easing_power_in(float x, float power)
{
    return pow(x, power);
}

float easing_power_out(float x, float power)
{
    return 1.0 - easing_power_in(1.0 - x, power);
}

float easing_power_inout(float x, float power)
{
    x *= 2.0;
    float is_in = step(x, 1.0);

    float ease_in = easing_power_in(x, power);
    ease_in *= is_in;

    float ease_out = easing_power_out(x - 1.0, power);
    ease_out += 1.0;
    ease_out *= 1.0 - is_in;

    return (ease_in + ease_out) * 0.5;
}

float easing_circular_in(float x)
{
    x = clamp(x, 0.0, 1.0);
    return 1.0 - sqrt(1.0 - x*x);
}

float easing_circular_out(float x)
{
    return 1.0 - easing_circular_in(1.0 - x);
}

float easing_circular_inout(float x)
{
    x *= 2.0;
    float is_in = step(x, 1.0);

    float ease_in = easing_circular_in(x);
    ease_in *= is_in;

    float ease_out = easing_circular_out(x - 1.0);
    ease_out += 1.0;
    ease_out *= 1.0 - is_in;

    return (ease_in + ease_out) * 0.5;
}

float easing_sinus_out(float x)
{
    return sin(x * PI05);
}

float easing_sinus_in(float x)
{
    return 1.0 - easing_sinus_out(1.0 - x);
}

float easing_sinus_inout(float x)
{
    return sin(x * PI - PI05) * 0.5 + 0.5;
}

float easing_expo_in(float x)
{
    return pow(2.0, 10.0 * (x - 1.0));
}

float easing_expo_out(float x)
{
    return 1.0 - easing_expo_in(1.0 - x);
    return -pow(2.0, -10.0 * x) + 1.0;
}

float easing_expo_inout(float x)
{
    x *= 2.0;
    float is_in = step(x, 1.0);

    float ease_in = easing_expo_in(x);
    ease_in *= is_in;

    float ease_out = easing_expo_out(x - 1.0);
    ease_out += 1.0;
    ease_out *= 1.0 - is_in;

    return (ease_in + ease_out) * 0.5;
}



//------------------------------------------------------
//------------------------------------------------------
//      DIMENSION EXTENSIONS
//------------------------------------------------------
//------------------------------------------------------
vec2 easing_smooth(vec2 x, ivec2 order)
{
    return vec2(
        easing_smooth(x.x, order.x),
        easing_smooth(x.y, order.y)
    );
}
vec3 easing_smooth(vec3 x, ivec3 order)
{
    return vec3(
        easing_smooth(x.x, order.x),
        easing_smooth(x.y, order.y),
        easing_smooth(x.z, order.z)
    );
}

vec2 easing_power_in(vec2 x, vec2 power)
{
    return vec2(
        easing_power_in(x.x, power.x),
        easing_power_in(x.y, power.y)
    );
}

vec3 easing_power_in(vec3 x, vec3 power)
{
    return vec3(
        easing_power_in(x.x, power.x),
        easing_power_in(x.y, power.y),
        easing_power_in(x.z, power.z)
    );
}

vec2 easing_power_out(vec2 x, vec2 power)
{
    return vec2(
        easing_power_out(x.x, power.x),
        easing_power_out(x.y, power.y)
    );
}

vec3 easing_power_out(vec3 x, vec3 power)
{
    return vec3(
        easing_power_out(x.x, power.x),
        easing_power_out(x.y, power.y),
        easing_power_out(x.z, power.z)
    );
}

vec2 easing_power_inout(vec2 x, vec2 power)
{
    return vec2(
        easing_power_inout(x.x, power.x),
        easing_power_inout(x.y, power.y)
    );
}

vec3 easing_power_inout(vec3 x, vec3 power)
{
    return vec3(
        easing_power_inout(x.x, power.x),
        easing_power_inout(x.y, power.y),
        easing_power_inout(x.z, power.z)
    );
}

vec2 easing_circular_in(vec2 x)
{
    return vec2(
        easing_circular_in(x.x),
        easing_circular_in(x.y)
    );
}

vec3 easing_circular_in(vec3 x)
{
    return vec3(
        easing_circular_in(x.x),
        easing_circular_in(x.y),
        easing_circular_in(x.z)
    );
}

vec2 easing_circular_out(vec2 x)
{
    return vec2(
        easing_circular_out(x.x),
        easing_circular_out(x.y)
    );
}

vec3 easing_circular_out(vec3 x)
{
    return vec3(
        easing_circular_out(x.x),
        easing_circular_out(x.y),
        easing_circular_out(x.z)
    );
}

vec2 easing_circular_inout(vec2 x)
{
    return vec2(
        easing_circular_inout(x.x),
        easing_circular_inout(x.y)
    );
}

vec3 easing_circular_inout(vec3 x)
{
    return vec3(
        easing_circular_inout(x.x),
        easing_circular_inout(x.y),
        easing_circular_inout(x.z)
    );
}

vec2 easing_sinus_in(vec2 x)
{
    return vec2(
        easing_sinus_in(x.x),
        easing_sinus_in(x.y)
    );
}

vec3 easing_sinus_in(vec3 x)
{
    return vec3(
        easing_sinus_in(x.x),
        easing_sinus_in(x.y),
        easing_sinus_in(x.z)
    );
}

vec2 easing_sinus_out(vec2 x)
{
    return vec2(
        easing_sinus_out(x.x),
        easing_sinus_out(x.y)
    );
}

vec3 easing_sinus_out(vec3 x)
{
    return vec3(
        easing_sinus_out(x.x),
        easing_sinus_out(x.y),
        easing_sinus_out(x.z)
    );
}

vec2 easing_sinus_inout(vec2 x)
{
    return vec2(
        easing_sinus_inout(x.x),
        easing_sinus_inout(x.y)
    );
}

vec3 easing_sinus_inout(vec3 x)
{
    return vec3(
        easing_sinus_inout(x.x),
        easing_sinus_inout(x.y),
        easing_sinus_inout(x.z)
    );
}

vec2 easing_expo_in(vec2 x)
{
    return vec2(
        easing_expo_in(x.x),
        easing_expo_in(x.y)
    );
}

vec3 easing_expo_in(vec3 x)
{
    return vec3(
        easing_expo_in(x.x),
        easing_expo_in(x.y),
        easing_expo_in(x.z)
    );
}

vec2 easing_expo_out(vec2 x)
{
    return vec2(
        easing_expo_out(x.x),
        easing_expo_out(x.y)
    );
}

vec3 easing_expo_out(vec3 x)
{
    return vec3(
        easing_expo_out(x.x),
        easing_expo_out(x.y),
        easing_expo_out(x.z)
    );
}

vec2 easing_expo_inout(vec2 x)
{
    return vec2(
        easing_expo_inout(x.x),
        easing_expo_inout(x.y)
    );
}

vec3 easing_expo_inout(vec3 x)
{
    return vec3(
        easing_expo_inout(x.x),
        easing_expo_inout(x.y),
        easing_expo_inout(x.z)
    );
}


#endif
