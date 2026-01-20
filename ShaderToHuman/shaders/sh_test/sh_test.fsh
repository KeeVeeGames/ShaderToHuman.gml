varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D s2h_fontTexture;
uniform vec4 iMouse;

#pragma shady: import(sh_s2h)

void main()
{
    ContextGather ui;
    s2h_init(ui, gl_FragCoord.xy);
    s2h_setCursor(ui, vec2(10, 10));
    s2h_setScale(ui, 2.0);
    ui.textColor.rgb = vec3(1,1,1);
    s2h_printTxt(ui, _s, _2, _h, _UNDERSCORE);
    s2h_printTxt(ui, _p, _r, _i, _n, _t);
    s2h_printTxt(ui, _I, _n, _t);
    s2h_printLF(ui);
    s2h_printLF(ui);
    ui.textColor = vec4(0, 0, 0, 1);
    s2h_printInt(ui, 12345);
    s2h_printLF(ui);
    s2h_printInt(ui, -12345);
    s2h_printLF(ui);
    s2h_printLF(ui);
    vec4 background = vec4(0.4, 0.7, 0.4, 1.0);
    gl_FragColor = background * (1.0 - ui.dstColor.a) + ui.dstColor;
}
