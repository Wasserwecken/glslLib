#include "random.glsl"

#ifndef SHADING
#define SHADING


void BRDF_lambert(
    vec3 seed,
    vec3 normal,
    vec3 in_direction,
    vec3 in_color,
    out vec3 out_direction,
    out vec3 out_color,

    vec3 diffuse_color)
{
    float lambert = max(0.0, dot(-normal, in_direction));

    out_color = in_color * lambert * diffuse_color;
    out_direction = random_on_hemisphere(seed, normal);
}

void BRDF_phong(
    vec3 seed,
    vec3 normal,
    vec3 in_direction,
    vec3 in_color,
    out vec3 out_direction,
    out vec3 out_color,

    vec3 diffuse_color,
    vec3 specular_color,
    float specular_strength)
{
    BRDF_lambert(seed, normal,
        in_direction, in_color,
        out_direction, out_color,
        diffuse_color
    );

    float specular_angle = max(0.0, dot(-normal, in_direction));
    float specular = pow(specular_angle, specular_strength);

    out_direction = mix(reflect(in_direction, normal), out_direction, 1.0 / (1.0 + specular_strength));
    out_color += in_color * specular * specular_color;
}


// https://www.shadertoy.com/view/4ltGWl
float HenyeyGreenstein(float g, float costh)
{
    return (1.0 - g * g) / (PI4 * pow(1.0 + g * g - 2.0 * g * costh, 3.0/2.0));
}

float FresnelSchlick(float k, float costh)
{
    return (1.0 - k * k) / (PI4 * pow(1.0 - k * costh, 2.0));
}

vec3 FresnelSchlick(float nDotV, vec3 f0, float roughness)
{
    return f0 + (1.0 - f0) * pow(1.0 - nDotV, 5.0);
}

float DistributionTrowbridgeReitzGGX(float nDotH, float roughness)
{
    roughness *= roughness;
    roughness *= roughness;
    nDotH *= nDotH;

    float denom = (nDotH * (roughness - 1.0) + 1.0);
    return roughness / (PI * denom * denom);
}

float GeometrySchlickGGX(float nDotV, float roughness)
{
    float r = (roughness + 1.0);
    float k = (r*r) / 8.0;
    float denom = nDotV * (1.0 - k) + k;
	
    return nDotV / denom;
}

float GeometrySmith(float nDotV, float nDotL, float roughness)
{
    float ggxView  = GeometrySchlickGGX(nDotV, roughness);
    float ggxLight  = GeometrySchlickGGX(nDotL, roughness);
	
    return ggxView * ggxLight;
}


vec3 PBRDRDF(FragmentMaterial material, FragmentSurface surface, LightInfo light)
{            
    vec3 halfway = normalize(light.Direction + surface.ViewDirection);
    float hDv = max(0.0, dot(halfway, surface.ViewDirection));
    float nDl = max(0.0, dot(material.Normal, light.Direction));
    float nDh = max(0.0, dot(material.Normal, halfway));
    vec3 fresnelColor = FresnelSchlick(hDv, material.FresnelColor, material.MRO.y);

    // SPECULAR
    float normalDistribution = DistributionTrowbridgeReitzGGX(nDh, material.MRO.y);
    float selfShadowing = GeometrySmith(material.NdV, nDl, material.MRO.y);

    vec3 numerator = fresnelColor * normalDistribution * selfShadowing;
    float denominator = 4 * material.NdV * nDl;
    vec3 specular = numerator / max(denominator, 0.001);

    // DIFFUSE
    vec3 diffuse = vec3(1.0 - fresnelColor) * (1.0 - material.MRO.x) * material.Albedo;

    // MIX
    return ((diffuse / PI) + specular) * nDl * light.Color * material.MRO.z;
}



#endif