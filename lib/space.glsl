#include "random.glsl"

#ifndef SPACE
#define SPACE


void LinearizeDepth(in float depth, in float zNear, in float zFar, out float result)
{
    result = zNear * zFar / (zFar + depth * (zNear - zFar));
}

void SpaceWorldToScreenSpace(in mat4 projection, in vec3 postionWS, out vec4 positionSS)
{
    // to projection space
    positionSS = projection * vec4(postionWS, 1.0);
    
    // to NDC
    positionSS.xyz /= positionSS.w;

    // to SS
    positionSS.xyz = (positionSS.xyz  * 0.5) + 0.5;
}

void SpaceGenerateTangentSpace(in vec3 normal, vec3 viewDirection, in vec2 uv, out mat3 tangentSpace)
{
    // http://www.thetenthplanet.de/archives/1180
    // get edge vectors of the pixel triangle
    vec3 dp1 = dFdx( viewDirection );
    vec3 dp2 = dFdy( viewDirection );
    vec2 duv1 = dFdx( uv );
    vec2 duv2 = dFdy( uv );
 
    // solve the linear system
    vec3 dp2perp = cross( dp2, normal );
    vec3 dp1perp = cross( normal, dp1 );
    vec3 T = dp2perp * duv1.x + dp1perp * duv2.x;
    vec3 B = dp2perp * duv1.y + dp1perp * duv2.y;
 
    // construct a scale-invariant frame 
    float invmax = inversesqrt( max( dot(T,T), dot(B,B) ) );
    tangentSpace = mat3( T * invmax, B * invmax, normal );
}

#endif