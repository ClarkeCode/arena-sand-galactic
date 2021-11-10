package models;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.input.actions.FlxAction.FlxActionDigital;
import flixel.input.actions.FlxActionManager;
import flixel.math.FlxAngle;
import flixel.math.FlxPoint;
import flixel.math.FlxVector;
import flixel.math.FlxVelocity;
import flixel.util.FlxColor;

class Reticle extends FlxSprite {
	public var distanceFromPlayer:Float;

	var angleFromPlayer:Float;
	var _player:Player;

	public function new(X:Float, Y:Float, player:Player, state:PlayState) {
		super(X, Y);
		makeGraphic(5, 5, FlxColor.fromRGB(255, 40, 40));
		distanceFromPlayer = 60;
		angleFromPlayer = 0;
		this._player = player;
		state.add(this);
	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);
		x = FlxG.mouse.x;
		y = FlxG.mouse.y;
		var playerDifference:FlxVector = new FlxVector(x - _player.x, y - _player.y);
		var scaleFactor:Float = distanceFromPlayer / playerDifference.length;
		playerDifference = playerDifference.scale(scaleFactor);
		playerDifference.add(_player.x + _player.origin.x, _player.y + _player.origin.y);
		x = playerDifference.x;
		y = playerDifference.y;
	}
}
