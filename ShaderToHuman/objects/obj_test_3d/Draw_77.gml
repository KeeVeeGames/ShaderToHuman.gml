gpu_set_blendenable(false);

shader_set(sh_s2h_3d_test);
texture_set_stage(samplerFontTexture, fontTexture);
// iMouse.sendUniform(uniformMouse);
shader_set_uniform_f_array(unfiromClipFromWorld, matrixClipFromWorld);
shader_set_uniform_f_array(unfiromWorldFromClip, matrixWorldFromClip);
shader_set_uniform_f_array(unfiromWorldFromView, matrixWorldFromView);
shader_set_uniform_f(uniformResolution, surface_get_width(application_surface), surface_get_height(application_surface));
shader_set_uniform_f(uniformTime, current_time / 1000);
// s2h_ui_set_state(uiState, samplerUIState, uniformResolution);
// s2h_ui_draw_surface(application_surface, 0, 0);
draw_surface(application_surface, 0, 0);
// s2h_ui_reset_state();
shader_reset();

gpu_set_blendenable(true);