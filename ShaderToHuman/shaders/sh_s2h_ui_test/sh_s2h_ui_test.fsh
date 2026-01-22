varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D s2h_fontTexture;
#pragma shady: import(sh_s2h)

uniform vec4 u_Mouse;
uniform sampler2D s_UIState;
uniform vec2 u_Resolution;

struct Struct_UIState
{
    int UIRadioState;
    int UICheckboxState;
    vec4 colorSlider0;
    vec4 colorSlider1;
    vec4 sizeSliders;
    ivec4 s2h_State;
};

struct Struct_UIStatePos
{
    vec2 UIRadioCheckbox;
    vec2 colorSlider0;
    vec2 colorSlider1;
    vec2 sizeSliders;
};

const Struct_UIStatePos UIStatePos = Struct_UIStatePos(
    vec2(0.0, 0.0),
    vec2(1.0, 0.0),
    vec2(2.0, 0.0),
    vec2(3.0, 0.0)
);

vec4 loadState(vec2 dataPos) {
    return texture2D(s_UIState, (dataPos + 0.5) / u_Resolution);
}

bool saveState(vec2 dataPos, vec2 fragCoord) {
    if (ivec2(fragCoord) == ivec2(dataPos.x, dataPos.y)) {
        return true;
    }
    return false;
}

void main()
{
    vec2 pxPos = gl_FragCoord.xy;
    vec4 ret = vec4(0,0,0,0);
    {
        ContextGather ui;
        Struct_UIState UIState[1];
        UIState[0].s2h_State = ivec4(0,0,0,0);
        
        // load UI state
        vec4 radioCheckbox = loadState(UIStatePos.UIRadioCheckbox);
        UIState[0].UIRadioState = uint(radioCheckbox.x * 255.0);
        UIState[0].UICheckboxState = uint(radioCheckbox.y * 255.0);
        UIState[0].colorSlider0 = loadState(UIStatePos.colorSlider0);
        UIState[0].colorSlider1 = loadState(UIStatePos.colorSlider1);
        UIState[0].sizeSliders = loadState(UIStatePos.sizeSliders);
        
        s2h_init(ui, pxPos + 0.5);
        s2h_setCursor(ui, vec2(10, 10));
        s2h_setScale(ui, 2.0);
        ui.s2h_State = UIState[0].s2h_State;
        bool leftMouse = sign(u_Mouse.z) == 1.0;
        bool leftMouseClicked = sign(u_Mouse.w) == 1.0;
        ui.mouseInput = vec4(u_Mouse.x, u_Mouse.y, float(leftMouse), float(leftMouseClicked));
        
        ui.textColor.rgb = vec3(1,1,1);
        {
            // radio button
            s2h_printTxt(ui, _SPACE, _SPACE);
            s2h_printInt(ui, int(UIState[0].UIRadioState));
            s2h_printTxt(ui, _SPACE, _EQUAL, _SPACE);
            {
                vec4 backup = ui.buttonColor;
                ui.buttonColor = vec4(1,0,0,1);
                if(s2h_radioButton(ui, UIState[0].UIRadioState == 1, UIStatePos.UIRadioCheckbox) && leftMouse) UIState[0].UIRadioState = 1;
                ui.buttonColor = vec4(0,1,0,1);
                if(s2h_radioButton(ui, UIState[0].UIRadioState == 2, UIStatePos.UIRadioCheckbox) && leftMouse) UIState[0].UIRadioState = 2;
                ui.buttonColor = vec4(0,0,1,1);
                if(s2h_radioButton(ui, UIState[0].UIRadioState == 3, UIStatePos.UIRadioCheckbox) && leftMouse) UIState[0].UIRadioState = 3;
                ui.buttonColor = backup;
            }
            s2h_printLF(ui);
            s2h_printLF(ui);
            
            // button
            s2h_printTxt(ui, _SPACE, _SPACE);
            s2h_printInt(ui, int(UIState[0].UIRadioState));
            s2h_printTxt(ui, _SPACE, _EQUAL, _SPACE);
            s2h_printTxt(ui, _C, _l, _e, _a, _r);
            if(s2h_button(ui, 5, UIStatePos.UIRadioCheckbox) && leftMouse) UIState[0].UIRadioState = 0;
            s2h_printTxt(ui, _SPACE, _s, _2, _h, _UNDERSCORE);
            s2h_printTxt(ui, _b, _u, _t, _t, _o, _n);
            s2h_printLF(ui);
            s2h_printLF(ui);
            
            // checkbox
            s2h_printTxt(ui, _SPACE, _SPACE);
            s2h_printInt(ui, int(UIState[0].UICheckboxState));
            s2h_printTxt(ui, _SPACE, _EQUAL, _SPACE);
            if(s2h_checkBox(ui, UIState[0].UICheckboxState != 0, UIStatePos.UIRadioCheckbox) && leftMouseClicked) UIState[0].UICheckboxState = 1 - UIState[0].UICheckboxState;
            s2h_printTxt(ui, _SPACE, _s, _2, _h, _UNDERSCORE);
            s2h_printTxt(ui, _c, _h, _e, _c, _k);
            s2h_printTxt(ui, _B, _o, _x);
            s2h_printLF(ui);
            s2h_printLF(ui);
            
            // slider
            s2h_printTxt(ui, _SPACE, _SPACE);
            s2h_sliderFloat(ui, 8, UIState[0].colorSlider0.a, 0.0, 1.0);
            s2h_printTxt(ui, _SPACE, _s, _2, _h, _UNDERSCORE);
            s2h_printTxt(ui, _s, _l, _i, _d, _e, _r);
            s2h_printTxt(ui, _F, _l, _o, _a, _t);
            s2h_printLF(ui);
            s2h_printLF(ui);
            
            // progress
            s2h_printTxt(ui, _SPACE, _SPACE);
            s2h_progress(ui, 5, UIState[0].colorSlider0.a);
            s2h_printTxt(ui, _SPACE, _s, _2, _h, _UNDERSCORE);
            s2h_printTxt(ui, _p, _r, _o, _g);
            s2h_printTxt(ui, _r, _e, _s, _s);
            s2h_printLF(ui);
            s2h_printLF(ui);
            
            // slider rgb
            s2h_printTxt(ui, _SPACE, _SPACE);
            s2h_sliderRGB(ui, 8, UIState[0].colorSlider0.rgb);
            s2h_printTxt(ui, _SPACE, _s, _2, _h, _UNDERSCORE);
            s2h_printTxt(ui, _s, _l, _i, _d, _e, _r);
            s2h_printTxt(ui, _R, _G, _B);
            s2h_printLF(ui);
            s2h_printLF(ui);
            s2h_printLF(ui);
            s2h_printLF(ui);
            
            // slider rgba
            s2h_printTxt(ui, _SPACE, _SPACE);
            s2h_sliderRGBA(ui, 8, UIState[0].colorSlider1);
            s2h_printTxt(ui, _SPACE, _s, _2, _h, _UNDERSCORE);
            s2h_printTxt(ui, _s, _l, _i, _d, _e, _r);
            s2h_printTxt(ui, _R, _G, _B, _A);
            s2h_printLF(ui);
            s2h_printLF(ui);
            s2h_printLF(ui);
            s2h_printLF(ui);
            s2h_printLF(ui);
        }
        
        s2h_drawCrosshair(ui, ui.mouseInput.xy + 0.5, 10.0, vec4(1,1,1,1), 2.0);
        
        // save UI state
        if (saveState(UIStatePos.UIRadioCheckbox, pxPos))
            gl_FragColor = vec4(float(UIState[0].UIRadioState) / 255.0, float(UIState[0].UICheckboxState) / 255.0, 0.0, 0.0);
        else if (saveState(UIStatePos.colorSlider0, pxPos))
            gl_FragColor = UIState[0].colorSlider0;
        else if (saveState(UIStatePos.colorSlider1, pxPos))
            gl_FragColor = UIState[0].colorSlider1;
        else if (saveState(UIStatePos.sizeSliders, pxPos))
            gl_FragColor = UIState[0].sizeSliders;
        else
        {
            // your shader code goes there
            vec2 wave = gl_FragCoord.xy / 50.0 + u_Mouse.xy / 200.0;
            vec2 uv = v_vTexcoord + vec2(sin(wave.y) / 100.0, cos(wave.x) / 100.0);
            vec4 color = v_vColour * texture2D(gm_BaseTexture, uv);
            
            // mix your shader result with s2h output
            gl_FragColor = mix(color, ui.dstColor, ui.dstColor.a);
        }
        
        s2h_deinit(ui, UIState[0].s2h_State);
    }
}
