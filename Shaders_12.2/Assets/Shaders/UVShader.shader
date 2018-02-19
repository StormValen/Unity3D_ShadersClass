Shader "Unlit/UVShader" {
	Properties{
		_Color("Color", color) = (1, 0, 0, 1)
		_MainTex("Texture",2D) = ""{}
	}
	SubShader{
		Tags{ "Queue" = "Geometry" }
		Pass{
			GLSLPROGRAM

#ifdef VERTEX //Se ejecuta por cada vertice en la escena.
			#include "UnityCG.glslinc"
			varying vec2 TextureCoordinate;
			void main(){
				
				//Convertir coordenadas locales en coordenadas de pantalla
				mat4 l_ViewMatrix = gl_ModelViewMatrix*unity_WorldToObject; //Modelview Local to View.
				gl_Position = unity_ObjectToWorld * gl_Vertex;
				gl_Position = l_ViewMatrix * gl_Position;
				gl_Position = gl_ProjectionMatrix * gl_Position; //La posicion del vertice en coordenadas de pantalla. Luego para ese pixel se llama al pixelshader.
				//
				TextureCoordinate = gl_MultiTexCoord0.xy;
			}	
#endif

#ifdef FRAGMENT //PIXELSHADER Se ejecuta por cada pixel en la pantalla.
			uniform vec4 _Color;
			varying vec2 TextureCoordinate;
			uniform sampler2D _MainTex;
			
			void main(){
				//gl_FragColor = _Color;
				gl_FragColor = vec4(TextureCoordinate.xy,0,1);
			}
#endif

			ENDGLSL
			}
			}
}