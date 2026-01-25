iMouse.update(mouse_check_button(mb_left), mouse_x, mouse_y, false);

#region 3D camera controls

if (mouse_check_button(mb_left)) {
    camAngleX += window_mouse_get_delta_x() / 100;
    camAngleY += window_mouse_get_delta_y() / 100;
}

var sx = sin(camAngleX);
var cx = cos(camAngleX);
var sy = sin(camAngleY);
var cy = cos(camAngleY);

var velX = (keyboard_check(ord("D")) - keyboard_check(ord("A"))) / 10;
var velZ = (keyboard_check(ord("S")) - keyboard_check(ord("W"))) / 10;
var velY = (keyboard_check(ord("E")) - keyboard_check(ord("Q"))) / 10;

posX += velX * cx - velZ * sx * cy;
posZ += -velX * sx - velZ * cx * cy;
posY += velY - velZ * sy;

#endregion

#region Camera setting and s2h matrices setting

matrix_build_lookat(posX, posY, posZ, posX + sx * cy, posY + sy, posZ + cx * cy, 0, -1, 0, matrixView);

camera_set_view_mat(view_camera[0], matrixView);

matrix_multiply(matrixView, matrixProjection, matrixClipFromWorld);
matrix_inverse(matrixClipFromWorld, matrixWorldFromClip);
matrix_inverse(matrixView, matrixWorldFromView);

#endregion