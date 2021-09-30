#include "../lib/uv.glsl"
#include "../lib/distanceFields.glsl"
#include "../lib/distribution.glsl"


void main()
{
    vec2 uv, uvRatio;
    UVProvide(gl_FragCoord.xy, iResolution.xy, uv, uvRatio);
    
    vec2 tileUV, tileId;
    UVTile(uv, vec2(2.0, 2.0), tileUV, tileId);
    UVFit(tileUV, uvRatio, tileUV);



    vec3 result = vec3(0.0);

    if (tileId.y < 1.0)
    {
        if (tileId.x < 1.0)
        {
            float samples = 128.0;
            for (float i = 0.0; i < samples; i++)
            {
                vec2 vogelPoint;
                VogelDiskPoint(i, samples, iTime * 0.2, vogelPoint);

                if (distance(tileUV - vec2(0.5), vogelPoint / 2.0) < 0.01)
                {
                    result = vec3(1.0);
                    break;
                }
            }
        }

        else if (tileId.x < 2.0)
        {            
            float samples = 128.0;
            for (float i = 0.0; i < samples; i++)
            {
                float angle = (cos(iTime * 0.5) * 0.5 + 0.5) * PI;
                vec3 vogelPoint;
                VogelConePoint(i, samples, iTime * 0.2, angle, vogelPoint);

                if (distance(tileUV - vec2(0.5), vogelPoint.xy * 0.5) < 0.01)
                {
                    result = vec3(1.0);
                    break;
                }
            }
        }
    }    
    
    else if (tileId.y < 2.0)
    {
        if (tileId.x < 1.0)
        {
            float samples = 128.0;
            for (float i = 0.0; i < samples; i++)
            {
                vec3 vogelPoint;
                VogelSpherePoint(i, samples, iTime * 0.2, vogelPoint);

                if (distance(tileUV - vec2(0.5), vogelPoint.xy * 0.5) < 0.01)
                {
                    result = vec3(1.0);
                    break;
                }
            }
        }

        else if (tileId.x < 2.0)
        {
            
            float samples = 128.0;
            for (float i = 0.0; i < samples; i++)
            {
                float angle = (cos(iTime * 0.5) * 0.5 + 0.5) * PI;
                vec3 vogelPoint;
                VogelHemispherePoint(i, samples, iTime * 0.2, angle, vogelPoint);

                if (distance(tileUV - vec2(0.5), vogelPoint.xy * 0.5) < 0.01)
                {
                    result = vec3(1.0);
                    break;
                }
            }
        }
    }


    
    result = mix(
        vec3(0.2, 0.2, 0.2),
        vec3(0.6, 0.3, 0.0),
        step(vec3(0.2), result)
    );



	gl_FragColor = vec4(result, 1.0);
}