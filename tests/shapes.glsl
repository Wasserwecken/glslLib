#include "../lib/uv.glsl"
#include "../lib/shapes.glsl"

vec3 test_shapes(vec2 uv, float time)
{
    vec2 tile_id;
    vec2 tile_uv = uv_tilling(uv, tile_id, vec2(2.0, 2.0));
    int row = int(tile_id.y);
    int column = int(tile_id.x);

    float result;
    float size = 0.3;
    float blur = 0.1;
    vec4 edge_radius = vec4(0.05);
    vec2 origin = vec2(0.5);

        
    if (row == 0 && column == 0)
        result = shape_circle(tile_uv, origin, size, blur);
    
    if (row == 0 && column == 1)
        result = shape_line(tile_uv, vec2(0.2), vec2(0.8), blur);
    
    if (row == 1 && column == 0)
        result = shape_box_rounded(tile_uv, origin, vec2(size), blur, edge_radius);
    
    if (row == 1 && column == 1)
        result = shape_ngon(tile_uv, origin, size, 5.0, blur);

    return vec3(result);
}