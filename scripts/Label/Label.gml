function Label( _value ) : CatalystControl("Label") constructor {
	AddProperty("Text", string(_value));
	AddProperty("Font", "Arial");
	AddProperty("FontSize", 9);
	AddProperty("Scale", 1);
	AddProperty("TextColour", new Colour(c_white));
	AddProperty("BackColour", new Colour(0, 0, 0, 0));
	
	// Internal Events
	__OnUpdate = function() {
		draw_set_font(GetFont(Font, FontSize));
		Size.x = string_width(Text);
		Size.y = string_height(Text);
	}
	
	__OnRender = function() {
		if (BackColour.Alpha != 0) {
			draw_clear_alpha(BackColour.ToCode(), BackColour.Alpha);
			gpu_set_blendenable(true);
		}
		var _textColour = TextColour.ToCode(), _textOffset = new Point(0, 0).ApplyAnchor(Alignment, Size.x, Size.y);
		draw_set_font(GetFont(Font, FontSize));
		draw_set_halign(Alignment.x);
		draw_set_valign(Alignment.y);
		draw_text_colour(_textOffset.x, _textOffset.y, Text, _textColour, _textColour, _textColour, _textColour, TextColour.Alpha);
	}
}