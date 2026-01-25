# ShaderToHuman.gml
This is an experimental port of [Shader To Human](https://github.com/electronicarts/ShaderToHuman) library to GameMaker (GLSL), which brings the highly coveted `printf` functionality to shader editing, along with some in-shader UI features and rendering of simple 2D and 3D elements.

**Shader To Human** is a tool that helps you with shader writing and debugging. It's meant to be used for small specific use cases (printing or drawing a few numbers, 2D or 3D elements)
as it was optimized for ease of integration. It is not targeting complex UI or minimal performance impact.

If you want to get an introduction, check out the [GPC 2026 presentation](https://graphicsprogrammingconference.com/archive/2025/#shadertohuman-s2h-hlsl-glsl-library-for-debugging-shaders)
or browse the original [interactive documentation](https://electronicarts.github.io/ShaderToHuman).

# Installation
## With Shady
[WIP]

## Without Shady
[WIP]

## GMEdit integration
[WIP]

# Features
## Variable prinitng and text rendering
<img width="642" height="352" alt="Runner_g75LswX6Aj" src="https://github.com/user-attachments/assets/e94a45de-87e9-4742-8be8-4cfb2334643a" />

[WIP]

## 2D shapes rendering
https://github.com/user-attachments/assets/e1f1ef46-667f-411f-9515-e4fab9ea3ac6

[WIP]

## 3D shapes rendering
https://github.com/user-attachments/assets/9f990f59-603c-4ec8-b68a-3871a5fb030b

[WIP]

## Immediate mode UI
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
