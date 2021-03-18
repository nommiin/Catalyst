function Panel( _size ) : CatalystControl("Panel") constructor {
	AddProperty("BackColour", new Colour(0, 0, 0, 0));
	Size = _size;
	
	// Internal Events
	__OnRender = function() {
		if (BackColour.Alpha != 0) {
			var _backColour = BackColour.ToCode();
			draw_set_alpha(BackColour.Alpha);
			draw_rectangle_colour(0, 0, Size.x, Size.y, _backColour, _backColour, _backColour, _backColour, false);
		}
	}
}