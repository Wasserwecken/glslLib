#include "../lib/constants.glsl"
#include "../lib/camera.glsl"
#include "../lib/distanceFields.glsl"
#include "../lib/shading.glsl"



float scene_distance(vec3 point)
{
    float box = df_box(point, vec3(0.0), vec3(1.0), 0.05);
    //return box;

    float sphere = df_sphere(point, vec3(0.0), 1.3);
    float scene = max(box, -sphere);
    //return scene;

    float plane = df_plane(point, vec3_zero, vec3_up);
    scene = min(scene, plane);

    return scene;
}

vec3 scene_normal(vec3 point, float sample_delta)
{
    vec2 dir = vec2(1,-1);
    return normalize(
        dir.xyy * scene_distance(point + dir.xyy * sample_delta) + 
        dir.yyx * scene_distance(point + dir.yyx * sample_delta) + 
        dir.yxy * scene_distance(point + dir.yxy * sample_delta) + 
        dir.xxx * scene_distance(point + dir.xxx * sample_delta)
    );
}

vec2 scene_uv(vec3 point, vec3 normal)
{
    normal = abs(normal);
    vec3 main_axis = step(normal.yxx, normal.xyz) * step(normal.zzy, normal.xyz);
        
    vec2 uv_x = vec2(point.y, point.z) * main_axis.x;
    vec2 uv_y = vec2(point.x, point.z) * main_axis.y;
    vec2 uv_z = vec2(point.x, point.y) * main_axis.z;

    return uv_x + uv_y + uv_z;
}

float scene_shadow(vec3 normal, vec3 ray_origin, vec3 ray_direction, float hit_distance, float trace_length, float penumbra)
{    
    vec3 point = ray_origin + normal * hit_distance * 2.0;
    float current_length = 0.0;
    float current_distance = hit_distance + 1.0;
    float shadow = 1.0;

    while(current_length < trace_length)
    {
        if (current_distance < hit_distance)
            return 0.0;

        current_distance = scene_distance(point);
        point += ray_direction * current_distance;
        current_length += current_distance;
        shadow = min(shadow, penumbra * current_distance / current_length);
    }

    return shadow;
}

void scene_shading(
    vec3 point,
    vec3 normal,
    vec3 in_direction,
    vec3 in_color,
    out vec3 out_direction,
    out vec3 out_color)
{
    vec3 albedo = vec3(1.0);// vec3(fract(uv * 5.0), 0.0);

    BRDF_phong(
        point,
        normal,
        in_direction, in_color,
        out_direction, out_color,
        albedo,
        albedo,
        128.0
    );
}


vec3 sphere_tracer(
    vec3 ray_origin, vec3 ray_direction,
    int max_steps, float hit_distance, float trace_length)
{    
    vec3 point = ray_origin;
    float current_length = 0.0;
    float current_distance = hit_distance + 1.0;
    int steps = 0;

    while(current_distance > hit_distance
        && steps < max_steps
        && current_length < trace_length)
    {
        current_distance = scene_distance(point);
        point += ray_direction * current_distance;
        current_length += current_distance;
        steps ++;
    }

    if (current_distance < hit_distance)
    {
        vec3 normal = scene_normal(point, 0.001);
        vec2 uv = scene_uv(point, normal);
        
        vec3 light_positions[3] = vec3[](
            vec3(0.25, 0.5, -1.0) * 5.0,
            vec3(-1.0, 0.5, -1.0) * 5.0,
            vec3(0.0, 0.05, 1.0) * 5.0
        );
        vec3 light_colors[3]  = vec3[](
            vec3(50.0),
            vec3(25.0),
            vec3(1.0)
        );

        vec3 surface_color;
        vec3 reflection_direction;

        for(int i = 0; i < light_positions.length(); i++)
        {
            vec3 light_direction = normalize(point - light_positions[i]);
            float light_distance = length(light_positions[i] - point);
            vec3 in_direction = normalize(light_direction + ray_direction);
            vec3 in_color = light_colors[i] * (1.0 / pow(1.0 + light_distance, 2.0));
            vec3 out_direction, out_color;

            scene_shading(point, normal, in_direction, in_color, out_direction, out_color);
            out_color *= scene_shadow(normal, point, -light_direction, hit_distance, light_distance, 64.0);
            
            surface_color += out_color;
            reflection_direction += out_direction;
        }

        reflection_direction = normalize(reflection_direction);
        return surface_color;
    }
    else return vec3(0.0);
}


void main()
{
    vec2 mouse = ((iMouse.xy / iResolution.y) - vec2(0.0, 0.5)) * 10.0;
    
    vec3 ray_origin;
    vec3 ray_direction;
    vec3 camera_position = vec3(sin(mouse.x), 0.4, cos(mouse.x)) * 4.0;
    vec3 camera_direction = normalize(vec3_zero - camera_position);

    camera_ray(
        vec2(iResolution),
        vec2(gl_FragCoord),
        ray_origin, ray_direction,
        camera_position, camera_direction, 50.0
    );

    vec3 result = sphere_tracer(
        ray_origin, ray_direction,
        200, 0.001, 50.0
    );

    result = camera_gamma_correction(result);
	gl_FragColor = vec4(result, 1.0);
}