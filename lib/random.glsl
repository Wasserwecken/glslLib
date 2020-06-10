

#ifndef RANDOM
#define RANDOM


const float WHITE_NOISE_SCALE = 5461.5461;


//https://www.shadertoy.com/view/4djSRW
float random(float p)
{
    p *= WHITE_NOISE_SCALE;
    p = fract(p * .1031);
    p *= p + 33.33;
    p *= p + p;
    return fract(p);
}

float random(vec2 p)
{
    p *= WHITE_NOISE_SCALE;
	vec3 p3  = fract(vec3(p.xyx) * .1031);
    p3 += dot(p3, p3.yzx + 33.33);
    return fract((p3.x + p3.y) * p3.z);
}

float random(vec3 p)
{
    p *= WHITE_NOISE_SCALE;
	p  = fract(p * .1031);
    p += dot(p, p.yzx + 33.33);
    return fract((p.x + p.y) * p.z);
}

vec2 random_vec2(float p)
{
    p *= WHITE_NOISE_SCALE;
	vec3 p3 = fract(vec3(p) * vec3(.1031, .1030, .0973));
	p3 += dot(p3, p3.yzx + 33.33);
    return fract((p3.xx+p3.yz)*p3.zy);

}

vec2 random_vec2(vec2 p)
{
    p *= WHITE_NOISE_SCALE;
	vec3 p3 = fract(vec3(p.xyx) * vec3(.1031, .1030, .0973));
    p3 += dot(p3, p3.yzx+33.33);
    return fract((p3.xx+p3.yz)*p3.zy);

}

vec2 random_vec2(vec3 p)
{
    p *= WHITE_NOISE_SCALE;
	p = fract(p * vec3(.1031, .1030, .0973));
    p += dot(p, p.yzx+33.33);
    return fract((p.xx+p.yz)*p.zy);
}

vec3 random_vec3(float p)
{
    p *= WHITE_NOISE_SCALE;
   vec3 p3 = fract(vec3(p) * vec3(.1031, .1030, .0973));
   p3 += dot(p3, p3.yzx+33.33);
   return fract((p3.xxy+p3.yzz)*p3.zyx); 
}

vec3 random_vec3(vec2 p)
{
    p *= WHITE_NOISE_SCALE;
	vec3 p3 = fract(vec3(p.xyx) * vec3(.1031, .1030, .0973));
    p3 += dot(p3, p3.yxz+33.33);
    return fract((p3.xxy+p3.yzz)*p3.zyx);
}

vec3 random_vec3(vec3 p)
{
    p *= WHITE_NOISE_SCALE;
	p = fract(p * vec3(.1031, .1030, .0973));
    p += dot(p, p.yxz+33.33);
    return fract((p.xxy + p.yxx)*p.zyx);
}


#endif