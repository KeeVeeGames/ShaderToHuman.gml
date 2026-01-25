fontTexture = sprite_get_texture(spr_s2h_font, 0);
iMouse = new ShaderMouse();

samplerFontTexture = shader_get_sampler_index(sh_s2h_2d_test, "s2h_fontTexture");
uniformMouse = shader_get_uniform(sh_s2h_2d_test, "u_Mouse");

application_surface_draw_enable(true);
gpu_set_texrepeat(true);

window_set_caption("ShaderToHuman - 2D Demo");