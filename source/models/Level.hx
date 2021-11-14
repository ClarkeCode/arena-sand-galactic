package models;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.util.FlxColor;

using vendor.FlxOgmoUtils;
using vendor.OgmoUtils;

class Level extends FlxObject {
	private var playState:PlayState;

	public function new(state:PlayState, ?ogmoLoc:String, ?jsonLoc:String, ?tilesLoc:String) {
		super();
		this.playState = state;
		state.bgColor = FlxColor.fromRGB(233, 196, 106);

		// Map loading
		var ogmo = FlxOgmoUtils.get_ogmo_package(ogmoLoc != null ? ogmoLoc : 'assets/data/testzone.ogmo',
			jsonLoc != null ? jsonLoc : 'assets/data/testzone.json');
		FlxG.resizeGame(ogmo.project.levelMinSize.x, ogmo.project.levelMinSize.y);
		state.level.load_tilemap(ogmo, tilesLoc != null ? tilesLoc : 'assets/images/', 'walls');
		state.add(state.level);
		ogmo.level.get_entity_layer('entities').load_entities(state.placeEntities);
	}

	public static function fromLocations(state:PlayState, ogmoLoc:String, jsonLoc:String, tilesLoc:String):Level {
		return new Level(state, ogmoLoc, jsonLoc, tilesLoc);
	}

	function render():Void {}
}
