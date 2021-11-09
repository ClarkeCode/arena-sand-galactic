package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.tile.FlxTilemap;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import flixel.util.FlxColor;
import models.Player;

class PlayState extends FlxState
{
	public var player:Player;

	private var walls:FlxTilemap;
	private var map:FlxOgmo3Loader;

	override public function create()
	{
		super.create();
		// this.level = new Level(this);
		// add(this.level);
		bgColor = FlxColor.fromRGB(233, 196, 106);

		// Map loading
		map = new FlxOgmo3Loader(AssetPaths.testing__ogmo, AssetPaths.testing__json);
		walls = map.loadTilemap(AssetPaths.tiles__png, "walls");
		walls.follow();
		walls.setTileProperties(1, NONE);
		walls.setTileProperties(2, ANY);
		add(walls);

		this.player = new Player(200, 200);
		map.loadEntities(placeEntities, "entities");
		add(player);
		FlxG.collide(this.player, walls);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		player.update(elapsed);
	}

	override public function destroy():Void
	{
		super.destroy();
		player = null;
	}

	public function placeEntities(entity:EntityData)
	{
		if (entity.name == "player")
		{
			player.setPosition(entity.x, entity.y);
		}
	}
}
