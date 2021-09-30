#include "constants.glsl"


#ifndef PBR
#define PBR


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