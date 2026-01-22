gpu_set_blendenable(false);

shader_set(sh_s2h_ui_test);
texture_set_stage(samplerFontTexture, fontTexture);
iMouse.sendUniform(uniformMouse);
s2h_ui_set_state(uiState, samplerUIState, uniformResolution);
s2h_ui_draw_surface(application_surface, 0, 0);
s2h_ui_reset_state();
shader_reset();

gpu_set_blendenable(true);