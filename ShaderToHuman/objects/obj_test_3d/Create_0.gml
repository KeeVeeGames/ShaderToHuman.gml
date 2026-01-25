fontTexture = sprite_get_texture(spr_s2h_font, 0);
iMouse = new ShaderMouse();

samplerFontTexture = shader_get_sampler_index(sh_s2h_3d_test, "s2h_fontTexture");
uniformMouse = shader_get_uniform(sh_s2h_3d_test, "u_Mouse");
// samplerUIState = shader_get_sampler_index(sh_s2h_3d_test, "s_UIState");
uniformResolution = shader_get_uniform(sh_s2h_3d_test, "u_Resolution");
uniformTime = shader_get_uniform(sh_s2h_3d_test, "u_Time");

// uiState = new s2h_UiHandle();

matrixView = matrix_build_identity();
matrixProjection = matrix_build_projection_perspective_fov(45, -room_width / room_height, 1, 32000);
camera_set_proj_mat(view_camera[0], matrixProjection);

matrixClipFromWorld = matrix_build_identity();
matrixWorldFromClip = matrix_build_identity();
matrixWorldFromView = matrix_build_identity();

unfiromClipFromWorld = shader_get_uniform(sh_s2h_3d_test, "u_clipFromWorld");
unfiromWorldFromClip = shader_get_uniform(sh_s2h_3d_test, "u_worldFromClip");
unfiromWorldFromView = shader_get_uniform(sh_s2h_3d_test, "u_worldFromView");

posX = 0;
posY = 3;
posZ = -10;

camAngleX = 0;
camAngleY = 0;

application_surface_draw_enable(false);
gpu_set_texrepeat(true);

window_set_caption("ShaderToHuman - 3D Demo");