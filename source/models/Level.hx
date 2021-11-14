package models;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;

using vendor.FlxOgmoUtils;
using vendor.OgmoUtils;

class Level extends FlxObject {
	private var playState:PlayState;

	public function new(state:PlayState) {
		super();
		this.playState = state;
		state.bgColor = FlxColor.fromRGB(233, 196, 106);

		// Map loading
		var ogmo = FlxOgmoUtils.get_ogmo_package('assets/data/testzone.ogmo', 'assets/data/testzone.json');
		state.level.load_tilemap(ogmo, 'assets/images/', 'walls');
		state.add(state.level);
		ogmo.level.get_entity_layer('entities').load_entities(state.placeEntities);
	}

	function render():Void {}
}
