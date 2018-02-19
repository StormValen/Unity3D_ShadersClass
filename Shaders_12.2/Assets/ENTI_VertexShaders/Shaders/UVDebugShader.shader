Shader "NT/UVDebug"
{	
	SubShader
	{
		Tags{ "Queue" = "Geometry" }

		Pass
		{
			GLSLPROGRAM

#ifdef VERTEX
			#include "UnityCG.glslinc"

			varying vec2 TextureCoordinate;

			void main()
			{
				gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
				TextureCoordinate = gl_MultiTexCoord0.xy;
			}
#endif

#ifdef FRAGMENT
			varying vec2 TextureCoordinate;

			void main()
			{
				gl_FragColor = vec4(TextureCoordinate.xy, 0, 1);
			}
#endif
			ENDGLSL
		}
	}
}
