shader_set(sh_s2h_2d_test);
texture_set_stage(samplerFontTexture, fontTexture);
iMouse.sendUniform(uniformMouse);
draw_sprite_tiled(spr_background, 0, room_width / 2 + current_time / 20, room_height / 2 + current_time / 20);
shader_reset();