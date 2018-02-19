Shader "NT/Mixer"
{
	Properties
	{
		_RedChannelMainTex("Red channel texture", 2D) = "white" {}
		_GreenChannelMainTex("Green channel texture", 2D) = "white" {}
		_BlueChannelMainTex("Blue channel texture", 2D) = "white" {}
		_AlphaChannelMainTex("Alpha BW texture", 2D) = "white" {}
		_MixerTex("Mixer texture", 2D) = "white" {}
	}

	SubShader
	{
		Tags{ "Queue" = "Geometry" }

		Pass
		{
			GLSLPROGRAM

#ifdef VERTEX
			#include "UnityCG.glslinc"

			uniform vec4 _RedChannelMainTex_ST;
			uniform vec4 _GreenChannelMainTex_ST;
			uniform vec4 _BlueChannelMainTex_ST;
			uniform vec4 _AlphaChannelMainTex_ST;

			varying vec2 TextureCoordinate;
			varying vec2 TextureCoordinate0;
			varying vec2 TextureCoordinate1;
			varying vec2 TextureCoordinate2;
			varying vec2 TextureCoordinate3;

			void main()
			{
				gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
				TextureCoordinate = gl_MultiTexCoord0.xy;
				TextureCoordinate0 = gl_MultiTexCoord0.xy * _RedChannelMainTex_ST.xy + _RedChannelMainTex_ST.zw;
				TextureCoordinate1 = gl_MultiTexCoord0.xy * _GreenChannelMainTex_ST.xy + _GreenChannelMainTex_ST.zw;
				TextureCoordinate2 = gl_MultiTexCoord0.xy * _BlueChannelMainTex_ST.xy + _BlueChannelMainTex_ST.zw;
				TextureCoordinate3 = gl_MultiTexCoord0.xy * _AlphaChannelMainTex_ST.xy + _AlphaChannelMainTex_ST.zw;
			}
#endif

#ifdef FRAGMENT
			uniform sampler2D _RedChannelMainTex;
			uniform sampler2D _GreenChannelMainTex;
			uniform sampler2D _BlueChannelMainTex;
			uniform sampler2D _AlphaChannelMainTex;
			uniform sampler2D _MixerTex;

			varying vec2 TextureCoordinate;
			varying vec2 TextureCoordinate0;
			varying vec2 TextureCoordinate1;
			varying vec2 TextureCoordinate2;
			varying vec2 TextureCoordinate3;

			void main()
			{
				vec4 l_MixerColor=texture2D(_MixerTex, TextureCoordinate);
				vec4 l_RedColor = texture2D(_RedChannelMainTex, TextureCoordinate0);
				vec4 l_GreenColor = texture2D(_GreenChannelMainTex, TextureCoordinate1);
				vec4 l_BlueColor = texture2D(_BlueChannelMainTex, TextureCoordinate2);
				vec4 l_AlphaColor = texture2D(_AlphaChannelMainTex, TextureCoordinate3);
				gl_FragColor = vec4(l_RedColor.xyz*l_MixerColor.x+
					l_GreenColor.xyz*l_MixerColor.y +
					l_BlueColor.xyz*l_MixerColor.z +
					l_AlphaColor.xyz*l_MixerColor.w, 1.0);
				//gl_FragColor = vec4(1.0, 1.0, 0, 1);
			}
#endif
			ENDGLSL
		}
	}
}
