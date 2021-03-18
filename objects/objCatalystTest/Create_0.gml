/*var Label0 = new Label("Hello!");
global.tt = 0;
with (Label0.Register()) {
	Position.x = 128;
	Position.y = 64;
	Alignment.x = fa_left;
	Alignment.y = fa_middle;
	TextColour.FromCode(c_blue);
	BackColour.FromCode(c_green);

	OnMousePressed = function(e) {
		if (e == mb_left) {
			SetTextColour(c_purple);
			SetText("NICE!");
		}
	}
}

var Label1 = new Label("World!");
with (Label1.Register()) {
	Parent = Label0;
	Anchor.x = fa_center;
	Anchor.y = fa_bottom;
	Alignment.x = fa_center;
}

var Label2 = new Label("Test...");
with (Label2.Register()) {
	Parent = Label1;
	Anchor.x = fa_center;
	Anchor.y = fa_bottom;
	Alignment.x = fa_center;
}*/

var Menu = new MenuStrip();
with (Menu.Register()) {
	AddItem("File", undefined);
	AddItem("Edit", undefined);
	AddItem("Help", undefined);
}