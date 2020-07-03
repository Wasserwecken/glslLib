#include "../lib/uv.glsl"

vec3 test_uv(vec2 uv, float time)
{
    vec2 tile_id;
    vec2 tile_uv = uv_tilling(uv, tile_id, vec2(3.0, 3.0));
    int row = int(tile_id.y);
    int column = int(tile_id.x);

    vec2 result;

    if (row == 0 && column == 0)
        result = uv_rotate(tile_uv, vec2(0.5), 33.33);

    if (row == 0 && column == 1)
        result = uv_to_polar(tile_uv, vec2(0.5));


    if (row == 1 && column == 0)
    {
        vec2 test_id;
        result = uv_tilling(tile_uv, test_id, vec2(5.0));
    }

    if (row == 1 && column == 1)
    {
        vec2 test_id;
        uv_tilling(tile_uv, test_id, vec2(5.0));
        
        result = 1.0 / (1.0 + test_id);
    }

    if (row == 1 && column == 2)
    {
        vec2 test_id;
        vec2 test_uv = uv_tilling(tile_uv, test_id, vec2(5.0));
        test_uv = uv_tilling_tile_offset(test_uv, test_id, 0.5, 1.0);

        result = test_uv;
    }


    if (row == 2 && column == 0)
    {
        float distortion = sin(tile_uv.x * 20.0);
        float strength = cos(tile_uv.y * 20.0);
        result = uv_distort_twirl(tile_uv, distortion, vec2(0.1), strength);
    }
    
    if (row == 2 && column == 1)
        result = uv_distort_spherize(tile_uv, vec2(0.5), 100.0);


    return vec3(result, 0.0);
}