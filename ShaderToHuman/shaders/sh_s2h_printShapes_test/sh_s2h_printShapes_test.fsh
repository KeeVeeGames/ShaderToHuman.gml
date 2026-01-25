varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D s2h_fontTexture;
#pragma shady: import(sh_s2h)

uniform vec2 u_Resolution;

void main()
{
    vec2 pxPos = v_vTexcoord * u_Resolution;
    ContextGather ui;
    s2h_init(ui, pxPos);
    
    s2h_setCursor(ui, vec2(10, 10));
    s2h_setScale(ui, 2.0);
    
    ui.textColor = vec4(0, 1, 1, 1);
    s2h_printTxt(ui, _s, _2, _h, _UNDERSCORE);
    s2h_printTxt(ui, _p, _r, _i, _n, _t);
    s2h_printTxt(ui, _B, _o, _x);
    s2h_printTxt(ui, _SLASH);
    s2h_printTxt(ui, _D, _i, _s, _c);
    s2h_printLF(ui);
    s2h_printLF(ui);
    s2h_setScale(ui, 3.0);
    s2h_printBox(ui, vec4(1, 0.7, 0.3, 1));
    s2h_printBox(ui, vec4(1, 0, 0, 1));
    s2h_printDisc(ui, vec4(0, 1, 0, 1));
    s2h_printDisc(ui, vec4(1, 1, 0, 1));
    s2h_printLF(ui);
    s2h_setScale(ui, 1.0);
    s2h_printLF(ui);
    s2h_printBox(ui, vec4(1, 0.7, 0.3, 1));
    s2h_printBox(ui, vec4(1, 0, 0, 1));
    s2h_printDisc(ui, vec4(0, 1, 0, 1));
    s2h_printDisc(ui, vec4(1, 1, 0, 1));
    
    // your shader code goes there
    vec4 color = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
    
    // mix your shader result with s2h output
    vec4 s2hColor = vec4(s2h_accurateLinearToSRGB(ui.dstColor.rgb), ui.dstColor.a);
    gl_FragColor = mix(color, s2hColor, s2hColor.a);
}
