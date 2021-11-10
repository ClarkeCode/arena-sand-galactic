package models;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.math.FlxVector;

class Projectile extends FlxSprite {
	public var baseDamage:Float = 1;
	public var projectileMaxHP:Float = 1;
	public var isTrackingLifespan:Bool = false;
	public var projectileAge:Float = 0;
	public var maxProjectileAge:Float = 0;
	public var projectileSpeed:Float = 0;

	public var startingX:Float = 0;
	public var startingY:Float = 0;

	public function new(X:Float, Y:Float, ?speed:Float = 200, ?acc:Float = 0, ?damage:Float = 1, ?projDurability:Float = 1, ?trackLifespan:Bool = false,
			?maximumLifespan = 5) {
		super(X, Y);
		// TODO: ???
		// velocity = vel;
		// acceleration = acc;

		startingX = X;
		startingY = Y;
		baseDamage = damage;
		projectileMaxHP = projDurability;
		isTrackingLifespan = trackLifespan;
		maxProjectileAge = maximumLifespan;
		projectileSpeed = speed;
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
		if (isTrackingLifespan) {
			projectileAge += elapsed;
			// If a projectile has exceeded its maximum lifespan, it should destroy itself
			if (projectileAge > maxProjectileAge) {
				this.kill();
			}
		}

		if (!inWorldBounds()) {
			this.kill();
		}
	}

	public function fireAtPosition(srcX:Float, srcY:Float, targetX:Float, targetY:Float) {
		x = srcX;
		y = srcY;
		x -= origin.x / 2;
		y -= origin.y / 2;

		var difference = new FlxVector(targetX - x, targetY - y);
		difference.normalize();
		difference.scale(projectileSpeed);
		velocity.x = difference.x;
		velocity.y = difference.y;
	}

	public function dealDamageToObject(other:FlxObject) {
		other.hurt(baseDamage);
	}
}
