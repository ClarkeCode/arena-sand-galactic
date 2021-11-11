package util;

import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.math.FlxVector;

// Vector Convenience Functions
// ===============================
// Note: Mutates the passed vector
function vScaleToSize(vec:FlxVector, desiredSize:Float) {
	vec.normalize();
	vec.scale(desiredSize);
}

// FlxSprite Convenience Functions
// ===============================
function moveTowardsPoint(src:FlxSprite, dst:FlxPoint, distToMove:Float) {
	var difference:FlxVector = new FlxVector();
	difference.addPoint(dst);
	difference.subtract(src.x, src.y);
	vScaleToSize(difference, distToMove);
	src.x += difference.x;
	src.y += difference.y;
}

function moveWithCentreOnPoint(src:FlxSprite, point:FlxPoint) {
	src.x = point.x - src.width / 2.0;
	src.y = point.y - src.height / 2.0;
}
