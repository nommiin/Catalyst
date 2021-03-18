function ControlFind( _name ) {
	for(var i = 0; i < ds_list_size(Catalyst.Controls); i++) {
		var _controlGet = Catalyst.Controls[| i];
		if (_controlGet.Name == _name) {
			return _controlGet;	
		}
	}
	return noone;
}