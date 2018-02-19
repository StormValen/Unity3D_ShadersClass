Shader "Unlit/BanderaShader" {
	Properties{
		_gMainTex("MainTex",2D) = "defaulttexture"{}
		_gAmplitudeX("AmplitudeX", float) = 1.0
		_gAmplitudeZ("AmplitudeZ", float) = 1.0
		_gSpeed("Speed" , float) = 1.0
		_gDividerX("DividerX" , float) = 1.0
		_gDividerZ("DividerZ" , float) = 1.0
	}
	SubShader{
		Tags{ "Queue" = "Geometry" }
		Pass{
			GLSLPROGRAM

#ifdef VERTEX //Se ejecuta por cada vertice en la escena.
			#include "UnityCG.glslinc"
	
			varying vec2 gTextureCoordinate;
			uniform float _gAmplitudeX;
			uniform float _gAmplitudeZ;
			uniform float _gSpeed;
			uniform float _gDividerX;
			uniform float _gDividerZ;
			
			void main(){
				//Convertir coordenadas locales en coordenadas de pantalla
				mat4 lViewMatrix = gl_ModelViewMatrix * unity_WorldToObject;
				gl_Position = gl_Vertex;
				gl_Position.y += _gAmplitudeX*sin(gl_MultiTexCoord0.x * _gDividerX + _Time.y * _gSpeed) - _gAmplitudeX*sin(_Time.y * _gSpeed);
				gl_Position.z += _gAmplitudeZ*sin(gl_MultiTexCoord0.x * _gDividerZ + _Time.y * _gSpeed) - _gAmplitudeZ*sin(_Time.y * _gSpeed);
				gl_Position = unity_ObjectToWorld * gl_Position;
				gl_Position = lViewMatrix * gl_Position;
				gl_Position = gl_ProjectionMatrix * gl_Position;
				gTextureCoordinate = gl_MultiTexCoord0.xy;
			}	
#endif

#ifdef FRAGMENT //PIXELSHADER Se ejecuta por cada pixel en la pantalla.
			varying vec2 gTextureCoordinate;
			uniform sampler2D _gMainTex;
			
			void main(){
				gl_FragColor = texture2D(_gMainTex,gTextureCoordinate);
			}
#endif

			ENDGLSL
			}
			}
}