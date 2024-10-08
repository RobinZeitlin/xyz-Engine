#shader vertex
#version 330 core

layout(location = 0) in vec3 vertexPos;

uniform mat4 u_Model;
uniform mat4 u_View;
uniform mat4 u_Projection;

out vec3 fragPos;

void main()
{
    gl_Position = u_Projection * u_View * u_Model * vec4(vertexPos, 1.0);
    fragPos = vertexPos;
};

#shader fragment
#version 330 core

in vec3 fragPos;

uniform vec3 u_bgColor;
uniform float u_renderRadius;
uniform vec3 u_playerPos;

out vec4 targetColor;

float Lerp(float a, float b, float t)
{
    return (1.0 - t) * a + b * t;
}

void main()
{
    float t = clamp(distance(fragPos, u_playerPos) / u_renderRadius, 0, 1);
    float color = Lerp(u_bgColor.x, 1.0, 1 - t);
    
    targetColor = vec4(vec3(color), 1.0);
};