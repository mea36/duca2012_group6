//
//  HelloWorldLayer.m
//  GameOfDoors
//
//  Created by DUCA on 7/19/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

// Import the interfaces
#import "HelloWorldScene.h"
#import "GamePlay.h"

// HelloWorld implementation
@implementation HelloWorld

+(id) scene{
	CCScene *scene = [CCScene node];
	
	HelloWorld *layer = [HelloWorld node];

	
	[scene addChild: layer];
	
	return scene;
}

-(id) init{
	if( (self=[super init] )) {
		self.isTouchEnabled = YES;
		
		CCSprite * bg = [CCSprite spriteWithFile:@"MainMenu.png"];
		bg.anchorPoint = ccp(0, 0);
		[self addChild:bg z:-1];
	}
	return self;
}

-(void) start: (id) sender{
	[[CCDirector sharedDirector] replaceScene:[CCTransitionZoomFlipAngular transitionWithDuration:1 scene:[GamePlay node]]];
	//Send to GamePlay
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
