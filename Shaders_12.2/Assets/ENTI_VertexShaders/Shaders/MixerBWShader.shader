Shader "NT/MixerBW"
{
	Properties
	{
		_BlackMainTex("Black texture", 2D) = "white" {}
		_WhiteMainTex("White texture", 2D) = "white" {}
		_MixerBWMainTex("Mixer BW texture", 2D) = "white" {}
	}

	SubShader
	{
		Tags{ "Queue" = "Geometry" }

		Pass
		{
			GLSLPROGRAM

#ifdef VERTEX
			#include "UnityCG.glslinc"

			uniform vec4 _BlackMainTex_ST;
			uniform vec4 _WhiteMainTex_ST;

			varying vec2 TextureCoordinate;
			varying vec2 TextureCoordinate0;
			varying vec2 TextureCoordinate1;

			void main()
			{
				gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
				TextureCoordinate = gl_MultiTexCoord0.xy;
				TextureCoordinate0 = gl_MultiTexCoord0.xy * _BlackMainTex_ST.xy + _BlackMainTex_ST.zw;
				TextureCoordinate1 = gl_MultiTexCoord0.xy * _WhiteMainTex_ST.xy + _WhiteMainTex_ST.zw;
			}
#endif

#ifdef FRAGMENT
			uniform sampler2D _BlackMainTex;			
			uniform sampler2D _WhiteMainTex;			
			uniform sampler2D _MixerBWMainTex;

			varying vec2 TextureCoordinate;
			varying vec2 TextureCoordinate0;
			varying vec2 TextureCoordinate1;

			void main()
			{
				float l_MixerColor=texture2D(_MixerBWMainTex, TextureCoordinate).x;
				vec4 l_BlackColor = texture2D(_BlackMainTex, TextureCoordinate0);
				vec4 l_WhiteColor = texture2D(_WhiteMainTex, TextureCoordinate1);
				gl_FragColor = l_WhiteColor*l_MixerColor+(1.0- l_MixerColor)*l_BlackColor;
				//gl_FragColor = vec4(TextureCoordinate.xy, 0, 1);
			}
#endif
			ENDGLSL
		}
	}
}
