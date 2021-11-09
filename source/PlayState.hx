package;

import flixel.FlxState;

class PlayState extends FlxState
{
	public var player:Player;

	override public function create()
	{
		super.create();
		var text = new flixel.text.FlxText(0, 0, 0, "Hello World", 64);
		text.screenCenter();
		add(text);

		this.player = new Player(50, 50);
		add(this.player);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		player.update(elapsed);
	}

	override public function destroy():Void
	{
		super.destroy();
		player = null;
	}
}
