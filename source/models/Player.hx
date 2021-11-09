package models;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.input.actions.FlxAction.FlxActionDigital;
import flixel.input.actions.FlxActionManager;
import flixel.math.FlxPoint;
import flixel.math.FlxVector;
import flixel.math.FlxVelocity;
import flixel.util.FlxColor;

// Adapted from https://github.com/HaxeFlixel/flixel-demos/blob/master/Input/FlxAction/source/Player.hx
class Player extends FlxSprite
{
	static inline var VISUAL_SIZE:Int = 32;
	static inline var SPEED:Int = 2;

	static var actions:FlxActionManager;

	var up:FlxActionDigital;
	var down:FlxActionDigital;
	var left:FlxActionDigital;
	var right:FlxActionDigital;

	var moveX:Float = 0;
	var moveY:Float = 0;

	var position:FlxPoint;
	var vel:FlxVelocity;

	var reticle:Reticle;

	public function new(X:Int, Y:Int)
	{
		super(X, Y);
		makeGraphic(VISUAL_SIZE, VISUAL_SIZE, FlxColor.fromRGB(42, 157, 143));
		addInputs();
		reticle = new Reticle(x, y, this);
	}

	function addInputs():Void
	{
		// digital actions allow for on/off directional movement
		up = new FlxActionDigital();
		down = new FlxActionDigital();
		left = new FlxActionDigital();
		right = new FlxActionDigital();

		if (actions == null)
			actions = FlxG.inputs.add(new FlxActionManager());
		actions.addActions([up, down, left, right]);

		// Add keyboard inputs
		up.addKey(UP, PRESSED);
		up.addKey(W, PRESSED);
		down.addKey(DOWN, PRESSED);
		down.addKey(S, PRESSED);
		left.addKey(LEFT, PRESSED);
		left.addKey(A, PRESSED);
		right.addKey(RIGHT, PRESSED);
		right.addKey(D, PRESSED);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		velocity.x = 0;
		velocity.y = 0;

		x += moveX * SPEED;
		y += moveY * SPEED;
		// FlxVelocity.moveTowardsMouse(this, 30);
		moveX = 0;
		moveY = 0;

		updateDigital();
		reticle.update(elapsed);
	}

	function updateDigital():Void
	{
		if (down.triggered)
		{
			moveY = 1;
		}
		else if (up.triggered)
		{
			moveY = -1;
		}
		if (left.triggered)
		{
			moveX = -1;
		}
		else if (right.triggered)
		{
			moveX = 1;
		}

		if (moveX != 0 && moveY != 0)
		{
			moveX *= .707;
			moveY *= .707;
		}
	}
}
