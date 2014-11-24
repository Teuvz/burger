package com.ukuleledog.games.burger;
import motion.Actuate;
import motion.easing.Bounce;
import motion.easing.Elastic;
import openfl.Assets;
import openfl.display.Bitmap;
import flash.display.Sprite;
import flash.events.Event;

/**
 * ...
 * @author Matt
 */
class GameState extends Sprite
{

	var shiny:Sprite;
	var shiny2:Bitmap;
	var fries:Bitmap;
	var flurry:Bitmap;
	var coca:Sprite;
	var ronald:Bitmap;
	
	var cocaAnimated:Bool = false;
	var ronaldAnimated:Bool = false;
	
	public function new() 
	{
		super();
		
		var shinyBitmap:Bitmap = new Bitmap( Assets.getBitmapData( 'img/shiny.png' ) );
		shiny = new Sprite();
		shiny.cacheAsBitmap = true;
		shinyBitmap.x = 0 - shinyBitmap.width / 2;
		shinyBitmap.y = 0 - shinyBitmap.height / 2;
		shiny.addChild( shinyBitmap );
		shiny.x = 300;
		shiny.y = 230;
		
		shiny2 = new Bitmap( Assets.getBitmapData( 'img/shiny.png' ) );
		shiny2.x = 600;
		shiny2.y = 150;
		
		fries = new Bitmap( Assets.getBitmapData( 'img/fries.jpg' ) );
		fries.alpha = 0;
		
		flurry = new Bitmap( Assets.getBitmapData( 'img/flurry.png' ) );
		flurry.x = 60;
		flurry.y = -350;
		
		ronald = new Bitmap( Assets.getBitmapData( 'img/ronald.jpg' ) );
		ronald.alpha = 0;
		ronald.x = 75;
		
		var cocaBitmap:Bitmap = new Bitmap( Assets.getBitmapData( 'img/coca.png' ) );
		coca = new Sprite();
		coca.cacheAsBitmap = true;
		cocaBitmap.x = 0 - cocaBitmap.width / 2;
		cocaBitmap.y = 0 - cocaBitmap.height / 2;
		coca.addChild( cocaBitmap );
		coca.x = -200;
		coca.y = 200;
		
		addEventListener(Event.ADDED_TO_STAGE, init );
	}
	
	private function init( e:Event )
	{
		removeEventListener( Event.ADDED_TO_STAGE, init );
		
		shiny.rotation = 1;
		addChild( fries );
		addChild( shiny );
		addChild( shiny2 );
		addChild( coca );
		addChild( flurry );
		addChild( ronald );
	
		addEventListener( Event.ENTER_FRAME, loop );
	}
	
	private function loop( e:Event )
	{
		shiny.rotation += 1;
		
		coca.rotation -= 3;
		
		if ( shiny.rotation == 0 )
			animateCoca();
		else if ( shiny.rotation == 90 )
			animateFries()
		else if ( shiny.rotation == 180 )
			animateShiny2();
		else if ( shiny.rotation == -90 )
			animateFlurry();
			
		if ( Math.round(Math.random() * 100) > 95 )
		{
			animateRonald();
		}
	}
	
	private function animateShiny2()
	{
		Actuate.tween( shiny2, 5, { x: -600 } ).onComplete( function() {  shiny2.x = 600; } );
	}
	
	private function animateFries()
	{
		Actuate.tween( shiny, 1, { alpha: 0.7 } );
		Actuate.tween( fries, 2, { alpha: 1 } ).ease( Bounce.easeInOut ).onComplete( function() { 
			Actuate.tween( fries, 2, { alpha: 0 } ).ease(Bounce.easeInOut);
			Actuate.tween( shiny, 1, { alpha: 1 } );
		} );
	}
	
	private function animateRonald()
	{
		if ( ronaldAnimated == false )
		{
			ronaldAnimated = true;
			Actuate.tween( ronald, 10, { alpha:0.5 } ).onComplete( function() {
				Actuate.tween( ronald, 10, { alpha:0 } ).onComplete( function() {
					ronaldAnimated = false;
				});
			});
		}
	}
	
	private function animateCoca()
	{
		if ( cocaAnimated == false )
		{
			cocaAnimated = true;
			Actuate.tween( coca, 5, { x: 1000 } ).onComplete( function() {
				Actuate.tween( coca, 5, { x: -200 } ).onComplete( function() {
					cocaAnimated = false;
				} );
			} );
		}
	}
	
	private function animateFlurry()
	{
		Actuate.tween( flurry, 2, { y:100 } ).onComplete( function() {
			Actuate.tween( flurry, 1.5, { scaleX: 4, scaleY: 4 } ).onComplete( function() { 
				flurry.scaleX = 1;
				flurry.scaleY = 1;
				flurry.y = -350;
			});
		});
	}

}