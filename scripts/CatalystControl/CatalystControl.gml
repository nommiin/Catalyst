function CatalystControl( _type ) constructor {
	// Members
	Name = undefined;
	Parent = undefined;
	Type = _type;
	Identifier = Catalyst.ControlIndex++;
	Registered = false;
	
	// Logic
	Position = new Point(0, 0);
	__Position = new Point(0, 0);
	Size = new Point(0, 0);
	Anchor = new Point(fa_left, fa_top);
	Alignment = new Point(fa_left, fa_top);
	Overlap = false;
	Inputs = [mb_left, mb_middle, mb_right];
	
	// Rendering
	Order = 0;
	Dirty = true;
	Visible = false;
	Surface = -1;
	
	// Events
	OnUpdate = undefined;
	OnRender = undefined;
	OnEnter = undefined;
	OnExit = undefined;
	OnHover = undefined;
	OnMousePressed = undefined;
	OnMouseReleased = undefined;
	OnMouseHeld = undefined;
	
	// Internal Events
	_OnUpdate = function() {
		if (point_in_rectangle(window_mouse_get_x(), window_mouse_get_y(), __Position.x, __Position.y, __Position.x + Size.x, __Position.y + Size.y) == true) {
			if (__OnHover != undefined) __OnHover();
			if (OnHover != undefined) OnHover();
			if (Overlap == false) {
				if (__OnEnter != undefined) __OnEnter();
				if (OnEnter != undefined) OnEnter();
				Overlap = true;	
			}
			
			for(var i = 0; i < array_length(Inputs); i++) {
				var _inputGet = Inputs[i];
				if (mouse_check_button_pressed(_inputGet) == true) {
					if (__OnMousePressed != undefined) __OnMousePressed(_inputGet);	
					if (OnMousePressed != undefined) OnMousePressed(_inputGet);	
				}
				if (mouse_check_button_released(_inputGet) == true) {
					if (__OnMouseReleased != undefined) __OnMouseReleased(_inputGet);	
					if (OnMouseReleased != undefined) OnMouseReleased(_inputGet);	
				}
				if (mouse_check_button(_inputGet) == true) {
					if (__OnMouseHeld != undefined) __OnMouseHeld(_inputGet);	
					if (OnMouseHeld != undefined) OnMouseHeld(_inputGet);	
				}
			}
		} else {
			if (Overlap == true) {
				if (__OnExit != undefined) __OnExit();
				if (OnExit != undefined) OnExit();
				Overlap = false;	
			}
		}
	}
	
	for(var i = 0, _i = variable_struct_get_names(self); i < array_length(_i); i++) {
		if (string_copy(_i[i], 1, 2) == "On") {
			variable_struct_set(self, "__" + _i[i], undefined);	
		}
	}
	
	// Methods
	static Register = function() {
		ds_list_insert(Catalyst.Controls, Identifier, self);
		Name = Type + string(Identifier);
		Registered = true;
		Visible = (__OnRender != undefined || OnRender != undefined);
		return self;
	}
	
	static AddProperty = function( _name, _default ) {
		self[$ _name] = _default;
		self[$ "Set" + _name] = method({
			Identifier: self.Identifier,
			Property: _name,
			Value: _default,
			IsStruct: (is_struct(_default) == true)
		}, method_get_index(SetProperty));
	}
	
	static SetProperty = function( _value ) {
		var _propertyChanged = false;
		if (is_struct(self.Value) == true) _propertyChanged = self.Value.IsEqual(_value) == false;
		else if (is_array(self.Value) == true) _propertyChanged = array_equals(self.Value, _value) == false;
		else _propertyChanged = (self.Value != _value);
		if (_propertyChanged == true) {
			self.Value = _value;
			with (Catalyst.Controls[| self.Identifier]) {
				show_debug_message(Name + "." + other.Property + " has changed");
				self.Dirty = true;
				self[$ other.Property] = _value;
			}
		}
	}
	
	static GetFont = function( _name, _size ) {
		var _fontGet = Catalyst.FontCache[$ _name];
		if (_fontGet != undefined) {
			_fontGet = _fontGet[$ _size];
			if (_fontGet != undefined) {
				return _fontGet;	
			} else return CacheFont(_name, _size, 1);
		} else return CacheFont(_name, _size, 0);
	}
	
	static CacheFont = function( _name, _size, _stage ) {
		var _fontCreate = font_add(_name, _size, false, false, 32, 128);
		if (_stage == 0) Catalyst.FontCache[$ _name] = {};
		Catalyst.FontCache[$ _name][$ _size] = _fontCreate;
		return _fontCreate;
	}
}