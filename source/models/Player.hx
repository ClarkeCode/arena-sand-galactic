package models;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.input.actions.FlxAction.FlxActionDigital;
import flixel.input.actions.FlxActionManager;
import flixel.math.FlxPoint;
import flixel.math.FlxVector;
import flixel.math.FlxVelocity;
import flixel.text.FlxText;
import flixel.util.FlxColor;

// Adapted from https://github.com/HaxeFlixel/flixel-demos/blob/master/Input/FlxAction/source/Player.hx
class Player extends FlxSprite {
	static inline var VISUAL_SIZE:Int = 16;
	// Pixels per second
	static inline var SPEED:Int = 110;
	static inline var JUMP_STRENGTH:Float = 200;

	var _state:PlayState;

	static var actions:FlxActionManager;

	var up:FlxActionDigital;
	var down:FlxActionDigital;
	var left:FlxActionDigital;
	var right:FlxActionDigital;
	var jump:FlxActionDigital;
	var fire:FlxActionDigital;

	public var isJumping:Bool = false;

	// Time spent holding the jump button in seconds
	var jumpHangTime:Float = 0;
	var numJumps = 0;
	var maxJumps = 3;

	public var reticle:Reticle;
	public var bullets:FlxTypedGroup<FlxSprite>;

	// Per-player gravity in case we want to have gravity altering fields etc
	// Currently only pulls downward
	// Gravity should probably be initially set by the level
	public var gravity:Float = 200;

	// For debug
	var DEBUG = false;
	var dbgtext = new FlxText(0, 0, 0, "", 20);

	public function new(X:Int, Y:Int, state:PlayState) {
		super(X, Y);
		makeGraphic(VISUAL_SIZE, VISUAL_SIZE, FlxColor.fromRGB(70, 117, 143));
		addInputs();

		if (DEBUG) {
			state.add(dbgtext);
		}
		state.add(this);
		reticle = new Reticle(x, y, this, state);

		bullets = new FlxTypedGroup<FlxSprite>();
		state.add(bullets);
		_state = state;
	}

	// TODO: move controller code into a separate file
	function addInputs():Void {
		// digital actions allow for on/off directional movement
		up = new FlxActionDigital();
		down = new FlxActionDigital();
		left = new FlxActionDigital();
		right = new FlxActionDigital();
		jump = new FlxActionDigital();
		fire = new FlxActionDigital();

		if (actions == null)
			actions = FlxG.inputs.add(new FlxActionManager());
		actions.addActions([up, down, left, right, jump, fire]);

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
		fire.addMouse(LEFT, JUST_PRESSED);
	}

	public function landOnGround(e:Dynamic, e2:Dynamic) {
		acceleration.y = 0;
		isJumping = false;
		jumpHangTime = 0;
		numJumps = maxJumps;
	}

	override public function kill() {
		// TODO: implement death behaviour here
	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);
		// Gravity
		acceleration.y = gravity;

		// Horizontal movement
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
		// If you were jumping and let go of the jump button
		if (isJumping && !jump.triggered) {
			isJumping = false;
			jumpHangTime = 0;
		}
		// Initial jumping
		if (numJumps >= 1 && jump.triggered && jumpHangTime == 0) {
			isJumping = true;
			jumpHangTime += elapsed;
			numJumps--;
			velocity.y = -JUMP_STRENGTH;
		}
		// Holding the jump button mid-jump
		else if (isJumping && jump.triggered && jumpHangTime <= 0.5) {
			velocity.y = -JUMP_STRENGTH;
			jumpHangTime += elapsed;
		}

		if (fire.triggered) {
			var bullet = new Projectile(x, y);
			bullet.makeGraphic(4, 4, FlxColor.PURPLE);
			bullet.fireAtPosition(x + origin.x, y + origin.y, FlxG.mouse.x, FlxG.mouse.y);
			bullets.add(bullet);
		}
		// // FlxVelocity.moveTowardsMouse(this, 30);

		// if (moveX != 0 && moveY != 0)
		// {
		// 	moveX *= .707;
		// 	moveY *= .707;
		// }

		bullets.update(elapsed);

		if (DEBUG) {
			var buff = new StringBuf();
			buff.add("IsJumping: ");
			buff.add(isJumping);
			buff.add("\nJumps: ");
			buff.add(numJumps);
			buff.add("\nFire?: ");
			buff.add(fire.triggered);
			dbgtext.text = buff.toString();
		}

		reticle.update(elapsed);
	}
}
