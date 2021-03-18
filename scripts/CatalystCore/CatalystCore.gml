#macro Catalyst global.__CatalystCore__
#macro CatalystVisualizeRedraw true
#macro CatalystVisualizeBounds false
Catalyst = {
	Controls: ds_list_create(),
	ControlOrder: ds_priority_create(),
	ControlRender: ds_stack_create(),
	ControlIndex: 0,
	FontCache: {},
	Redraw: (CatalystVisualizeRedraw == true ? [] : undefined),
	Bounds: (CatalystVisualizeBounds == true ? [] : undefined),
	Update: function( _width, _height ) {
		if (CatalystVisualizeBounds == true) Bounds = [];
		for(var i = 0; i < ds_list_size(Controls); i++) {
			with (Controls[| i]) {
				ds_priority_add(other.ControlOrder, self, self.Order);	
				__Position.Copy(Position);
				if (Parent != undefined) {
					__Position.x += Parent.__Position.x;
					__Position.y += Parent.__Position.y;
					__Position.ApplyAnchor(Anchor, Parent.Size.x, Parent.Size.y);
				} else __Position.ApplyAnchor(Anchor, _width, _height);
				__Position.ApplyAnchor(Alignment, -Size.x, -Size.y);
			}
		}
		
		while (ds_priority_size(ControlOrder) > 0) {
			with (ds_priority_delete_min(ControlOrder)) {
				_OnUpdate();
				if (__OnUpdate != undefined) __OnUpdate();
				if (OnUpdate != undefined) OnUpdate();
				if (Visible == true) ds_stack_push(other.ControlRender, self);
			}
		}
	},
	Render: function( _width, _height ) {
		var __width = display_get_gui_width(), __height = display_get_gui_height();
		display_set_gui_size(_width, _height);
		while (ds_stack_size(ControlRender) > 0) {
			with (ds_stack_pop(ControlRender)) {
				if (surface_exists(Surface) == true) {
					if (surface_get_width(Surface) != Size.x || surface_get_height(Surface) != Size.y) {
						surface_free(Surface);
					}
				}
				
				if (surface_exists(Surface) == false) {
					Surface = surface_create(Size.x, Size.y);
					Dirty = true;
				}
				
				if (Dirty == true) {
					if (CatalystVisualizeRedraw == true) {
						array_push(other.Redraw, {
							Time: 10,
							Position: new Point(__Position.x, __Position.y),
							Size: new Point(Size.x, Size.y)
						});
						show_debug_message(Name + " was redrawn");
					}
					surface_set_target(Surface);
					draw_clear_alpha(0, 0);
					gpu_set_blendenable(false);
					if (__OnRender != undefined) __OnRender(_width, _height);
					if (OnRender != undefined) OnRender(_width, _height);
					gpu_set_blendenable(true);
					surface_reset_target();
					Dirty = false;
				}
				draw_surface(Surface, __Position.x, __Position.y);
			}
		}
		
		if (CatalystVisualizeRedraw == true) {
			for(var i = 0; i < array_length(Catalyst.Redraw); i++) {
				var _data = Catalyst.Redraw[i];
				draw_set_alpha(_data.Time-- / 10);
				draw_rectangle_color(_data.Position.x, _data.Position.y, _data.Position.x + _data.Size.x, _data.Position.y + _data.Size.y, c_red, c_red, c_red, c_red, false);
				draw_set_alpha(1);
				if (_data.Time <= 0) {
					array_delete(Catalyst.Redraw, i--, 1);	
				}
			}
		}
		
		if (CatalystVisualizeBounds == true) {
			draw_set_alpha(0.25);
			for(var i = 0; i < array_length(Catalyst.Bounds); i++) {
				var _boundsGet = Catalyst.Bounds[i];
				draw_rectangle_color(_boundsGet[0], _boundsGet[1], _boundsGet[2], _boundsGet[3], c_lime, c_lime, c_lime, c_lime, false);
				draw_rectangle_color(_boundsGet[0] + 2, _boundsGet[1] + 2, _boundsGet[2] - 3, _boundsGet[3] - 3, c_purple, c_purple, c_purple, c_purple, false);
			}
			draw_set_alpha(1);
		}
		
		display_set_gui_size(__width, __height);
	}
};

#macro __point_in_rectangle point_in_rectangle
#macro point_in_rectangle CT_point_in_rectangle
function CT_point_in_rectangle() {
	if (CatalystVisualizeBounds == true) {
		array_push(Catalyst.Bounds, [argument[2], argument[3], argument[4], argument[5]]);
	}
	return __point_in_rectangle(argument[0], argument[1], argument[2], argument[3], argument[4], argument[5]);
}