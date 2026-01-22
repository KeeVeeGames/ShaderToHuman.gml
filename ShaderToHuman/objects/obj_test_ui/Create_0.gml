fontTexture = sprite_get_texture(spr_s2h_font, 0);
iMouse = new ShaderMouse();

samplerFontTexture = shader_get_sampler_index(sh_s2h_ui_test, "s2h_fontTexture");
uniformMouse = shader_get_uniform(sh_s2h_ui_test, "u_Mouse");
samplerUIState = shader_get_sampler_index(sh_s2h_ui_test, "s_UIState");
uniformResolution = shader_get_uniform(sh_s2h_ui_test, "u_Resolution");

uiState = new s2h_UiHandle();

application_surface_draw_enable(false);
gpu_set_texrepeat(true);