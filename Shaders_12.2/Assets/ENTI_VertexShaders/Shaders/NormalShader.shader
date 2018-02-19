Shader "NT/Normal"
{	
	SubShader
	{
		Tags{ "Queue" = "Geometry" }

		Pass
		{
			GLSLPROGRAM

#ifdef VERTEX
			#include "UnityCG.glslinc"

			varying vec3 normal;

			void main()
			{
				gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
				normal = (unity_ObjectToWorld * vec4(gl_Normal.xyz, 1.0)).xyz;
			}
#endif

#ifdef FRAGMENT
			varying vec3 normal;
			void main()
			{
				gl_FragColor = vec4(normalize(normal), 1);
			}
#endif
			ENDGLSL
		}
	}
}
