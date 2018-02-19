Shader "NT/Texture"
{
	Properties
	{
		_MainTex("Main texture", 2D) = "white" {}
	}
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
			uniform sampler2D _MainTex;

			void main()
			{
				gl_FragColor = texture2D(_MainTex, TextureCoordinate);
			}
#endif
			ENDGLSL
		}
	}
}
