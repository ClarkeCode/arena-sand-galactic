package models;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;

class Level extends FlxObject {
	private var playState:FlxState;

	public function new(state:FlxState) {
		super();
		this.playState = state;
		render();
	}

	function render():Void {}
}
