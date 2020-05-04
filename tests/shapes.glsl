#include "../shapes.glsl"


#ifndef SHAPE_TESTS
#define SHAPE_TESTS

vec3 test_shapes(vec2 uv, float time)
{
    float result;
    float size = 0.25;
    float blur = 0.1;
    float edge_radius = 0.05;
    vec2 origin = vec2(0.5);

    result = shape_spiral(uv, origin, 0.0);
    result = shape_gradient_direction(uv, origin, vec2(1.0));
    result = shape_gradient_points(uv, vec2(0.0), vec2(1.0));
    result = shape_circle(uv, origin, size, blur);
    result = shape_rectangle(uv, origin, vec2(size), vec2(blur));
    result = shape_rectangle_rounded(uv, origin, vec2(size), blur, edge_radius);
    result = shape_ngon(uv, origin, size, 5.0, 0.1, blur);

    return vec3(result);
}

#endif