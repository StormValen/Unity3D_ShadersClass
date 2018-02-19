Shader "Unlit/FurShader" {
	Properties{
		MainTex("Main texture", 2D) = "white" {}
		_FurTex("Fur texture" , 2D) = "white" {}
		_FurTile("Fur tile" , float) = 10
		_FurLength("Fur length" , float) = 0.02
	}
	SubShader{
		Tags{ "Queue" = "Geometry" }
		Pass{
			GLSLPROGRAM

#ifdef VERTEX //Se ejecuta por cada vertice en la escena.
			#include "UnityCG.glslinc"
	
			varying vec2 gTextureCoordinate;
			uniform float _FurLength;

			vec3 CalcFurPosition(vec3 Position, vec3 Normal, float IdLayer, float TotalLayers, float _FurLength) {
				float layer = (IdLayer + 1) / TotalLayers;
				float length = _FurLength * layer;
				return Position + Normal*length;
			}
			void main()
			{
				float l_IdLayer = 0;
				float l_TotalLayers = 5;
				vec3 l_Position = CalcFurPosition(gl_Vertex.xyz, gl_Normal.xyz, l_IdLayer, l_TotalLayers, _FurLength);
				gl_Position = gl_ModelViewProjectionMatrix * vec4(l_Position, 1.0);
				gTextureCoordinate = gl_MultiTexCoord0.xy;
				//FurDiscardTexture = (l_IdLayer + 1) / l_TotalLayers;
			}

			
#endif

#ifdef FRAGMENT //PIXELSHADER Se ejecuta por cada pixel en la pantalla.
			varying vec2 gTextureCoordinate;
			uniform sampler2D _gMainTex;
			uniform sampler2D _gFurTex;
			
			void main(){
				gl_FragColor = texture2D(_gMainTex, gTextureCoordinate);
			}
#endif

			ENDGLSL
			}
			}
}