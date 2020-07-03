#include "../lib/uv.glsl"
#include "../lib/distanceFields.glsl"

vec3 test_distanceFields(vec2 uv, float time)
{
    vec2 tile_id;
    vec2 tile_uv = uv_tilling(uv, tile_id, vec2(2.0, 2.0));
    int row = int(tile_id.y);
    int column = int(tile_id.x);

    float result;
    float size = 0.1;
    vec4 edge_radius = vec4(0.05);
    vec2 origin = vec2(0.5);

        
    if (row == 0 && column == 0)
        result = df_circle(tile_uv, origin, size);

    if (row == 0 && column == 1)
        result = df_box(tile_uv, origin, vec2(size));
    
    if (row == 1 && column == 0)
        result = df_box_rounded(tile_uv, origin, vec2(size), edge_radius);
    
    if (row == 1 && column == 1)
        result = df_ngon(tile_uv, origin, size, 5.0);

    return vec3(result) * 2.0;
}