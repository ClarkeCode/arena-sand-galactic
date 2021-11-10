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
import models.Player;

using vendor.FlxOgmoUtils;
using vendor.OgmoUtils;

class PlayState extends FlxState {
	public var player:Player;

	private var level:FlxTilemap = new FlxTilemap();

	override public function create() {
		super.create();
		// this.level = new Level(this);
		// add(this.level);
		bgColor = FlxColor.fromRGB(233, 196, 106);

		// Map loading
		var ogmo = FlxOgmoUtils.get_ogmo_package('assets/data/testzone.ogmo', 'assets/data/testzone.json');
		level.load_tilemap(ogmo, 'assets/images/', 'walls');
		add(level);
		ogmo.level.get_entity_layer('entities').load_entities(placeEntities);
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
