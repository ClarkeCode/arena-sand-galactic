package models;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;

using flixel.util.FlxSpriteUtil;
using vendor.FlxOgmoUtils;
using vendor.OgmoUtils;

class Camera extends FlxObject {
	static var LEVEL_MIN_X:Float;
	static var LEVEL_MAX_X:Float;
	static var LEVEL_MIN_Y:Float;
	static var LEVEL_MAX_Y:Float;

	public function new(state:PlayState) {
        super();
		LEVEL_MIN_X = -FlxG.stage.stageWidth;
		LEVEL_MAX_X = FlxG.stage.stageWidth;
		LEVEL_MIN_Y = -FlxG.stage.stageHeight;
		LEVEL_MAX_Y = FlxG.stage.stageHeight;
        
		FlxG.camera.setScrollBoundsRect(LEVEL_MIN_X, LEVEL_MIN_Y, LEVEL_MAX_X + Math.abs(LEVEL_MIN_X), LEVEL_MAX_Y + Math.abs(LEVEL_MIN_Y), true);
		FlxG.camera.zoom = 1.3;
		FlxG.camera.follow(state.player, PLATFORMER, 1);
	}
}
