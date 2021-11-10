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
class Player extends FlxSprite {
	static inline var VISUAL_SIZE:Int = 32;
	// Pixels per second
	static inline var SPEED:Int = 110;
	static inline var JUMP_STRENGTH:Float = 200;

	static var actions:FlxActionManager;

	var up:FlxActionDigital;
	var down:FlxActionDigital;
	var left:FlxActionDigital;
	var right:FlxActionDigital;

	var jump:FlxActionDigital;

	public var isJumping:Bool = false;

	// Time since last jump in seconds
	var timeSinceJump:Float = 0;
	var numJumps = 0;
	var maxJumps = 3;

	public var reticle:Reticle;

	// Per-player gravity in case we want to have gravity altering fields etc
	// Currently only pulls downward
	// Gravity should probably be initially set by the level
	public var gravity:Float = 200;

	public function new(X:Int, Y:Int, state:PlayState) {
		super(X, Y);
		makeGraphic(VISUAL_SIZE, VISUAL_SIZE, FlxColor.fromRGB(70, 117, 143));
		addInputs();
		state.add(this);
		reticle = new Reticle(x, y, this, state);
	}

	// TODO: move controller code into a separate file
	function addInputs():Void {
		// digital actions allow for on/off directional movement
		up = new FlxActionDigital();
		down = new FlxActionDigital();
		left = new FlxActionDigital();
		right = new FlxActionDigital();
		jump = new FlxActionDigital();

		if (actions == null)
			actions = FlxG.inputs.add(new FlxActionManager());
		actions.addActions([up, down, left, right, jump]);

		// Add keyboard inputs
		up.addKey(UP, PRESSED);
		up.addKey(W, PRESSED);
		down.addKey(DOWN, PRESSED);
		down.addKey(S, PRESSED);
		left.addKey(LEFT, PRESSED);
		left.addKey(A, PRESSED);
		right.addKey(RIGHT, PRESSED);
		right.addKey(D, PRESSED);

		jump.addKey(SPACE, PRESSED);
	}

	function landOnGround() {
		acceleration.y = 0;
		isJumping = false;
		timeSinceJump = 0;
		numJumps = maxJumps;
	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);
		// Gravity
		acceleration.y = gravity;

		if (left.triggered) {
			velocity.x = -SPEED;
		}
		else if (right.triggered) {
			velocity.x = SPEED;
		}
		else if (!left.triggered && !right.triggered) {
			velocity.x = 0;
		}

		// Jump related controls
		if (isJumping && !jump.triggered) {
			isJumping = false;
			timeSinceJump = 0;
		}

		if (numJumps != 0 && timeSinceJump >= 0 && jump.triggered) {
			if (timeSinceJump == 0)
				numJumps--;
			isJumping = true;
			timeSinceJump += elapsed;
		}
		else {
			timeSinceJump = -1;
		}

		if (timeSinceJump > 0 && timeSinceJump < 0.5) {
			velocity.y = -JUMP_STRENGTH;
		}

		// // FlxVelocity.moveTowardsMouse(this, 30);

		// TODO: hack to give a "floor" until level collision is fixed
		if (y > FlxG.height - 65) {
			y = FlxG.height - 65;
			landOnGround();
		}

		// if (moveX != 0 && moveY != 0)
		// {
		// 	moveX *= .707;
		// 	moveY *= .707;
		// }

		reticle.update(elapsed);
	}
}
