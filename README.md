# ShaderToHuman.gml
This is an experimental port of [Shader To Human](https://github.com/electronicarts/ShaderToHuman) library to GameMaker (GLSL), which brings the highly coveted `printf` functionality to shader editing, along with some in-shader UI features and rendering of simple 2D and 3D elements.

**Shader To Human** is a tool that helps you with shader writing and debugging. It's meant to be used for small specific use cases (printing or drawing a few numbers, 2D or 3D elements)
as it was optimized for ease of integration. It is not targeting complex UI or minimal performance impact.

If you want to get an introduction, check out the [GPC 2026 presentation](https://graphicsprogrammingconference.com/archive/2025/#shadertohuman-s2h-hlsl-glsl-library-for-debugging-shaders)
or browse the original [interactive documentation](https://electronicarts.github.io/ShaderToHuman).\
This is a nice video covering the purposes of this library: [https://www.youtube.com/watch?v=eitQIHYqZsw](https://www.youtube.com/watch?v=eitQIHYqZsw).

# Installation
## With Shady (recommended)
[Shady](https://github.com/KeeVeeGames/Shady.gml) is a shader preprocessor for GameMaker that allows referencing shaders inside each other and other features that are super useful for using libraries like that and for general shader development!
1. Download yymps extension file from the [release page](https://github.com/KeeVeeGames/ShaderToHuman.gml/releases) and import it into your GameMaker project.
2. [Install](https://github.com/KeeVeeGames/Shady.gml/releases) Shady to your project if you don't have it already.
3. Add `#pragma shady: import(sh_s2h)` inside the fragment shader that you want to use ShaderToHuman features with.
4. Add `#pragma shady: import(sh_s2h_3d)`  inside the fragment shader that you want to use ***3D*** ShaderToHuman features with.
5. Navigate to [Features](https://github.com/KeeVeeGames/ShaderToHuman.gml?tab=readme-ov-file#features) to learn how to use ShaderToHuman in the shader.

## Without Shady
1. Download yymps extension file from the [release page](https://github.com/KeeVeeGames/ShaderToHuman.gml/releases) and import it into your GameMaker project.
2. Copy-paste the contents of `sh_s2h` fragment shader into the fragment shader that you want to use ShaderToHuman features with, between the uniforms and main().
3. Copy-paste the contents of `sh_s2h_3d` fragment shader into the fragment shader that you want to use ***3D*** ShaderToHuman features with, between the uniforms and main().
4. This has to be done for every shader that is using ShaderToHuman which can be pretty tedious and awkward to navigate, so it is recommended to use Shady's `import` instead.
5. Navigate to [Features](https://github.com/KeeVeeGames/ShaderToHuman.gml?tab=readme-ov-file#features) to learn how to use ShaderToHuman in the shader.

## <a href=""><img src="https://img.shields.io/badge/OPTIONAL-9c6b19" alt="Optional" align="center"></a> GMEdit integration
[GMEdit](https://github.com/YellowAfterlife/GMEdit) is a custom code editor for GameMaker used by a lot of professionals because of its advanced programming features. This library also comes with a custom API for GMEdit's shader editor that provides syntax highlighting for ShaderToHuman functions.
1. Download `Shady_GMEditAPI` archive from the [release page](https://github.com/KeeVeeGames/ShaderToHuman.gml/releases) and unzip it into `%appdata%\AceGM\GMEdit\api` (so the final path will be `\api\shaders\s2h\`).

# Features
### Variable printing and text rendering
<img width="642" height="352" alt="Runner_g75LswX6Aj" src="https://github.com/user-attachments/assets/e94a45de-87e9-4742-8be8-4cfb2334643a" />

####
You can check `obj_test_print` in the demo project.
1. Requires `s2h_fontTexture` uniform, which is used to sample the font for text rendering.
2. Requires importing `sh_s2h`.

<details>
  <summary><b>Example</b></summary>

  ```glsl
vec2 pxPos = gl_FragCoord.xy;
ContextGather ui;
s2h_init(ui, pxPos);

s2h_setCursor(ui, vec2(10, 10));
s2h_setScale(ui, 2.0);

ui.textColor = vec4(1, 1, 1, 1);
s2h_printTxt(ui, _s, _2, _h, _SPACE);
s2h_printFloat(ui, -12.34);

vec4 color = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
gl_FragColor = mix(color, ui.dstColor, ui.dstColor.a);
```
</details>

##

### 2D shapes rendering
https://github.com/user-attachments/assets/e1f1ef46-667f-411f-9515-e4fab9ea3ac6

You can check `obj_test_2d` in the demo project.
1. This feature doesn't require `s2h_fontTexture` uniform if you don't need to render text. But you have to declare to compile the shader; you can just not send anything to it.
2. Requires importing `sh_s2h`.

<details>
  <summary><b>Example</b></summary>

  ```glsl
vec2 pxPos = gl_FragCoord.xy;
ContextGather ui;
s2h_init(ui, pxPos);

s2h_drawDisc(ui, vec2(100,60), 40.0, vec4(1,0,0,1));
s2h_drawCircle(ui, vec2(100, 160), 40.0, vec4(1,0,0,1), 1.5);
s2h_drawRectangle(ui, vec2(300, 20), vec2(500, 100), vec4(1,0,0,1));

vec4 color = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
gl_FragColor = mix(color, ui.dstColor, ui.dstColor.a);
```
</details>

##

### 3D shapes rendering
https://github.com/user-attachments/assets/9f990f59-603c-4ec8-b68a-3871a5fb030b

You can check `obj_test_3d` in the demo project.
1. This feature doesn't require `s2h_fontTexture` uniform if you don't need to render text. But you have to declare to compile the shader; you can just not send anything to it.
2. You need to create a 3D camera for rendering using `matrix_build_lookat` and `matrix_build_projection_perspective_fov` and use the matrices to construct uniforms (see next). 
3. Requires matrix uniforms: `u_clipFromWorld` (matrixProjection × matrixView), `u_worldFromClip` (u_clipFromWorld⁻¹) and `u_worldFromView` (matrixView⁻¹).
4. Requires importing `sh_s2h`.
5. Requires importing `sh_s2h_3d`.

<details>
  <summary><b>Example</b></summary>

  ```glsl
vec2 pxPos = gl_FragCoord.xy;
Context3D context;

vec2 screenPos = v_vTexcoord * 2.0 - 1.0;
vec4 worldPosHom = (u_worldFromClip) * (vec4(screenPos, 0.1, 1));
vec3 worldPos = worldPosHom.xyz / worldPosHom.w;

vec3 ro = ((u_worldFromView * vec4(0, 0, 0, 1)).xyz);
vec3 rd = normalize(worldPos - ro);
s2h_init(context, ro, rd);

s2h_drawCheckerBoard(context, vec3(0.0, 1.0, 0.0));
s2h_drawAABB(context, vec3(2.0, 1.0, 3.5) + offset, vec3(0.5, 1.0, 0.25), vec4(1.0, 0.1, 0.1, 1.0));
s2h_drawArrowWS(context, vec3(3.0, 0.0, 1.5) + offset, vec3(3.0, 2.0, 1.5) + offset, vec4(0.0, 0.0, 1.0, 1.0), 0.8);
s2h_drawSphereWS(context, vec3(1.5, 1.0, -2.5) + offset, vec4(0.1, 0.5, 0.1, 1.0), 1.0);
s2h_drawLineWS(context, vec3(-2.0, 0.0, -3.0) + offset, vec3(-2.0, 4.0, -3.0) + offset, vec4(1.0, 1.0, 1.0, 1.0), 0.5);

vec4 color = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
gl_FragColor = mix(color, vec4(context.dstColor.rgb, 1), context.dstColor.a);
```
</details>

##

### Immediate mode UI
https://github.com/user-attachments/assets/d981380d-a463-4b24-a2b2-219e185f9bf4

You can check `obj_test_ui` in the demo project.\
This is quite an experimental functionality because the original implementation uses Compute Shaders / SSBOs to store UI state between frames, and it is not supported on GameMaker. However, I figured out a hacky solution that involves ping-ponging the target surface that the UI is rendering into and storing the state in the top-left line of pixels in that image.
1. Requires `s2h_fontTexture` uniform, which is used to sample the font for text rendering.
2. Requires `u_Mouse` uniform in ShaderToy's "iMouse" format to support mouse interaction.
3. Requires `s_UIState` sampler uniform  for UI state saving and loading.
4. Requires `u_Resolution` uniform for UI state saving and loading.
5. Requires importing `sh_s2h`.
6. To use this feature, you must use a surface (can be `application_surface`) and apply the debuggable shader to it, because of the specifics of storing the state.
7. There are custom surface drawing functions (`s2h_ui_draw_surface`) that you need to use instead of the standard ones. Also prepare an instance of `s2h_UiHandle` and set it via `s2h_ui_set_state`.

<details>
  <summary><b>Example</b></summary>

  ```glsl
vec2 pxPos = gl_FragCoord.xy;
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
s2h_setCursor(ui, vec2(10, 20));
s2h_setScale(ui, 2.0);
ui.s2h_State = UIState[0].s2h_State;
bool leftMouse = sign(u_Mouse.z) == 1.0;
bool leftMouseClicked = sign(u_Mouse.w) == 1.0;
ui.mouseInput = vec4(u_Mouse.x, u_Mouse.y, float(leftMouse), float(leftMouseClicked));

// UI controls
if(s2h_radioButton(ui, UIState[0].UIRadioState == 1, UIStatePos.UIRadioCheckbox) && leftMouse)
    UIState[0].UIRadioState = 1;
if(s2h_button(ui, 5, UIStatePos.UIRadioCheckbox) && leftMouse)
    UIState[0].UIRadioState = 0;
if(s2h_checkBox(ui, UIState[0].UICheckboxState != 0, UIStatePos.UIRadioCheckbox) && leftMouseClicked)
    UIState[0].UICheckboxState = 1 - UIState[0].UICheckboxState;
s2h_sliderFloat(ui, 8, UIState[0].colorSlider0.a, 0.0, 1.0);
s2h_progress(ui, 5, UIState[0].colorSlider0.a);
s2h_sliderRGB(ui, 8, UIState[0].colorSlider0.rgb);
s2h_sliderRGBA(ui, 8, UIState[0].colorSlider1);

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
    vec4 color = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
    gl_FragColor = mix(color, ui.dstColor, ui.dstColor.a);
}

s2h_deinit(ui, UIState[0].s2h_State);
```
</details>

## Differences between the original and the port
* As this is essentially a port to GLSL 1.20, some features that are not supported in the old versions of GLSL, but are used by the original developers, were reimplemented/downgraded when possible or stripped. Notably: all unsigned numbers became signed, bit shift and integer modulo were implemented as functions, font rendering is made by texture sampling and other minor changes.
* This port doesn't support "Scatter" API, as it require a use of Compute Shaders.
* UI functionality can only be done using custom surface drawing functions and saving state in the same ping-ponged frame texture.
* [WIP]
#### Fixes and new features
Along the way, I fixed and added some features to the main S2H. But it turned out that the original developers did not actually intend to receive pull requests, so if you want to have them for the original non-GameMaker version, you can grab it from [my fork](https://github.com/KeeVeeGames/ShaderToHuman) in `musnik-dev` branch.
* Rendering is now fixed for non-antialised 3D scenes.
* `transpileToGLSL.bat` now automatically finds the Visual Studio installation on the machine.
* UI functionality is now available for targets that don't support SSBOs (WebGL, OpenGL 1.20).
* UI visual fixes.
* [WIP]

## Original Authors
* Martin Mittring MMittring@ea.com Kosmokleaner@Kosmokleaner.de (main author)
* Anushka Nair AnuNair@ea.com

## Port Author
Nikita Musatov [MusNik / KeeVee Games](https://twitter.com/keeveegames)
