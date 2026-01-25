# ShaderToHuman.gml
This is an experimental port of [Shader To Human](https://github.com/electronicarts/ShaderToHuman) library to GameMaker (GLSL), which brings the highly coveted `printf` functionality to shader editing, along with some in-shader UI features and rendering of simple 2D and 3D elements.

**Shader To Human** is a tool that helps you with shader writing and debugging. It's meant to be used for small specific use cases (printing or drawing a few numbers, 2D or 3D elements)
as it was optimized for ease of integration. It is not targeting complex UI or minimal performance impact.

If you want to get an introduction, check out the [GPC 2026 presentation](https://graphicsprogrammingconference.com/archive/2025/#shadertohuman-s2h-hlsl-glsl-library-for-debugging-shaders)
or browse the original [interactive documentation](https://electronicarts.github.io/ShaderToHuman).

# Installation
### With Shady (recommended)
[Shady](https://github.com/KeeVeeGames/Shady.gml) is a shader preprocessor for GameMaker that allows referencing shaders inside each other and other features that are super useful for using libraries like that and for general shader development!
1. Download yymps extension file from the [release page](https://github.com/KeeVeeGames/ShaderToHuman.gml/releases) and import it into your GameMaker project.
2. [Install](https://github.com/KeeVeeGames/Shady.gml/releases) Shady to your project if you don't have it already.
3. Add `#pragma shady: import(sh_s2h)` inside the fragment shader that you want to use ShaderToHuman features with.
4. Add `#pragma shady: import(sh_s2h_3d)`  inside the fragment shader that you want to use ***3D*** ShaderToHuman features with.
5. Navigate to [Features](https://github.com/KeeVeeGames/ShaderToHuman.gml?tab=readme-ov-file#features) to learn how to use ShaderToHuman in the shader.

### Without Shady
1. Download yymps extension file from the [release page](https://github.com/KeeVeeGames/ShaderToHuman.gml/releases) and import it into your GameMaker project.
2. Copy-paste the contents of `sh_s2h` fragment shader into the fragment shader that you want to use ShaderToHuman features with, between the uniforms and main().
3. Copy-paste the contents of `sh_s2h_3d` fragment shader into the fragment shader that you want to use ***3D*** ShaderToHuman features with, between the uniforms and main().
4. This has to be done for every shader that is using ShaderToHuman which can be pretty tedious and awkward to navigate, so it is recommended to use Shady's `import` instead.
5. Navigate to [Features](https://github.com/KeeVeeGames/ShaderToHuman.gml?tab=readme-ov-file#features) to learn how to use ShaderToHuman in the shader.

### <a href=""><img src="https://img.shields.io/badge/OPTIONAL-9c6b19" alt="Optional" align="center"></a> GMEdit integration
[GMEdit](https://github.com/YellowAfterlife/GMEdit) is a custom code editor for GameMaker used by a lot of professionals because of its advanced programming features. This library also comes with a custom API for GMEdit's shader editor that provides syntax highlighting for ShaderToHuman functions.
1. Download `Shady_GMEditAPI` archive from the [release page](https://github.com/KeeVeeGames/ShaderToHuman.gml/releases) and unzip it into `%appdata%\AceGM\GMEdit\api` (so the final path will be `\api\shaders\s2h\`).

# Features
### Variable prinitng and text rendering
<img width="642" height="352" alt="Runner_g75LswX6Aj" src="https://github.com/user-attachments/assets/e94a45de-87e9-4742-8be8-4cfb2334643a" />

[WIP]

### 2D shapes rendering
https://github.com/user-attachments/assets/e1f1ef46-667f-411f-9515-e4fab9ea3ac6

[WIP]

### 3D shapes rendering
https://github.com/user-attachments/assets/9f990f59-603c-4ec8-b68a-3871a5fb030b

[WIP]

### Immediate mode UI
https://github.com/user-attachments/assets/d981380d-a463-4b24-a2b2-219e185f9bf4

[WIP]

## Differences between the original and the port
* As this is essentially a port to GLSL 1.20, some features that are not supported in the old versions of GLSL, but are used by the original developers, were reimplemented/downgraded when possible or stripped. Notably: all unsigned numbers became signed, bit shift and integer modulo were implemented as functions, font rendering is made by texture sampling and other minor changes.
* This port doesn't support "Scatter" API, as it require a use of Compute Shaders.
* UI functionality can only be done using custom surface drawing functions and saving state in the same ping-ponged frame texture.
* [WIP]
#### Fixes and new features
Along the way, I fixed and added some features to the main S2H. But it turned out that the original developers do not actually intend to receive pull requests, so if you want to have them for the original non-GameMaker version, you can grab it from [my fork](https://github.com/KeeVeeGames/ShaderToHuman) in `musnik-dev` branch.
* Rendering is now fixed for non-antialised 3D scenes.
* `transpileToGLSL.bat` now automatically finds the Visual Studio installation on the machine.
* UI visual fixes.
* [WIP]

## Original Authors
* Martin Mittring MMittring@ea.com Kosmokleaner@Kosmokleaner.de (main author)
* Anushka Nair AnuNair@ea.com

## Port Author
Nikita Musatov [MusNik / KeeVee Games](https://twitter.com/keeveegames)
