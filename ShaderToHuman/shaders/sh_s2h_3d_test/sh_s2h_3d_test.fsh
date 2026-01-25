varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D s2h_fontTexture;
#pragma shady: import(sh_s2h)
#pragma shady: import(sh_s2h_3d)

uniform vec4 u_Mouse;
uniform vec2 u_Resolution;
uniform float u_Time;
uniform mat4 u_clipFromWorld;
uniform mat4 u_worldFromClip;
uniform mat4 u_worldFromView;

// 1:no Anti-Aliasing (fast), 2:2x2, 3:3x3 (pretty)
const int AA = 3;
mat4 lookAt(vec3 eye, vec3 target, vec3 up)
{
    vec3 zaxis = normalize(target - eye);
    vec3 xaxis = normalize(cross(up, zaxis));
    vec3 yaxis = cross(zaxis, xaxis);
    return mat4(vec4(xaxis, 0),vec4(yaxis, 0),vec4(zaxis, 0),vec4(eye, 1));
}
void scene(inout Context3D context)
{
    // camera starts at 0,0,0 so we move the content to be in the view
    vec3 offset = vec3(0.0, 1.0, 0.0);
    s2h_drawCheckerBoard(context, offset);
    
    // cuboid
    s2h_drawAABB(context, vec3(2.0, 1.0, 3.5) + offset, vec3(0.5, 1.0, 0.25), vec4(1.0, 0.1, 0.1, 1.0));
    
    // cone
    s2h_drawArrowWS(context, vec3(3.0, 0.0, 1.5) + offset, vec3(3.0, 2.0, 1.5) + offset, vec4(0.0, 0.0, 1.0, 1.0), 0.8);
    
    // sphere
    s2h_drawSphereWS(context, vec3(1.5, 1.0, -2.5) + offset, vec4(0.1, 0.5, 0.1, 1.0), 1.0);
    
    // cube
    s2h_drawAABB(context, vec3(-2.0, 1.5, 2.0) + offset, vec3(1.5, 1.5, 1.5), vec4(1.0, 1.0, 1.0, 0.5));
    
    // arrow
    s2h_drawLineWS(context,  vec3(-1.0, 1.0, -2.0) + offset, vec3(-3.0, 4.0, -2.0) + offset, vec4(1.0, 0.0, 1.0, 1.0), 0.1);
    s2h_drawArrowWS(context, vec3(-3.0, 4.0, -2.0) + offset, vec3(-3.5, 4.75, -2.0) + offset, vec4(1.0, 0.0, 1.0, 1.0), 0.3);
    
    // cylinder
    s2h_drawLineWS(context, vec3(-2.0, 0.0, -3.0) + offset, vec3(-2.0, 4.0, -3.0) + offset, vec4(1.0, 1.0, 1.0, 1.0), 0.5);
    
    // lines
    s2h_drawLineWS(context, vec3(-1.0, 4.0,  1.0) + offset, vec3( 1.0, 4.0,  1.0) + offset, vec4(1.0, 1.0, 0.0, 1.0), 0.09);
    s2h_drawLineWS(context, vec3(-1.0, 4.0, -1.0) + offset, vec3( 1.0, 4.0, -1.0) + offset, vec4(1.0, 1.0, 0.0, 1.0), 0.09);
    s2h_drawLineWS(context, vec3(-1.0, 4.0, -1.0) + offset, vec3(-1.0, 4.0,  1.0) + offset, vec4(1.0, 1.0, 0.0, 1.0), 0.09);
    s2h_drawLineWS(context, vec3( 1.0, 4.0, -1.0) + offset, vec3( 1.0, 4.0,  1.0) + offset, vec4(1.0, 1.0, 0.0, 1.0), 0.09);
}
vec3 computeSkyColor(inout Context3D context)
{
    return normalize(context.rd * 0.5 + 0.5) * 0.5;
}

void main()
{
    vec2 pxPos = vec2(gl_FragCoord.xy);
    Context3D context;
    ContextGather ui;
    vec3 wsCamPos = ((u_worldFromView * vec4(0, 0, 0, 1)).xyz);
    s2h_init(ui, vec2(pxPos));
    s2h_setCursor(ui, vec2(10, 10));
    s2h_printTxt(ui, _P, _o, _s, _COLON);
    s2h_printFloat(ui, wsCamPos.x); s2h_printTxt(ui, _COMMA);
    s2h_printFloat(ui, wsCamPos.y); s2h_printTxt(ui, _COMMA);
    s2h_printFloat(ui, wsCamPos.z);
    s2h_printLF(ui);
    s2h_printLF(ui);
    s2h_setScale(ui, 1.5);
    s2h_printTxt(ui, _L, _M, _B, _SPACE);
    s2h_printTxt(ui, _t, _o, _SPACE);
    s2h_printTxt(ui, _d, _r, _a, _g, _SPACE);
    s2h_printTxt(ui, _c, _a, _m, _e, _r, _a);
    s2h_printLF(ui);
    s2h_printTxt(ui, _W, _SLASH, _S, _COLON, _SPACE);
    s2h_printTxt(ui, _f, _o, _r);
    s2h_printTxt(ui, _w, _a, _r, _d);
    s2h_printLF(ui);
    s2h_printTxt(ui, _A, _SLASH, _D, _COLON, _SPACE);
    s2h_printTxt(ui, _h, _o, _r, _i);
    s2h_printTxt(ui, _z, _o, _n, _t, _a, _l);
    s2h_printLF(ui);
    s2h_printTxt(ui, _Q, _SLASH, _E, _COLON, _SPACE);
    s2h_printTxt(ui, _v, _e, _r);
    s2h_printTxt(ui, _t, _i, _c, _a, _l);
    
    vec4 tot = vec4(0, 0, 0, 0);
    for( int m=0; m<AA; m++ )
    for( int n=0; n<AA; n++ )
    {
        vec2 subPixel = vec2(float(m), float(n)) / float(AA) - vec2(0.5, 0.5);
        vec2 uv = (vec2(pxPos) + subPixel) / u_Resolution.xy;
        vec3 worldPos;
        {
            vec2 screenPos = uv * 2.0 - 1.0;
            vec4 worldPosHom = (u_worldFromClip) * (vec4(screenPos, 0.1, 1));
            worldPos = worldPosHom.xyz / worldPosHom.w;
        }
        vec3 ro = ((u_worldFromView * vec4(0, 0, 0, 1)).xyz);
        vec3 rd = normalize(worldPos - ro);
        s2h_init(context, ro, rd);
        // uncomment to composite with former pass
        // context.dstColor = vec4(computeSkyColor(context), 1);
        sceneWithShadows(context);
        
        float s = sin(u_Time) * 3.0;
        float c = cos(u_Time) * 3.0;
        mat4 mat = lookAt(vec3(s, 6.0, c), vec3(0.0, 1.0, 0.0), vec3(0.0, 1.0, 0.0));
        s2h_drawBasis(context, mat, 1.0);
        
        tot += context.dstColor;
    }
    tot /= float(AA*AA);
    
    // original scene
    gl_FragColor = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
    // composite background
    gl_FragColor = mix(vec4(computeSkyColor(context), 1), gl_FragColor, gl_FragColor.a);
    // composite 3D UI on top   
    gl_FragColor = mix(gl_FragColor, vec4(tot.rgb, 1), tot.a);
    // gl_FragColor = mix(vec4(tot.rgb, 1), gl_FragColor, gl_FragColor.a);
    // composite 2D UI on top
    gl_FragColor = gl_FragColor * (1.0 - ui.dstColor.a) + ui.dstColor;
}
