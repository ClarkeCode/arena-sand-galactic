package models;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxPoint;

class ProjectileAttributes {
	public var baseDamage:Float = 1;
	public var projectileMaxHP:Int = 1;
	public var startingX:Float = 0;
	public var startingY:Float = 0;

	public function new(?damage:Int) {}

	public function setStartPosition(X:Float, Y:Float) {
		startingX = X;
		startingY = Y;
	}
}

class Projectile extends FlxSprite {
	public var attributes:ProjectileAttributes;

	public function new(X:Float, Y:Float, vel:FlxPoint, ?acc:FlxPoint, ?attr:ProjectileAttributes) {
		super(X, Y);
		velocity = vel;
		acceleration = acc;
		attributes = attr;
		attributes.setStartPosition(x, y);
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
	}

	public function dealDamageToObject(other:FlxObject) {
		other.hurt(attributes.baseDamage);
	}
}
