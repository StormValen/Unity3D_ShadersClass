Shader "NT/Terrain"
{
	Properties
	{
		_MainTex("Base (RGB)", 2D) = "white" {}
		_HeightmapTex("Heightmap", 2D) = "white" {}
		_MaxHeight("MaxHeight", float) = 100
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
			uniform sampler2D _HeightmapTex;
			uniform float _MaxHeight;

			void main()
			{
				vec4 l_Position = gl_Vertex;
				vec4 l_Height = texture2DLod(_HeightmapTex, gl_MultiTexCoord0.xy, 0.0);
				mat4 l_ViewMatrix=gl_ModelViewMatrix*unity_WorldToObject;
				l_Position = unity_ObjectToWorld*l_Position;
				l_Position.y = l_Position.y + l_Height.x*_MaxHeight;

				gl_Position = l_ViewMatrix* l_Position;
				gl_Position = gl_ProjectionMatrix * gl_Position;
				TextureCoordinate = vec2(0.5, l_Height.x);
			}
#endif

#ifdef FRAGMENT
			uniform sampler2D _MainTex;
			varying vec2 TextureCoordinate;

			void main()
			{
				gl_FragColor = texture2D(_MainTex, TextureCoordinate);
			}

#endif

			ENDGLSL
		}
	}
}
