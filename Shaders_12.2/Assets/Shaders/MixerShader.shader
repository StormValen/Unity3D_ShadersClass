Shader "Unlit/MixerShader" {
	Properties{
		_gMixer("Mixer",2D) = "defaulttexture"{}
		_gText0("Texture0",2D) = "defaulttexture"{}
		_gText1("Texture1",2D) = "defaulttexture"{}
	}
	SubShader{
		Tags{ "Queue" = "Geometry" }
		Pass{
			GLSLPROGRAM

#ifdef VERTEX //Se ejecuta por cada vertice en la escena.
			#include "UnityCG.glslinc"
			uniform sampler2D _gMixer;
			uniform sampler2D _gText0;
			uniform sampler2D _gText1;
			varying vec2 TextureCoordinate;
			
			
			
			void main(){
				
				vec4 l_Height = vec4(0, 0, texture2DLod(_gText0, gl_MultiTexCoord0.xy, 0.0).x, 0);

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
			
			void main(){
				//gl_FragColor = _Color;
				//gl_FragColor = texture2D(_HeatTex, TextureCoordinate);

				gl_FragColor = mix(texture2D(_gText0, TextureCoordinate),
					texture2D(_gText1, TextureCoordinate), texture2D(_gMixer,
						TextureCoordinate).xxxx);
			}
#endif

			ENDGLSL
			}
			}
}