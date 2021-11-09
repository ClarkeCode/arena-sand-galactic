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

class Reticle extends FlxSprite
{
	public var distanceFromPlayer:Float;

	var angleFromPlayer:Float;
	var _player:Player;

	public function new(X:Float, Y:Float, player:Player)
	{
		super(X, Y);
		makeGraphic(5, 5, FlxColor.fromRGB(255, 40, 40));
		distanceFromPlayer = 60;
		angleFromPlayer = 0;
		this._player = player;
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		angleFromPlayer = FlxAngle.angleBetweenMouse(_player);
		var newPosition:FlxVector = new FlxVector();
		newPosition = newPosition.add(_player.x + distanceFromPlayer, _player.y);
		newPosition.rotate(FlxPoint.get(_player.x, _player.y), angleFromPlayer);

		x = newPosition.x;
		y = newPosition.y;
	}
}
