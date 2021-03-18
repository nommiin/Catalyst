function Colour( _r, _g, _b, _a ) constructor {
	static FromCode = function( _colour ) {
		Red = _colour & 255;
		Green = (_colour >> 8) & 255;
		Blue = (_colour >> 16) & 255;
		Alpha = 1;
		return self;
	}
	
	static ToCode = function() {
		return (Blue << 16 | Green << 8 | Red);	
	}
	
	if (_g == undefined) {
		FromCode(_r);
	} else {
		Red = _r;
		Green = _g;
		Blue = _b;
		Alpha = _a;	
	}
	
	static IsEqual = function( _colour ) {
		if (Red != _colour.Red) return false;
		if (Green != _colour.Green) return false;
		if (Blue != _colour.Blue) return false;
		if (Alpha != _colour.Alpha) return false;
		return true;
	}
}