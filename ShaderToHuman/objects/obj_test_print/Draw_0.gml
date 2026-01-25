draw_sprite_tiled(spr_background, 0, room_width / 2 + current_time / 20, room_height / 2 + current_time / 20);

var width = room_width / 2 - 20;
var height = room_height / 3 - 20;

shader_set(sh_s2h_printInt_test);
texture_set_stage(shader_get_sampler_index(sh_s2h_printInt_test, "s2h_fontTexture"), fontTexture);
shader_set_uniform_f(shader_get_uniform(sh_s2h_printInt_test, "u_Resolution"), width, height);
draw_sprite_stretched_ext(spr_test, 0, 10, 10, width, height, c_black, 0.5);
shader_reset();

shader_set(sh_s2h_printHex_test);
texture_set_stage(shader_get_sampler_index(sh_s2h_printHex_test, "s2h_fontTexture"), fontTexture);
shader_set_uniform_f(shader_get_uniform(sh_s2h_printHex_test, "u_Resolution"), width, height);
draw_sprite_stretched_ext(spr_test, 0, 10, 115, width, height, c_black, 0.5);
shader_reset();

shader_set(sh_s2h_printFloat_test);
texture_set_stage(shader_get_sampler_index(sh_s2h_printFloat_test, "s2h_fontTexture"), fontTexture);
shader_set_uniform_f(shader_get_uniform(sh_s2h_printFloat_test, "u_Resolution"), width, height);
draw_sprite_stretched_ext(spr_test, 0, room_width / 2 + 10, 10, width, height, c_black, 0.5);
shader_reset();

shader_set(sh_s2h_printShapes_test);
texture_set_stage(shader_get_sampler_index(sh_s2h_printShapes_test, "s2h_fontTexture"), fontTexture);
shader_set_uniform_f(shader_get_uniform(sh_s2h_printShapes_test, "u_Resolution"), width, height);
draw_sprite_stretched_ext(spr_test, 0, room_width / 2 + 10, 115, width, height, c_black, 0.5);
shader_reset();

shader_set(sh_s2h_printIntro_test);
texture_set_stage(shader_get_sampler_index(sh_s2h_printIntro_test, "s2h_fontTexture"), fontTexture);
shader_set_uniform_f(shader_get_uniform(sh_s2h_printIntro_test, "u_Resolution"), width * 2 + 20, height);
draw_sprite_stretched_ext(spr_test, 0, room_width / 2 - width - 10, 220, width * 2 + 20, height, c_black, 0.5);
shader_reset();