function Button( _value, _size ) : CatalystControl("Button") constructor {
	AddProperty("Text", string(_value));
	AddProperty("Font", "MS Sans Serif");
	AddProperty("FontSize", 9);
	AddProperty("TextScale", 1);
	AddProperty("TextAlignment", new Point(fa_center, fa_middle));
	Size = _size;
	
	// Visual
	AddProperty("TextColour", new Colour(0, 0, 0, 1));
	AddProperty("BackColour", new Colour(225, 225, 225, 1));
	AddProperty("BorderColour", new Colour(173, 173, 173, 1));
	AddProperty("BackColourDefault", new Colour(225, 225, 225, 1));
	AddProperty("BorderColourDefault", new Colour(173, 173, 173, 1));
	AddProperty("BackColourHover", new Colour(229, 241, 251, 1));
	AddProperty("BorderColourHover", new Colour(0, 120, 215, 1));
	AddProperty("BackColourPress", new Colour(204, 228, 247, 1));
	AddProperty("BorderColourPress", new Colour(0, 84, 153, 1));
	AddProperty("BorderSize", 1);
	
	// Internal Events
	__OnHover = function() {
		SetBackColour(BackColourHover);
		SetBorderColour(BorderColourHover);
	}
	
	__OnExit = function() {
		SetBackColour(BackColourDefault);
		SetBorderColour(BorderColourDefault);
	}
	
	__OnMouseHeld = function( e ) {
		if (e == mb_left) {
			SetBackColour(BackColourPress);
			SetBorderColour(BorderColourPress);
		}
	}
	
	__OnRender = function() {
		var _borderColour = BorderColour.ToCode(), _backColour = BackColour.ToCode();
		draw_set_alpha(BorderColour.Alpha);
		draw_rectangle_colour(0, 0, Size.x, Size.y, _borderColour, _borderColour, _borderColour, _borderColour, false);
		draw_set_alpha(BackColour.Alpha);
		draw_rectangle_colour(BorderSize, BorderSize, (Size.x - 1) - BorderSize, (Size.y - 1) - BorderSize, _backColour, _backColour, _backColour, _backColour, false);
		var _textOffset = new Point(0, 0).ApplyAnchor(TextAlignment, Size.x, Size.y), _textColour = TextColour.ToCode();
		draw_set_halign(TextAlignment.x);
		draw_set_valign(TextAlignment.y);
		draw_set_font(GetFont(Font, FontSize));
		gpu_set_blendenable(true);
		draw_text_color(_textOffset.x, _textOffset.y, Text, _textColour, _textColour, _textColour, _textColour, TextColour.Alpha);
	}
}