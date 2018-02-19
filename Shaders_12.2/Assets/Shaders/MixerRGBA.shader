Shader "Unlit/MixerRGBAShader" {
	Properties{
		_gMixer("Mixer",2D) = "defaulttexture"{}
		_gText0("Texture0",2D) = "defaulttexture"{}
		_gText1("Texture1",2D) = "defaulttexture"{}
		_gText2("Texture2",2D) = "defaulttexture"{}
		_gText3("Texture3",2D) = "defaulttexture"{}
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
			varying vec2 TextureCoordinate;
			uniform sampler2D _gMixer;
			uniform sampler2D _gText0;
			uniform sampler2D _gText1;
			uniform sampler2D _gText2;
			uniform sampler2D _gText3;
			
			void main(){

				vec4 Red = texture2D(_gText0, TextureCoordinate);
				vec4 Green = texture2D(_gText1, TextureCoordinate);
				vec4 Blue = texture2D(_gText2, TextureCoordinate);
				vec4 Alpha = texture2D(_gText3, TextureCoordinate);
				vec4 Mix = texture2D(_gMixer, TextureCoordinate);

				gl_FragColor = vec4(Mix.x*Red+Mix.y*Green+Mix.z*Blue+Mix.w*Alpha);
			}
#endif

			ENDGLSL
			}
			}
}