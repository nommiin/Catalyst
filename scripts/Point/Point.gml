function Point( _x, _y ) constructor {
	x = _x;
	y = _y;
	
	static Copy = function( _target ) {
		x = _target.x;
		y = _target.y;
		return self;
	}
	
	static ApplyAnchor = function( _anchor, _w, _h ) {
		switch (_anchor.x) {
			case fa_center: {
				x += _w / 2;
				break;	
			}
			
			case fa_right: {
				x += _w;
				break;	
			}
		}
		
		switch (_anchor.y) {
			case fa_middle: {
				y += _h / 2;
				break;	
			}
			
			case fa_bottom: {
				y += _h;
				break;	
			}
		}
		return self;
	}
	
	static IsEqual = function( _point ) {
		if (x == _point.x && y == _point.y) return true;
		return false;
	}
}