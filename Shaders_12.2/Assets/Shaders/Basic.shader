Shader "Unlit/Basic" {
	Properties {
		_Color("Color", color) = (1, 0, 0, 1)
	}
	SubShader{
		Tags{ "Queue" = "Geometry" }
		Pass{
			GLSLPROGRAM

#ifdef VERTEX //Se ejecuta por cada vertice en la escena.
			#include "UnityCG.glslinc"
			void main(){
				//Convertir coordenadas locales en coordenadas de pantalla
				mat4 l_ViewMatrix = gl_ModelViewMatrix*unity_WorldToObject; //Modelview Local to View.
				gl_Position = unity_ObjectToWorld * gl_Vertex;
				gl_Position = l_ViewMatrix * gl_Position;
				gl_Position = gl_ProjectionMatrix * gl_Position; //La posicion del vertice en coordenadas de pantalla. Luego para ese pixel se llama al pixelshader.
				//
			}	
#endif

#ifdef FRAGMENT //PIXELSHADER Se ejecuta por cada pixel en la pantalla.
	uniform vec4 _Color;
			void main(){
				gl_FragColor = _Color;
			}
#endif

			ENDGLSL
			}
			}
}