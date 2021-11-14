package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.tile.FlxTilemap;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import flixel.util.FlxColor;
import models.Level;
import models.Player;

class PlayState extends FlxState {
	public var player:Player;

	public var level:FlxTilemap = new FlxTilemap();

	override public function create() {
		super.create();
		new Level(this);
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
		if (player != null) {
			player.update(elapsed);
			FlxG.collide(level, player, player.landOnGround);
		}
	}

	override public function destroy():Void {
		super.destroy();
		player = null;
	}

	public function placeEntities(e:EntityData) {
		if (e.name == "player") {
			add(player = new Player(e.x, e.y, this));
		}
	}
}
