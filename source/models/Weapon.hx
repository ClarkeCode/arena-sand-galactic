package models;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.math.FlxPoint;
import flixel.math.FlxVector;
import flixel.util.FlxColor;
import util.Convenience;

// Note: may belong in the Convenience file, but I'm not sure that it works in all cases
function rotateTowardsTargetFromFixedPoint(obj:FlxSprite, pivotPoint:FlxPoint, targetPoint:FlxPoint, objMidpointDistanceFromPivot:Float) {
	moveWithCentreOnPoint(obj, pivotPoint);
	obj.angle = 90 + pivotPoint.angleBetween(targetPoint);
	moveTowardsPoint(obj, targetPoint, objMidpointDistanceFromPivot);
}

// TODO: wrap projectile code in the weapon
class Weapon extends FlxSprite {
	public var barrelLength:Float = 10;
	// Speed at which the weapon produces projectiles, measured in projectiles per second
	public var fireRate:Float = 4;

	var equippedPlayer:Player;
	var bulletGroup:FlxTypedGroup<FlxSprite>;

	public function new(X:Float, Y:Float, barrelLen:Float, attachedPlayer:Player, projectileGroup:FlxTypedGroup<FlxSprite>) {
		super(X, Y);
		barrelLength = barrelLen;
		equippedPlayer = attachedPlayer;
		bulletGroup = projectileGroup;
	}

	override public function update(elapsed:Float) {
		// Rotate towards mouse
		moveWithCentreOnPoint(this, equippedPlayer.getMidpoint());
		angle = 90 + equippedPlayer.getMidpoint().angleBetween(FlxG.mouse.getPosition());
		moveTowardsPoint(this, FlxG.mouse.getPosition(), barrelLength / 2.0);
	}

	// TODO: Fired bullets are slightly offset from barrel
	public function fireWeapon(targetX:Float, targetY:Float) {
		var barrelAperture:FlxVector = new FlxVector(this.x - equippedPlayer.x, this.y - equippedPlayer.y);
		vScaleToSize(barrelAperture, barrelLength);
		barrelAperture.addPoint(equippedPlayer.getMidpoint());

		var bullet = new Projectile(barrelAperture.x, barrelAperture.y);
		bullet.makeGraphic(4, 4, FlxColor.PURPLE);
		bullet.fireAtPosition(barrelAperture.x, barrelAperture.y, FlxG.mouse.x, FlxG.mouse.y);
		bulletGroup.add(bullet);
	}
}
