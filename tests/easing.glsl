#include "../collection/easing.glsl"

vec3 test_easing(vec2 uv, float time)
{
    vec2 tile_id;
    vec2 tile_uv = uv_tilling(uv, tile_id, vec2(3.0, 3.0));
    int row = int(tile_id.y);
    int column = int(tile_id.x);

    float value = tile_uv.x;
    vec3 result;

    if (row == 0 && column == 0)
        result = vec3(
            easing_smooth(value, 1),
            easing_smooth(value, 3),
            easing_smooth(value, 5)
        );

    if (row == 0 && column == 1)
        result = vec3(
            easing_power_in(value, 3.0),
            easing_power_out(value, 3.0),
            easing_power_inout(value, 3.0)
        );

    if (row == 0 && column == 2)
        result = vec3(
            easing_circular_in(value),
            easing_circular_out(value),
            easing_circular_inout(value)
        );

    if (row == 1 && column == 0)
        result = vec3(
            easing_sinus_in(value),
            easing_sinus_out(value),
            easing_sinus_inout(value)
        );

    if (row == 1 && column == 1)
        result = vec3(
            easing_expo_in(value),
            easing_expo_out(value),
            easing_expo_inout(value)
        );


    return step(vec3(tile_uv.y), result);
}