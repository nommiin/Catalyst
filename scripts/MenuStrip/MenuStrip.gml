function MenuStrip() : CatalystControl("MenuStrip") constructor {
	AddProperty("Items", []);
	AddProperty("Spacing", 16);
	AddProperty("Font", "MS Sans Serif");
	AddProperty("FontSize", 9);
	AddProperty("Scale", 1);
	AddProperty("TextColour", new Colour(c_black));
	AddProperty("BackColour", new Colour(c_white));
	AddProperty("HoverColour", new Colour(c_ltgray));
	AddProperty("HoverPadding", 6);
	Size = new Point(window_get_width(), 24);
	Hover = -1;
	
	// Internal Events
	__OnUpdate = function() {
		var _hoverGet = GetHover();
		if (_hoverGet != Hover) {
			Hover = _hoverGet;
			Dirty = true;
		}
	}
	
	__OnRender = function( _width, _height ) {
		Size.x = _width;
		Size.y = 24 * Scale;
		draw_clear_alpha(BackColour.ToCode(), BackColour.Alpha);
		gpu_set_blendenable(true);
		draw_set_font(GetFont(Font, FontSize));
		draw_set_halign(fa_left);
		draw_set_valign(fa_middle);
		var _menuOffset = Spacing / 2, _menuColour = TextColour.ToCode();
		for(var i = 0; i < array_length(Items); i++) {
			var _itemGet = Items[i], _itemWidth = string_width(_itemGet.Text) * Scale;
			if (Hover == i) {
				var _hoverColour = HoverColour.ToCode();
				draw_set_alpha(HoverColour.Alpha);
				draw_rectangle_colour(_menuOffset - (HoverPadding * Scale), 0, (_menuOffset + _itemWidth) + (HoverPadding * Scale), Size.y, _hoverColour, _hoverColour, _hoverColour, _hoverColour, false);
				draw_set_alpha(1);
			}
			draw_text_transformed_colour(_menuOffset, Size.y / 2, _itemGet.Text, Scale, Scale, 0, _menuColour, _menuColour, _menuColour, _menuColour, TextColour.Alpha);
			_menuOffset += _itemWidth + (Spacing * Scale);
		}
	}
	
	// Methods
	static AddItem = function( _text, _callback ) {
		array_push(Items, {
			Text: _text,
			Hover: false,
			Callback: _callback
		});
	}
	
	static GetHover = function() {
		draw_set_font(GetFont(Font, FontSize));
		var _menuOffset = Spacing / 2;
		for(var i = 0; i < array_length(Items); i++) {
			var _itemGet = Items[i], _itemWidth = string_width(_itemGet.Text) * Scale;
			if (point_in_rectangle(window_mouse_get_x(), window_mouse_get_y(), _menuOffset - (HoverPadding * Scale), 0, (_menuOffset + _itemWidth) + (HoverPadding * Scale), Size.y) == true) {
				return i;	
			}
			_menuOffset += _itemWidth + (Spacing * Scale);
		}
		return -1;
	}
}