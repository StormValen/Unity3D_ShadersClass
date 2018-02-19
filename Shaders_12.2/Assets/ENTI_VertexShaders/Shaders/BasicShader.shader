Shader "NT/Basic"
{
	Properties
	{
		_Color("Color", color) = (1, 0, 0, 1)
	}
	SubShader
	{
		Tags{ "Queue" = "Geometry" }

		Pass
		{
			GLSLPROGRAM

#ifdef VERTEX
			#include "UnityCG.glslinc"

			void main()
			{
				gl_Position = gl_ModelViewMatrix  * gl_Vertex;
				gl_Position = gl_ProjectionMatrix * gl_Position;
			}
#endif

#ifdef FRAGMENT
			uniform vec4 _Color;
			void main()
			{
				gl_FragColor = _Color;
			}
#endif
			ENDGLSL
		}
	}
}
