#include "./constants.glsl"

#ifndef EASING
#define EASING


//////////////////////////////
// Easing (http://gizma.com/easing/)
//////////////////////////////
void EasingSmooth(float x, int order, out float result)
{
    switch(order)
    {
        case 1:
            result = x*x * (x * -2.0 + 3.0);
            break;
        case 2:
            result = x*x*x * (x * (x*6.0 -15.0) +10.0);
            break;
        case 3:
            result = x*x*x*x * (x* (x* (x*-20.0 +70.0) -84.0) +35.0);
            break;
        case 4:
            result = x*x*x*x*x * (x* (x* (x* (x*70.0 -315.0) +540.0) -420.0) +126.0);
            break;
        case 5:
            result = x*x*x*x*x*x * (x* (x* (x* (x* (x*-252.0 +1386.0) -3080.0) +3465.0) -1980.0) +462.0);
            break;
        
        default:
            result = x;
            break;
    }
}

void EasingPowerIn(float x, float power, out float result)
{
    result = pow(x, power);
}

void EasingPowerOut(float x, float power, out float result)
{
    EasingPowerIn(1.0 - x, power, result);
    result = 1.0 - result;
}

void EasingPowerInOut(float x, float power, out float result)
{
    x *= 2.0;
    float is_in = step(x, 1.0);

    float ease_in;
    EasingPowerIn(x, power, ease_in);
    ease_in *= is_in;

    float ease_out;
    EasingPowerOut(x - 1.0, power, ease_out);
    ease_out += 1.0;
    ease_out *= 1.0 - is_in;

    result = (ease_in + ease_out) * 0.5;
}

void EasingCircularIn(float x, out float result)
{
    x = clamp(x, 0.0, 1.0);
    result = 1.0 - sqrt(1.0 - x*x);
}

void EasingCircularOut(float x, out float result)
{
    EasingCircularIn(1.0 - x, result);
    result = 1.0 - result;
}

void EasingCircularInOut(float x, out float result)
{
    x *= 2.0;
    float is_in = step(x, 1.0);

    float ease_in;
    EasingCircularIn(x, ease_in);
    ease_in *= is_in;

    float ease_out;
    EasingCircularOut(x - 1.0, ease_out);
    ease_out += 1.0;
    ease_out *= 1.0 - is_in;

    result = (ease_in + ease_out) * 0.5;
}

void EasingSinusOut(float x, out float result)
{
    result = sin(x * PI05);
}

void EasingSinusIn(float x, out float result)
{
    EasingSinusOut(1.0 - x, result);
    result =  1.0 - result;
}

void EasingSinusInOut(float x, out float result)
{
    result =  sin(x * PI - PI05) * 0.5 + 0.5;
}

void EasingExpoIn(float x, out float result)
{
    result =  pow(2.0, 10.0 * (x - 1.0));
}

void EasingExpoOut(float x, out float result)
{
    EasingExpoIn(1.0 - x, result);
    result =  1.0 - result;
}

void EasingExpoInOut(float x, out float result)
{
    x *= 2.0;
    float is_in = step(x, 1.0);

    float ease_in;
    EasingExpoIn(x, ease_in);
    ease_in *= is_in;

    float ease_out;
    EasingExpoOut(x - 1.0, ease_out);
    ease_out += 1.0;
    ease_out *= 1.0 - is_in;

    result = (ease_in + ease_out) * 0.5;
}


#endif
