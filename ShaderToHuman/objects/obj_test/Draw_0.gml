shader_set(sh_test);
texture_set_stage(shader_get_sampler_index(sh_test, "s2h_fontTexture"), fontTexture);
iMouse.sendUniform(shader_get_uniform(sh_test, "iMouse"));
draw_sprite_stretched(spr_test, 0, 0, 0, room_width, room_height);
shader_reset();
