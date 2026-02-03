varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D s2h_fontTexture;
uniform vec2 u_Resolution;

#pragma shady: import(sh_s2h)

void main()
{
    vec2 pxPos = v_vTexcoord * u_Resolution;
    ContextGather ui;
    s2h_init(ui, pxPos);
    
    s2h_setCursor(ui, vec2(20, 20));
    s2h_setScale(ui, 2.0);
    
    ui.textColor = vec4(0, 1, 1, 1);
    s2h_printTxt(ui, _W, _E, _L, _L);
    s2h_printTxt(ui, _C, _O, _M, _E);
    s2h_printTxt(ui, _SPACE, _T, _O, _SPACE);
    s2h_printTxt(ui, _S, _h, _a, _d, _e, _r);
    s2h_printTxt(ui, _T, _o);
    s2h_printTxt(ui, _H, _u, _m, _a, _n);
    s2h_printTxt(ui, _PERIOD, _g, _m, _l);
    s2h_printTxt(ui, _SPACE, _v);
    s2h_printInt(ui, _S2H_VERSION);
    s2h_printTxt(ui, _PERIOD);
    s2h_printInt(ui, _S2H_PORT_VERSION);
    s2h_printLF(ui);
    s2h_printLF(ui);
    ui.textColor = vec4(1, 1, 1, 1);
    s2h_printTxt(ui, _U, _s, _e, _SPACE);
    s2h_printTxt(ui, _S, _P, _A, _C, _E);
    s2h_printTxt(ui, _B, _A, _R, _SPACE);
    s2h_printTxt(ui, _t, _o, _SPACE);
    s2h_printTxt(ui, _c, _y, _c, _l, _e, _SPACE);
    s2h_printTxt(ui, _t, _h, _r, _u, _SPACE);
    s2h_printTxt(ui, _d, _e, _m, _o, _s);
    
    // your shader code goes there
    vec4 color = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
    
    // mix your shader result with s2h output
    vec4 s2hColor = vec4(s2h_accurateLinearToSRGB(ui.dstColor.rgb), ui.dstColor.a);
    gl_FragColor = mix(color, s2hColor, s2hColor.a);
}
