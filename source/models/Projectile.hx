package models;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxPoint;

class ProjectileAttributes {
	public var baseDamage:Float = 1;
	public var projectileMaxHP:Float = 1;
	public var isTrackingLifespan:Bool = false;
	public var projectileAge:Float = 0;
	public var maxProjectileAge:Float = 0;

	public var startingX:Float = 0;
	public var startingY:Float = 0;

	public function new(?damage:Float = 1, ?projDurability:Float = 1, ?trackLifespan:Bool = false, ?maximumLifespan = 5) {
		baseDamage = damage;
		projectileMaxHP = projDurability;
		isTrackingLifespan = trackLifespan;
		maxProjectileAge = maximumLifespan;
	}

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
		if (attributes.isTrackingLifespan) {
			attributes.projectileAge += elapsed;
			// If a projectile has exceeded its maximum lifespan, it should destroy itself
			if (attributes.projectileAge > attributes.maxProjectileAge) {
				this.kill();
			}
		}

		if (!inWorldBounds()) {
			this.kill();
		}
	}

	public function dealDamageToObject(other:FlxObject) {
		other.hurt(attributes.baseDamage);
	}
}
