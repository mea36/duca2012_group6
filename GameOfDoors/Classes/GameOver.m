//
//  GameOver.m
//  GOD
//
//  Created by DUCA on 7/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GameOver.h"
#import "GamePlay.h"
#import "HelloWorldScene.h"


@implementation GameOver

+(id) scene{
	CCScene *scene = [CCScene node];
	
	GameOver *layer = [GameOver node];
	
	
	[scene addChild: layer];
	
	return scene;
}

-(id) init{
	if( (self=[super init] )) {
		self.isTouchEnabled = YES;
		
		CCSprite * bg = [CCSprite spriteWithFile:@"Game Over.png"];//make game over screen
		bg.anchorPoint = ccp(0, 0);
		[self addChild:bg z:-1];
	}
	return self;
}

-(void)rotate:(ccTime) dt{
	[[CCDirector sharedDirector] setDeviceOrientation:CCDeviceOrientationPortrait];
	[self unschedule:@selector(rotate:)];
}

-(void) start: (id) sender{
	[self schedule:@selector(rotate:) interval:0.5];
	[[CCDirector sharedDirector] replaceScene:[CCTransitionZoomFlipAngular transitionWithDuration:1 scene:[HelloWorld node]]];
	//Send to Menu
}

-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	UITouch *touch = [touches anyObject];
	CGPoint location = [touch locationInView:[touch view]];
	location = [[CCDirector sharedDirector] convertToGL:location];
	
	[self performSelector: @selector(start:) withObject:nil afterDelay:0.2];
}

- (void) dealloc{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end
