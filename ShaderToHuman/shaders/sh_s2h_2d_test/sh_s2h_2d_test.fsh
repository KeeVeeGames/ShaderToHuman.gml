varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D s2h_fontTexture;
#pragma shady: import(sh_s2h)

uniform vec4 u_Mouse;

void main()
{
    vec2 pxPos = vec2(gl_FragCoord.xy);
    ContextGather ui;
    s2h_init(ui, pxPos);
    ui.mouseInput = u_Mouse;
    
    // disc
    s2h_drawDisc(ui, vec2(100,60), 40.0, vec4(1,0,0,1));
    s2h_drawDisc(ui, vec2(200,60), 20.0, vec4(0,1,0,1));
    s2h_drawDisc(ui, vec2(150,60), 30.0, vec4(1,1,1,0.5));
    // circle
    s2h_drawCircle(ui, vec2(100, 160), 40.0, vec4(1,0,0,1), 1.5);
    s2h_drawCircle(ui, vec2(200, 160), 20.0, vec4(0,1,0,1), 5.0);
    s2h_drawCircle(ui, vec2(150, 160), 30.0, vec4(1,1,1,0.5), 8.0);
    // halfSpace
    s2h_drawCrosshair(ui, ui.mouseInput.xy + 0.5, 10.0, vec4(1,1,1,1), 2.0);
    int edgeCount = 3;
    bool inside = true;
    float insideAA = 1.0;
    for(int i = 0; i < edgeCount; ++i)
    {
        vec2 center = vec2(80, 270);
        float w = float(i) * 3.14159265 * 2.0 / float(edgeCount) + 0.2;
        vec3 halfSpace = vec3(sin(w), cos(w), -20);
        halfSpace.z -= dot(halfSpace, vec3(center, 0));
        s2h_drawHalfSpace(ui, halfSpace, ui.mouseInput.xy + 0.5, vec4(s2h_indexToColor(uint(i + 1)),1), 10.0, 20.0);
        if(dot(halfSpace, vec3(ui.pxPos, 1)) > 0.0)
            inside = false;
        insideAA *= clamp(0.5 - dot(halfSpace, vec3(ui.pxPos - vec2(110, 0), 1)),0.0,1.0);
    }
    if(inside) ui.dstColor = vec4(1, 1, 1, 1);
    ui.dstColor = mix(ui.dstColor, vec4(1,1,1,1), insideAA);
    s2h_setScale(ui, 2.0);
    s2h_setCursor(ui, vec2(96, 240));
    s2h_printTxt(ui, _n, _o, _A, _A);
    s2h_setCursor(ui, vec2(216, 240));
    s2h_printTxt(ui, _A, _A);
    // rectangle
    s2h_drawRectangle(ui, vec2(300, 20), vec2(500, 100), vec4(1,0,0,1));
    s2h_drawRectangle(ui, vec2(400, 70), vec2(600, 75), vec4(0,1,0,1));
    s2h_drawRectangle(ui, vec2(350, 45), vec2(550, 85), vec4(1,1,1,0.5));
    // rectangleAA
    s2h_drawRectangleAA(ui, vec2(300, 130), vec2(500, 210), vec4(1,0,0,1), vec4(1,1,0,1), 5.0);
    s2h_drawRectangleAA(ui, vec2(400, 180), vec2(600, 185), vec4(0,0,1,1), vec4(0,1,1,1), 3.0);
    s2h_drawRectangleAA(ui, vec2(350, 155), vec2(550, 195), vec4(1,1,1,1), vec4(0,0,0,0.5), 2.0);
    // lines
    for(int i = 1; i < 5; ++i)
    {
        float w = float(i) * 1.1 + 1.0 + u_Mouse.x / 100.0;
        vec2 center = vec2(300, 270) + vec2(60 * i, 0);
        vec2 sc = vec2(sin(w), cos(w)) * 20.0;
        s2h_drawLine(ui, center + sc, center - sc, vec4(s2h_indexToColor(uint(i)), 1), 1.0 + float(i) * 4.0);
    }
    
    // your shader code goes there
    vec2 wave = gl_FragCoord.xy / 50.0 + u_Mouse.xy / 200.0;
    vec2 uv = v_vTexcoord + vec2(sin(wave.y) / 40.0, cos(wave.x) / 40.0);
    vec4 color = v_vColour * texture2D(gm_BaseTexture, uv);
    
    // mix your shader result with s2h output
    vec4 s2hColor = vec4(s2h_accurateLinearToSRGB(ui.dstColor.rgb), ui.dstColor.a);
    gl_FragColor = mix(color, s2hColor, s2hColor.a);
}
