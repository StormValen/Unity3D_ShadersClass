Shader "NT/Flag"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_AmplitudeX("AmplitudeX", float) = 1.0
		_AmplitudeZ("AmplitudeZ", float) = 1.0
		_Speed("Speed", float) = 1.0
		_DividerX("DividerX", float) = 1.0
		_DividerZ("DividerZ", float) = 1.0
	}

	SubShader
	{
		Tags{ "Queue" = "Geometry" }
		Cull off

		Pass
		{
			GLSLPROGRAM

#ifdef VERTEX
			#include "UnityCG.glslinc"

			varying vec2 TextureCoordinate;
			uniform float _AmplitudeX;
			uniform float _AmplitudeZ;
			uniform float _Speed;
			uniform float _DividerX;
			uniform float _DividerZ;

			void main()
			{
				vec4 l_Position = gl_Vertex;
				
				l_Position = unity_ObjectToWorld*l_Position;
				l_Position.y += _AmplitudeX*sin(gl_MultiTexCoord0.x*_DividerX + _Time.y*_Speed)
					- _AmplitudeX*sin(_Time.y*_Speed);
				l_Position.z += _AmplitudeZ*sin(gl_MultiTexCoord0.x*_DividerZ + _Time.y*_Speed)
					- _AmplitudeZ*sin(_Time.y*_Speed);

				mat4 l_ViewMatrix = gl_ModelViewMatrix*unity_WorldToObject;
				gl_Position = l_ViewMatrix* l_Position;
				gl_Position = gl_ProjectionMatrix * gl_Position;
				TextureCoordinate = gl_MultiTexCoord0.xy;
			}
#endif

#ifdef FRAGMENT
			uniform sampler2D _MainTex;

			varying vec2 TextureCoordinate;

			void main()
			{
				gl_FragColor = texture2D(_MainTex, TextureCoordinate);
				//gl_FragColor = vec4(1.0, 1.0, 0, 1);
			}
#endif
			ENDGLSL
		}
	}
}
