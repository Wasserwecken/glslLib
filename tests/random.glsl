#include "../collection/uv.glsl"
#include "../collection/random.glsl"

vec3 test_random(vec2 uv, float time)
{
    vec2 tile_id;
    vec2 tile_uv = uv_tilling(uv, tile_id, vec2(3.0, 3.0));
    int row = int(tile_id.y);
    int column = int(tile_id.x);

    vec3 point = vec3(tile_uv, time * 0.02);
    vec3 seed = vec3(floor(1.0 + iTime * 0.));
    float minScale = 0.0001;
    float maxScale = 1000.0;

    if (row == 0 && column == 0)
        return vec3(random(point.x * minScale));

    if (row == 0 && column == 1)
        return vec3(random(point.xy * minScale));

    if (row == 0 && column == 2)
        return vec3(random(point.xyz * minScale));


    if (row == 1 && column == 0)
        return vec3(random(point.x));

    if (row == 1 && column == 1)
        return vec3(random(point.xy));

    if (row == 1 && column == 2)
        return vec3(random(point.xyz));


    if (row == 2 && column == 0)
        return vec3(random(point.x * maxScale));

    if (row == 2 && column == 1)
        return vec3(random(point.xy * maxScale));

    if (row == 2 && column == 2)
        return vec3(random(point.xyz * maxScale));
}