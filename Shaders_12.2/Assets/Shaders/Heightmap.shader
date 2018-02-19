Shader "Unlit/HeightmapShader" {
	Properties{
		_Color("Color", color) = (1, 0, 0, 1)

		_MainTex("Texture",2D) = ""{}
		_HeatTex("Heat",2D) = ""{}
		_MaxHeight("MaxHeight", float) = 1
	}
	SubShader{
		Tags{ "Queue" = "Geometry" }
		Pass{
			GLSLPROGRAM

#ifdef VERTEX //Se ejecuta por cada vertice en la escena.
			#include "UnityCG.glslinc"
			varying vec2 TextureCoordinate;
			uniform float _MaxHeight;
			uniform sampler2D _MainTex;
			
			
			void main(){
				
				vec4 l_Height = vec4(0, 0, texture2DLod(_MainTex, gl_MultiTexCoord0.xy, 0.0).x*_MaxHeight, 0);

				//Convertir coordenadas locales en coordenadas de pantalla
				mat4 l_ViewMatrix = gl_ModelViewMatrix*unity_WorldToObject; //Modelview Local to View.
				gl_Position = unity_ObjectToWorld * (gl_Vertex + l_Height);
				gl_Position = l_ViewMatrix * gl_Position;
				gl_Position = gl_ProjectionMatrix * gl_Position; //La posicion del vertice en coordenadas de pantalla. Luego para ese pixel se llama al pixelshader.
				//

				TextureCoordinate = vec2(0.5, l_Height.z)*10;
				//TextureCoordinate = gl_MultiTexCoord0.xy;
			}	
#endif

#ifdef FRAGMENT //PIXELSHADER Se ejecuta por cada pixel en la pantalla.
			uniform vec4 _Color;
			varying vec2 TextureCoordinate;
			uniform sampler2D _HeatTex;
			
			
			void main(){
				//gl_FragColor = _Color;
				gl_FragColor = texture2D(_HeatTex, TextureCoordinate);
			}
#endif

			ENDGLSL
			}
			}
}