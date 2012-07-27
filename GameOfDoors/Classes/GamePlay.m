//
//  GamePlay.m
//  GOD
//
//  Created by DUCA on 7/20/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GamePlay.h"
#import "HelloWorldScene.h"
#import "GameDoor.h"
#import "GameOver.h"
#import "Winning.h"

@implementation GamePlay
@synthesize player, doorType;
@synthesize background;
@synthesize doorHeight, backgroundDoor1, backgroundDoor2, backgroundDoor3;
@synthesize doorOpen, clockImage, enterDoorButton;
@synthesize heart1, heart2, heart3;
@synthesize star1, star2, star3;
@synthesize star, tornado;
@synthesize doorImage1, doorImage2, doorImage3;
@synthesize tagImage1, tagImage2, tagImage3;
//check sound effects

+(id) scene{
	CCScene *scene = [CCScene node];
	
	GamePlay *layer = [GamePlay node];
	
	
	[scene addChild: layer];
	
	return scene;
}

-(id) init{
	if( (self=[super init] )) {
		
		[self schedule:@selector(rotate:) interval:0.5];
		
		Floor = Floor1;
		Room = Room1;
		playerSpeed = 5.0;
		areYouEnteringDoor = NO;
		youAreClickingTheEnterDoorButton = NO;
		movingLeft = NO;
		movingRight = NO;
		theresAnObjectInDoorway1 = NO;
		theresAnObjectInDoorway2 = NO;
		theresAnObjectInDoorway3 = NO;
		theresATornado = NO;
		theresDefinitelyATornado = NO;
		deleteThatStuff = NO;
		youJustLostALife = NO;
		clock=1;
		second=1;
		hour=11;
		starCount = 0;
		tornadoTimer = 0;
		tornadoSpeed = 2;
		lives = 3;
		/*
		self.background = [CCSprite spriteWithFile:@"floor0.png"];
		self.background.tag = 101;
		self.background.anchorPoint = ccp(0,0);
		[self addChild:self.background z:-1];
		*/
		
		self.heart1 = [CCSprite spriteWithFile:@"redheart.png"];
		self.heart1.position = ccp(20,300);
		self.heart1.tag = 801;
		[self addChild:self.heart1];
		
		self.heart2 = [CCSprite spriteWithFile:@"redheart.png"];
		self.heart2.position = ccp(55,300);
		self.heart2.tag = 802;
		[self addChild:self.heart2];
		
		self.heart3 = [CCSprite spriteWithFile:@"redheart.png"];
		self.heart3.position = ccp (90,300);
		self.heart3.tag = 803;
		[self addChild:self.heart3];
		
		self.star1 = [CCSprite spriteWithFile:@"StarSmall.png"];
		self.star1.position = ccp(20,275);
		self.star1.tag = 804;
		[self addChild:self.star1];
		youHaveStar1 = YES;
		
		self.star2 = [CCSprite spriteWithFile:@"StarSmall.png"];
		self.star2.position = ccp(55,275);
		self.star2.tag = 805;
		[self addChild:self.star2];
		youHaveStar2 = YES;
		
		self.star3 = [CCSprite spriteWithFile:@"StarSmall.png"];
		self.star3.position = ccp (90,275);
		self.star3.tag = 806;
		[self addChild:self.star3];
		youHaveStar3 = YES;
		
		self.background = [CCSprite spriteWithFile:@"Backgroundfloor.png"];
		self.background.anchorPoint = ccp(0,0);
		[self addChild:self.background z:-2];
		[self schedule:@selector(replaceBackground:)];
		
		self.enterDoorButton = [CCSprite spriteWithFile:@"Enterdoor.png"];
		self.enterDoorButton.tag = 999;
		self.enterDoorButton.position = ccp(445,295);
		[self addChild:self.enterDoorButton z:0];
		
        /*
		self.clockImage = [CCSprite spriteWithFile:@"Clock_1-00.png"];
		self.clockImage.position = ccp(winWidth/2,260);
		self.clockImage.tag = 1000;
		[self addChild:self.clockImage z:0];
         */
		
		self.isTouchEnabled = YES;
		
		CGSize winSize = [[CCDirector sharedDirector] winSize];
		winHeight = winSize.width;
		winWidth = winSize.height;
		NSLog(@"height = %i", winHeight);
		NSLog(@"width = %i", winWidth);
		
		self.player = [CCSprite spriteWithFile:@"Standing.png"];
		self.player.tag = 1;
		player.position = ccp(winWidth/2,self.player.contentSize.height/2);
		
		[self addChild:self.player z:10];
		
		tag = self.background.tag;
		playerTag = self.player.tag;
		[self schedule:@selector(standing_animation:) interval:0.2];
		[self schedule:@selector(update:)];
		
		//set array
		int i;
		self.doorType = [NSMutableArray array];
		for (i=0; i<36; i++) {
			if ((i+1)%9 == 0 && i != 35) {
				[self.doorType addObject:[NSString stringWithFormat:@"%d", 4]];
			}
			else if (i%9 ==0 && i != 0) {
				[self.doorType addObject:[NSString stringWithFormat:@"%d", 5]];
			}
			else {
				[self.doorType addObject:[NSString stringWithFormat:@"%d", 2]];
			}
		}
		int starPosition1 = 1;
		int starPosition2 = 1;
		int starPosition3 = 1;
		int starPosition4 = 1;
		int starPosition5 = 1;
		int starPosition6 = 1;
		int starPosition7 = 1;
		int starPosition8 = 1;
		int starPosition9 = 1;
		int starPosition10 = 1;
		int starPosition11 = 1;
		int starPosition12 = 1;
		while (starPosition1 == starPosition2 || starPosition1 == starPosition3 || starPosition2 == starPosition3) {
			starPosition1 = arc4random()%8;
			starPosition2 = arc4random()%8;
			starPosition3 = arc4random()%8;
		}
		while (starPosition4 == starPosition5 || starPosition4 == starPosition6 || starPosition5 == starPosition6) {
			starPosition4 = arc4random()%7 + 10;
			starPosition5 = arc4random()%7 + 10;
			starPosition6 = arc4random()%7 + 10;
		}
		while (starPosition7 == starPosition8 || starPosition7 == starPosition9 || starPosition8 == starPosition9) {
			starPosition7 = arc4random()%7 + 19;
			starPosition8 = arc4random()%7 + 19;
			starPosition9 = arc4random()%7 + 19;
		}
		while (starPosition10 == starPosition11 || starPosition10 == starPosition12 || starPosition11 == starPosition12) {
			starPosition10 = arc4random()%7 + 28;
			starPosition11 = arc4random()%7 + 28;
			starPosition12 = arc4random()%7 + 28;
		}
		[self.doorType replaceObjectAtIndex:starPosition1 withObject:[NSString stringWithFormat:@"%d", 1]];
		[self.doorType replaceObjectAtIndex:starPosition2 withObject:[NSString stringWithFormat:@"%d", 1]];
		[self.doorType replaceObjectAtIndex:starPosition3 withObject:[NSString stringWithFormat:@"%d", 1]];
		[self.doorType replaceObjectAtIndex:starPosition4 withObject:[NSString stringWithFormat:@"%d", 1]];
		[self.doorType replaceObjectAtIndex:starPosition5 withObject:[NSString stringWithFormat:@"%d", 1]];
		[self.doorType replaceObjectAtIndex:starPosition6 withObject:[NSString stringWithFormat:@"%d", 1]];
		[self.doorType replaceObjectAtIndex:starPosition7 withObject:[NSString stringWithFormat:@"%d", 1]];
		[self.doorType replaceObjectAtIndex:starPosition8 withObject:[NSString stringWithFormat:@"%d", 1]];
		[self.doorType replaceObjectAtIndex:starPosition9 withObject:[NSString stringWithFormat:@"%d", 1]];
		[self.doorType replaceObjectAtIndex:starPosition10 withObject:[NSString stringWithFormat:@"%d", 1]];
		[self.doorType replaceObjectAtIndex:starPosition11 withObject:[NSString stringWithFormat:@"%d", 1]];
		[self.doorType replaceObjectAtIndex:starPosition12 withObject:[NSString stringWithFormat:@"%d", 1]];
		
		[self.doorType replaceObjectAtIndex:35 withObject:[NSString stringWithFormat:@"%d", 6]];
				
		NSLog(@"%@", self.doorType);
		
		int t;
		self.doorHeight = [NSMutableArray array];
		for (t=0; t<36; t++) {
			if (t%3 == 1) {
				[self.doorHeight addObject:[NSString stringWithFormat:@"%d", 1]];
			}
			else {
				[self.doorHeight addObject:[NSString stringWithFormat:@"%d", arc4random()%3+1]];
			}
		}
		//NSLog(@"%@", self.doorHeight);
		
		int j;
		self.doorOpen = [NSMutableArray array];
		for (j=0; j<36; j++) {
			[self.doorOpen addObject:[NSString stringWithFormat:@"%d", 0]];
		}
	}
	return self;
}

-(void) gameOver: (id) sender{
	//[self performSelector: @selector(gameOver:) withObject:nil afterDelay:0.2];
	[[CCDirector sharedDirector] replaceScene:[CCTransitionZoomFlipAngular transitionWithDuration:1 scene:[GameOver node]]];
	//Send to Menu
}

-(void) winning: (id) sender{
	[[CCDirector sharedDirector] replaceScene:[CCTransitionZoomFlipAngular transitionWithDuration:1 scene:[Winning node]]];
}

-(void)rotate:(ccTime) dt{
	[[CCDirector sharedDirector] setDeviceOrientation:CCDeviceOrientationLandscapeLeft];
	[self unschedule:@selector(rotate:)];
}

-(void)replaceBackground:(ccTime) dt{
	NSLog(@"background called");
	whatRoomAmIAt = (Floor*9)+(Room*3);
	/*
	if (Floor == Floor1) {
		if (Room == Room1) {
			self.background = [CCSprite spriteWithFile:@"floor0.png"];
			self.background.tag = 101;
			self.background.anchorPoint = ccp(0,0);
			[self addChild:self.background z:-1];
		}
		if (Room == Room2) {
			self.background = [CCSprite spriteWithFile:@"floor1.png"];
			self.background.tag = 102;
			self.background.anchorPoint = ccp(0,0);
			[self addChild:self.background z:-1];
		}
		if (Room == Room3) {
			self.background = [CCSprite spriteWithFile:@"floor2.png"];
			self.background.tag = 103;
			self.background.anchorPoint = ccp(0,0);
			[self addChild:self.background z:-1];
		}
	}
	if (Floor == Floor2) {
		if (Room == Room1) {
			self.background = [CCSprite spriteWithFile:@"floor3.png"];
			self.background.tag = 104;
			self.background.anchorPoint = ccp(0,0);
			[self addChild:self.background z:-1];
		}
		if (Room == Room2) {
			self.background = [CCSprite spriteWithFile:@"floor4.png"];
			self.background.tag = 105;
			self.background.anchorPoint = ccp(0,0);
			[self addChild:self.background z:-1];
		}
		if (Room == Room3) {
			self.background = [CCSprite spriteWithFile:@"floor5.png"];
			self.background.tag = 106;
			self.background.anchorPoint = ccp(0,0);
			[self addChild:self.background z:-1];
		}
	}
	if (Floor == Floor3) {
		if (Room == Room1) {
			self.background = [CCSprite spriteWithFile:@"floor6.png"];
			self.background.tag = 107;
			self.background.anchorPoint = ccp(0,0);
			[self addChild:self.background z:-1];
		}
		if (Room == Room2) {
			self.background = [CCSprite spriteWithFile:@"floor7.png"];
			self.background.tag = 108;
			self.background.anchorPoint = ccp(0,0);
			[self addChild:self.background z:-1];
		}
		if (Room == Room3) {
			self.background = [CCSprite spriteWithFile:@"floor8.png"];
			self.background.tag = 109;
			self.background.anchorPoint = ccp(0,0);
			[self addChild:self.background z:-1];		
		}
	}
	if (Floor == Floor4) {
		if (Room == Room1) {
			self.background = [CCSprite spriteWithFile:@"floor9.png"];
			self.background.tag = 110;
			self.background.anchorPoint = ccp(0,0);
			[self addChild:self.background z:-1];		
		}
		if (Room == Room2) {
			self.background = [CCSprite spriteWithFile:@"floor10.png"];
			self.background.tag = 111;
			self.background.anchorPoint = ccp(0,0);
			[self addChild:self.background z:-1];
		}
		if (Room == Room3) {
			self.background = [CCSprite spriteWithFile:@"floor11.png"];
			self.background.tag = 112;
			self.background.anchorPoint = ccp(0,0);
			[self addChild:self.background z:-1];
		}
	}
	[self removeChildByTag:tag cleanup:YES];
	tag = self.background.tag;
	*/
	int i = (Floor*9)+(Room*3);
	int t;
	int switchy;
	for (t=0; t<3; t++) {
		switchy = [[self.doorHeight objectAtIndex:(i+t)] intValue];
		if (t==0) {
			switch (switchy) {
				case 1:
					if (Floor == Floor1) {
						if ([[self.doorOpen objectAtIndex:(i+t)] intValue] == 0) {
							self.backgroundDoor1 = [CCSprite spriteWithFile:@"Pinksmall.png"];
						}
						else {
							self.backgroundDoor1 = [CCSprite spriteWithFile:@"Pinksmallblack.png"];
						}

					}
					if (Floor == Floor2) {
						if ([[self.doorOpen objectAtIndex:(i+t)] intValue] == 0) {
							self.backgroundDoor1 = [CCSprite spriteWithFile:@"Greensmall.png"];
						}
						else {
							self.backgroundDoor1 = [CCSprite spriteWithFile:@"Greensmallblack.png"];
						}
					}
					if (Floor == Floor3) {
						if ([[self.doorOpen objectAtIndex:(i+t)] intValue] == 0) {
							self.backgroundDoor1 = [CCSprite spriteWithFile:@"Fabuloussmall.png"];
						}
						else {
							self.backgroundDoor1 = [CCSprite spriteWithFile:@"Fabuloussmallblack.png"];
						}
					}
					if (Floor == Floor4) {
						if ([[self.doorOpen objectAtIndex:(i+t)] intValue] == 0) {
							self.backgroundDoor1 = [CCSprite spriteWithFile:@"Smallpurple.png"];
						}
						else {
							self.backgroundDoor1 = [CCSprite spriteWithFile:@"Smallpurpleblack.png"];
						}
					}
					self.backgroundDoor1.position = ccp(86,20+self.backgroundDoor1.contentSize.height/2);
					self.backgroundDoor1.tag = 101;
					[self addChild:self.backgroundDoor1 z:-1];
					break;
				case 2:
					if (Floor == Floor1) {
						if ([[self.doorOpen objectAtIndex:(i+t)] intValue] == 0) {
							self.backgroundDoor1 = [CCSprite spriteWithFile:@"Pinkmedium.png"];
						}
						else {
							self.backgroundDoor1 = [CCSprite spriteWithFile:@"Pinkmediumblack.png"];
						}
					}
					if (Floor == Floor2) {
						if ([[self.doorOpen objectAtIndex:(i+t)] intValue] == 0) {
							self.backgroundDoor1 = [CCSprite spriteWithFile:@"Greenmedium.png"];
						}
						else {
							self.backgroundDoor1 = [CCSprite spriteWithFile:@"Greenmediumblack.png"];
						}
					}
					if (Floor == Floor3) {
						if ([[self.doorOpen objectAtIndex:(i+t)] intValue] == 0) {
							self.backgroundDoor1 = [CCSprite spriteWithFile:@"Fabulousmedium.png"];
						}
						else {
							self.backgroundDoor1 = [CCSprite spriteWithFile:@"Fabulousmediumblack.png"];
						}
					}
					if (Floor == Floor4) {
						if ([[self.doorOpen objectAtIndex:(i+t)] intValue] == 0) {
							self.backgroundDoor1 = [CCSprite spriteWithFile:@"Mediumpurple.png"];
						}
						else {
							self.backgroundDoor1 = [CCSprite spriteWithFile:@"Mediumpurpleblack.png"];
						}
					}
					self.backgroundDoor1.position = ccp(86,20+self.backgroundDoor1.contentSize.height/2);
					self.backgroundDoor1.tag = 101;
					[self addChild:self.backgroundDoor1 z:-1];
					break;
				case 3:
					if (Floor == Floor1) {
						if ([[self.doorOpen objectAtIndex:(i+t)] intValue] == 0) {
							self.backgroundDoor1 = [CCSprite spriteWithFile:@"Pinklarge.png"];
						}
						else {
							self.backgroundDoor1 = [CCSprite spriteWithFile:@"Pinklargeblack.png"];
						}
					}
					if (Floor == Floor2) {
						if ([[self.doorOpen objectAtIndex:(i+t)] intValue] == 0) {
							self.backgroundDoor1 = [CCSprite spriteWithFile:@"Greenlarge.png"];
						}
						else {
							self.backgroundDoor1 = [CCSprite spriteWithFile:@"Greenlargeblack.png"];
						}
					}
					if (Floor == Floor3) {
						if ([[self.doorOpen objectAtIndex:(i+t)] intValue] == 0) {
							self.backgroundDoor1 = [CCSprite spriteWithFile:@"Fabulouslarge.png"];
						}
						else {
							self.backgroundDoor1 = [CCSprite spriteWithFile:@"Fabulouslargeblack.png"];
						}
					}
					if (Floor == Floor4) {
						if ([[self.doorOpen objectAtIndex:(i+t)] intValue] == 0) {
							self.backgroundDoor1 = [CCSprite spriteWithFile:@"Largepurple.png"];
						}
						else {
							self.backgroundDoor1 = [CCSprite spriteWithFile:@"Largepurpleblack.png"];
						}
					}
					self.backgroundDoor1.position = ccp(86,20+self.backgroundDoor1.contentSize.height/2);
					self.backgroundDoor1.tag = 101;
					[self addChild:self.backgroundDoor1 z:-1];
					break;
				default:
					break;
			}
		}
		if (t==1) {
			switch (switchy) {
				case 1:
					if (Floor == Floor1) {
						if ([[self.doorOpen objectAtIndex:(i+t)] intValue] == 0) {
							self.backgroundDoor2 = [CCSprite spriteWithFile:@"Pinksmall.png"];
						}
						else {
							self.backgroundDoor2 = [CCSprite spriteWithFile:@"Pinksmallblack.png"];
						}
						
					}
					if (Floor == Floor2) {
						if ([[self.doorOpen objectAtIndex:(i+t)] intValue] == 0) {
							self.backgroundDoor2 = [CCSprite spriteWithFile:@"Greensmall.png"];
						}
						else {
							self.backgroundDoor2 = [CCSprite spriteWithFile:@"Greensmallblack.png"];
						}
					}
					if (Floor == Floor3) {
						if ([[self.doorOpen objectAtIndex:(i+t)] intValue] == 0) {
							self.backgroundDoor2 = [CCSprite spriteWithFile:@"Fabuloussmall.png"];
						}
						else {
							self.backgroundDoor2 = [CCSprite spriteWithFile:@"Fabuloussmallblack.png"];
						}
					}
					if (Floor == Floor4) {
						if ([[self.doorOpen objectAtIndex:(i+t)] intValue] == 0) {
							self.backgroundDoor2 = [CCSprite spriteWithFile:@"Smallpurple.png"];
						}
						else {
							self.backgroundDoor2 = [CCSprite spriteWithFile:@"Smallpurpleblack.png"];
						}
					}
					self.backgroundDoor2.position = ccp(234,20+self.backgroundDoor2.contentSize.height/2);
					self.backgroundDoor2.tag = 102;
					[self addChild:self.backgroundDoor2 z:-1];
					break;
				case 2:
					if (Floor == Floor1) {
						if ([[self.doorOpen objectAtIndex:(i+t)] intValue] == 0) {
							self.backgroundDoor2 = [CCSprite spriteWithFile:@"Pinkmedium.png"];
						}
						else {
							self.backgroundDoor2 = [CCSprite spriteWithFile:@"Pinkmediumblack.png"];
						}
					}
					if (Floor == Floor2) {
						if ([[self.doorOpen objectAtIndex:(i+t)] intValue] == 0) {
							self.backgroundDoor2 = [CCSprite spriteWithFile:@"Greenmedium.png"];
						}
						else {
							self.backgroundDoor2 = [CCSprite spriteWithFile:@"Greenmediumblack.png"];
						}
					}
					if (Floor == Floor3) {
						if ([[self.doorOpen objectAtIndex:(i+t)] intValue] == 0) {
							self.backgroundDoor2 = [CCSprite spriteWithFile:@"Fabulousmedium.png"];
						}
						else {
							self.backgroundDoor2 = [CCSprite spriteWithFile:@"Fabulousmediumblack.png"];
						}
					}
					if (Floor == Floor4) {
						if ([[self.doorOpen objectAtIndex:(i+t)] intValue] == 0) {
							self.backgroundDoor2 = [CCSprite spriteWithFile:@"Mediumpurple.png"];
						}
						else {
							self.backgroundDoor2 = [CCSprite spriteWithFile:@"Mediumpurpleblack.png"];
						}
					}
					self.backgroundDoor2.position = ccp(234,20+self.backgroundDoor2.contentSize.height/2);
					self.backgroundDoor2.tag = 102;
					[self addChild:self.backgroundDoor2 z:-1];
					break;
				case 3:
					if (Floor == Floor1) {
						if ([[self.doorOpen objectAtIndex:(i+t)] intValue] == 0) {
							self.backgroundDoor2 = [CCSprite spriteWithFile:@"Pinklarge.png"];
						}
						else {
							self.backgroundDoor2 = [CCSprite spriteWithFile:@"Pinklargeblack.png"];
						}
					}
					if (Floor == Floor2) {
						if ([[self.doorOpen objectAtIndex:(i+t)] intValue] == 0) {
							self.backgroundDoor2 = [CCSprite spriteWithFile:@"Greenlarge.png"];
						}
						else {
							self.backgroundDoor2 = [CCSprite spriteWithFile:@"Greenlargeblack.png"];
						}
					}
					if (Floor == Floor3) {
						if ([[self.doorOpen objectAtIndex:(i+t)] intValue] == 0) {
							self.backgroundDoor2 = [CCSprite spriteWithFile:@"Fabulouslarge.png"];
						}
						else {
							self.backgroundDoor2 = [CCSprite spriteWithFile:@"Fabulouslargeblack.png"];
						}
					}
					if (Floor == Floor4) {
						if ([[self.doorOpen objectAtIndex:(i+t)] intValue] == 0) {
							self.backgroundDoor2 = [CCSprite spriteWithFile:@"Largepurple.png"];
						}
						else {
							self.backgroundDoor2 = [CCSprite spriteWithFile:@"Largepurpleblack.png"];
						}
					}
					self.backgroundDoor2.position = ccp(234,20+self.backgroundDoor2.contentSize.height/2);
					self.backgroundDoor2.tag = 102;
					[self addChild:self.backgroundDoor2 z:-1];
					break;
				default:
					break;
			}
		}
		if (t==2) {
			switch (switchy) {
				case 1:
					if (Floor == Floor1) {
						if ([[self.doorOpen objectAtIndex:(i+t)] intValue] == 0) {
							self.backgroundDoor3 = [CCSprite spriteWithFile:@"Pinksmall.png"];
						}
						else {
							self.backgroundDoor3 = [CCSprite spriteWithFile:@"Pinksmallblack.png"];
						}
						
					}
					if (Floor == Floor2) {
						if ([[self.doorOpen objectAtIndex:(i+t)] intValue] == 0) {
							self.backgroundDoor3 = [CCSprite spriteWithFile:@"Greensmall.png"];
						}
						else {
							self.backgroundDoor3 = [CCSprite spriteWithFile:@"Greensmallblack.png"];
						}
					}
					if (Floor == Floor3) {
						if ([[self.doorOpen objectAtIndex:(i+t)] intValue] == 0) {
							self.backgroundDoor3 = [CCSprite spriteWithFile:@"Fabuloussmall.png"];
						}
						else {
							self.backgroundDoor3 = [CCSprite spriteWithFile:@"Fabuloussmallblack.png"];
						}
					}
					if (Floor == Floor4) {
						if ([[self.doorOpen objectAtIndex:(i+t)] intValue] == 0) {
							self.backgroundDoor3 = [CCSprite spriteWithFile:@"Smallpurple.png"];
						}
						else {
							self.backgroundDoor3 = [CCSprite spriteWithFile:@"Smallpurpleblack.png"];
						}
					}
					self.backgroundDoor3.position = ccp(395,20+self.backgroundDoor3.contentSize.height/2);
					self.backgroundDoor3.tag = 103;
					[self addChild:self.backgroundDoor3 z:-1];
					break;
				case 2:
					if (Floor == Floor1) {
						if ([[self.doorOpen objectAtIndex:(i+t)] intValue] == 0) {
							self.backgroundDoor3 = [CCSprite spriteWithFile:@"Pinkmedium.png"];
						}
						else {
							self.backgroundDoor3 = [CCSprite spriteWithFile:@"Pinkmediumblack.png"];
						}
					}
					if (Floor == Floor2) {
						if ([[self.doorOpen objectAtIndex:(i+t)] intValue] == 0) {
							self.backgroundDoor3 = [CCSprite spriteWithFile:@"Greenmedium.png"];
						}
						else {
							self.backgroundDoor3 = [CCSprite spriteWithFile:@"Greenmediumblack.png"];
						}
					}
					if (Floor == Floor3) {
						if ([[self.doorOpen objectAtIndex:(i+t)] intValue] == 0) {
							self.backgroundDoor3 = [CCSprite spriteWithFile:@"Fabulousmedium.png"];
						}
						else {
							self.backgroundDoor3 = [CCSprite spriteWithFile:@"Fabulousmediumblack.png"];
						}
					}
					if (Floor == Floor4) {
						if ([[self.doorOpen objectAtIndex:(i+t)] intValue] == 0) {
							self.backgroundDoor3 = [CCSprite spriteWithFile:@"Mediumpurple.png"];
						}
						else {
							self.backgroundDoor3 = [CCSprite spriteWithFile:@"Mediumpurpleblack.png"];
						}
					}
					self.backgroundDoor3.position = ccp(395,20+self.backgroundDoor3.contentSize.height/2);
					self.backgroundDoor3.tag = 103;
					[self addChild:self.backgroundDoor3 z:-1];
					break;
				case 3:
					if (Floor == Floor1) {
						if ([[self.doorOpen objectAtIndex:(i+t)] intValue] == 0) {
							self.backgroundDoor3 = [CCSprite spriteWithFile:@"Pinklarge.png"];
						}
						else {
							self.backgroundDoor3 = [CCSprite spriteWithFile:@"Pinklargeblack.png"];
						}
					}
					if (Floor == Floor2) {
						if ([[self.doorOpen objectAtIndex:(i+t)] intValue] == 0) {
							self.backgroundDoor3 = [CCSprite spriteWithFile:@"Greenlarge.png"];
						}
						else {
							self.backgroundDoor3 = [CCSprite spriteWithFile:@"Greenlargeblack.png"];
						}
					}
					if (Floor == Floor3) {
						if ([[self.doorOpen objectAtIndex:(i+t)] intValue] == 0) {
							self.backgroundDoor3 = [CCSprite spriteWithFile:@"Fabulouslarge.png"];
						}
						else {
							self.backgroundDoor3 = [CCSprite spriteWithFile:@"Fabulouslargeblack.png"];
						}
					}
					if (Floor == Floor4) {
						if ([[self.doorOpen objectAtIndex:(i+t)] intValue] == 0) {
							self.backgroundDoor3 = [CCSprite spriteWithFile:@"Largepurple.png"];
						}
						else {
							self.backgroundDoor3 = [CCSprite spriteWithFile:@"Largepurpleblack.png"];
						}
					}
					self.backgroundDoor3.position = ccp(395,20+self.backgroundDoor3.contentSize.height/2);
					self.backgroundDoor3.tag = 103;
					[self addChild:self.backgroundDoor3 z:-1];
					break;
				default:
					break;
			}
		}
		
			
	}
	
	if ([[doorOpen objectAtIndex:whatRoomAmIAt] intValue] == 0) {
		NSString *tagFile1 = [NSString stringWithFormat:@"%d0%d.png", Floor +1, Room*3 +1];
		self.tagImage1 = [CCSprite spriteWithFile:tagFile1];
		self.tagImage1.position = ccp(86,5*self.backgroundDoor1.position.y/4);
		self.tagImage1.tag = 701;
		[self addChild:self.tagImage1];
	}
	
	if ([[doorOpen objectAtIndex:whatRoomAmIAt +1] intValue] == 0) {
		NSString *tagFile2 = [NSString stringWithFormat:@"%d0%d.png", Floor +1, Room*3 +2];
		self.tagImage2 = [CCSprite spriteWithFile:tagFile2];
		self.tagImage2.position = ccp(234,5*self.backgroundDoor2.position.y/4);
		self.tagImage2.tag = 702;
		[self addChild:self.tagImage2];
	}
	if ([[doorOpen objectAtIndex:whatRoomAmIAt +2] intValue] == 0){
		NSString *tagFile3 = [NSString stringWithFormat:@"%d0%d.png", Floor +1, Room*3 +3];
		self.tagImage3 = [CCSprite spriteWithFile:tagFile3];
		self.tagImage3.position = ccp(395,5*self.backgroundDoor3.position.y/4);
		self.tagImage3.tag = 703;
		[self addChild:self.tagImage3];
	}
	[self unschedule:@selector(replaceBackground:)];
}

-(void) enterDoor:(ccTime) dt{
	//NSLog(@"enterDoor called");
	whatRoomAmIAt = (Floor*9)+(Room*3);
	if (Door == Door1) {
		door1Timer = 0;
	}
	if (Door == Door2) {
		door2Timer = 0;
	}
	if (Door == Door3) {
		door3Timer = 0;
	}
	
	int mySwitch = [[self.doorType objectAtIndex:(whatDoorAmIAt)] intValue];
	
	switch (mySwitch) {
		case 1:
			NSLog(@"Good Door");
			if ([[self.doorOpen objectAtIndex:whatDoorAmIAt] intValue] == 0) {
				[self.doorOpen replaceObjectAtIndex:whatDoorAmIAt withObject:@"1"];
				starCount++;
				//[[SimpleAudioEngine sharedEngine] playEffect:@"door-3-open.mp3"];
			}
			//add the ability to close doors
			/*else if ([[self.doorOpen objectAtIndex:whatDoorAmIAt] intValue] == 1) {
				[self.doorOpen replaceObjectAtIndex:whatDoorAmIAt withObject:@"0"];
				//[[SimpleAudioEngine sharedEngine] playEffect:@"door-3-close.mp3"];
			}*/
			[self removeChildByTag:101 cleanup:YES];
			[self removeChildByTag:102 cleanup:YES];
			[self removeChildByTag:103 cleanup:YES];
			[self removeChildByTag:701 cleanup:YES];
			[self removeChildByTag:702 cleanup:YES];
			[self removeChildByTag:703 cleanup:YES];
			[self schedule:@selector(replaceBackground:) interval:0.0];
			break;
		case 2:
			NSLog(@"Bad Door");
			if ([[self.doorOpen objectAtIndex:whatDoorAmIAt] intValue] == 0) {
				[self.doorOpen replaceObjectAtIndex:whatDoorAmIAt withObject:@"1"];
				theresATornado = YES;
				tornadoTimer = 0;
				tornadoX = -100;
				tornadoY = 75;
				//[[SimpleAudioEngine sharedEngine] playEffect:@"door-3-open.mp3"];
			}
			//adds the ability to close doors
			/*else if ([[self.doorOpen objectAtIndex:whatDoorAmIAt] intValue] == 1) {
				[self.doorOpen replaceObjectAtIndex:whatDoorAmIAt withObject:@"0"];
				//[[SimpleAudioEngine sharedEngine] playEffect:@"door-3-close.mp3"];
			}*/
			
			[self removeChildByTag:101 cleanup:YES];
			[self removeChildByTag:102 cleanup:YES];
			[self removeChildByTag:103 cleanup:YES];
			[self removeChildByTag:701 cleanup:YES];
			[self removeChildByTag:702 cleanup:YES];
			[self removeChildByTag:703 cleanup:YES];
			[self schedule:@selector(replaceBackground:) interval:0.0];
			
			
			
			break;
		case 3:
			NSLog(@"Game Door");
			break;
		case 4:
			NSLog(@"Stairs Up");
			if (starCount >= (Floor*3)+3 && theresATornado == NO) {
				Floor++;
				Room = Room1;
				
				self.player.position = ccp(86, self.player.position.y);
				[self removeChildByTag:101 cleanup:YES];
				[self removeChildByTag:102 cleanup:YES];
				[self removeChildByTag:103 cleanup:YES];
				[self removeChildByTag:701 cleanup:YES];
				[self removeChildByTag:702 cleanup:YES];
				[self removeChildByTag:703 cleanup:YES];
				[self schedule:@selector(replaceBackground:) interval:0.0];
			}
			break;
		case 5:
			NSLog(@"Stairs Down");
			if (theresATornado == NO) {
				Floor--;
				Room = Room3;
				
				self.player.position = ccp(395, self.player.position.y);
				[self removeChildByTag:101 cleanup:YES];
				[self removeChildByTag:102 cleanup:YES];
				[self removeChildByTag:103 cleanup:YES];
				[self removeChildByTag:701 cleanup:YES];
				[self removeChildByTag:702 cleanup:YES];
				[self removeChildByTag:703 cleanup:YES];
				[self schedule:@selector(replaceBackground:) interval:0.0];
			}
			break;
		case 6:
			NSLog(@"You Win");
			if (starCount == 12) {
				[self performSelector: @selector(winning:) withObject:nil afterDelay:0.2];
			}
			break;
		default:
			break;
	}
		
	areYouEnteringDoor = NO;
	[self unschedule:@selector(enterDoor:)];
}

-(void) goodDoor:(ccTime) dt{
	/*self.star = [CCSprite spriteWithFile:@"Star.png"];
	self.star.tag = 998;
	if (Door == Door1) {
		self.star.position = ccp();
	}
	else if (Door == Door2) {
		self.star.position = ccp();
	}
	else if (Door == Door3) {
		self.star.position = ccp();
	}
	[self addChild:self.star];*/
}

-(void) badDoor:(ccTime) dt{
}

-(BOOL) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	
	UITouch * myTouch = [touches anyObject];
	CGPoint point = [myTouch locationInView :[myTouch view]];
	point = [[CCDirector sharedDirector] convertToGL:point];
	
	x = point.x;
	y = point.y;
	
	timer = 0;
	
	[self unschedule:@selector(standing_animation:)];
	[self schedule:@selector(moveSprite:)];
	return YES;
}

-(BOOL) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
	[self unschedule:@selector(moveSprite:)];
	if (areYouEnteringDoor == YES){
		[self schedule:@selector(enterDoor:)];
	}
	if (youAreJumping == YES) {
		jumptime = 0;
		myY = self.player.position.y; 
		[self schedule:@selector(jump_animation)];
		youAreJumping = NO;
	}
	[self schedule:@selector(standing_animation:) interval:0.2];
	timer = 0;
	youAreClickingTheEnterDoorButton = NO;
	movingLeft = NO;
	movingRight = NO;
	return YES;
}

-(void) update:(ccTime) dt{
	[self removeChildByTag:1000 cleanup:YES];
	[self removeChildByTag:999 cleanup:YES];
	myX = self.player.position.x;
	if (self.player.position.x > 33 && self.player.position.x < 139) {
		Door = Door1;
	}
	else if (self.player.position.x > 176 && self.player.position.x < 292) {
		Door = Door2;
	}
	else if (self.player.position.x > 331 && self.player.position.x < 459) {
		Door = Door3;
	}
	else {
		Door = NoDoor;
	}
	whatDoorAmIAt = (Floor*9)+(Room*3)+Door-1;
	whatRoomAmIAt = (Floor*9)+(Room*3);
	clock++;
	if (clock%60 == 0) {
		second++;
	}
	if (clock%(12*60)==0) {
		hour++;
	}

	if (theresAnObjectInDoorway1 == YES) {
		[self removeChildByTag:901 cleanup:YES];
		theresAnObjectInDoorway1 = NO;
	}
	if (theresAnObjectInDoorway2 == YES) {
		[self removeChildByTag:902 cleanup:YES];
		theresAnObjectInDoorway2 = NO;
	}
	if (theresAnObjectInDoorway3) {
		[self removeChildByTag:903 cleanup:YES];
		theresAnObjectInDoorway3 = NO;
	}
	int t;
	for (t=0; t<3; t++) {
		if (t == 0 && door1Timer < 60) {
			if ([[doorOpen objectAtIndex:whatRoomAmIAt+t] intValue] == 1) {
				if ([[doorType objectAtIndex:whatRoomAmIAt+t] intValue] == 1) {
					self.doorImage1 = [CCSprite spriteWithFile:@"Star.png"];
				}
				else if ([[doorType objectAtIndex:whatRoomAmIAt+t] intValue] == 2){
					self.doorImage1 = [CCSprite spriteWithFile:@"Tornado.png"];
				}
				self.doorImage1.position = ccp(86,100);
				self.doorImage1.tag = 901;
				[self addChild:self.doorImage1];
				theresAnObjectInDoorway1 = YES;
				door1Timer++;
			}
		}
		if (t == 1 && door2Timer < 60) {
			if ([[doorOpen objectAtIndex:whatRoomAmIAt+t] intValue] == 1) {
				if ([[doorType objectAtIndex:whatRoomAmIAt+t] intValue] == 1) {
					self.doorImage2 = [CCSprite spriteWithFile:@"Star.png"];
				}
				else if ([[doorType objectAtIndex:whatRoomAmIAt+t] intValue] == 2){
					self.doorImage2 = [CCSprite spriteWithFile:@"Tornado.png"];
				}
				self.doorImage2.position = ccp(234,100);
				self.doorImage2.tag = 902;
				[self addChild:self.doorImage2];
				theresAnObjectInDoorway2 = YES;
				door2Timer++;
			}
		}
		if (t == 2 && door3Timer < 60) {
			if ([[doorOpen objectAtIndex:whatRoomAmIAt+t] intValue] == 1) {
				if ([[doorType objectAtIndex:whatRoomAmIAt+t] intValue] == 1) {
					self.doorImage3 = [CCSprite spriteWithFile:@"Star.png"];
				}
				else if ([[doorType objectAtIndex:whatRoomAmIAt+t] intValue] == 2){
					self.doorImage3 = [CCSprite spriteWithFile:@"Tornado.png"];
				}
				self.doorImage3.position = ccp(395,100);
				self.doorImage3.tag = 903;
				[self addChild:self.doorImage3];
				theresAnObjectInDoorway3 = YES;
			}
			door3Timer++;
		}
	}
	
	if (youHaveStar1 == YES) {
		[self removeChildByTag:804 cleanup:YES];
		youHaveStar1 = NO;
	}
	if (youHaveStar2 == YES) {
		[self removeChildByTag:805 cleanup:YES];
		youHaveStar2 = NO;
	}
	if (youHaveStar3) {
		[self removeChildByTag:806 cleanup:YES];
		youHaveStar3 = NO;
	}
	
	if (starCount >= (Floor*3)+1) {
		self.star1 = [CCSprite spriteWithFile:@"StarSmall.png"];
		self.star1.position = ccp(20,275);
		self.star1.tag = 804;
		[self addChild:self.star1];
		youHaveStar1 =	YES;
	}
	
	if (starCount >= (Floor*3)+2) {
		self.star2 = [CCSprite spriteWithFile:@"StarSmall.png"];
		self.star2.position = ccp(55,275);
		self.star2.tag = 805;
		[self addChild:self.star2];
		youHaveStar2 = YES;
	}
	
	if (starCount >= (Floor*3)+3) {
		self.star3 = [CCSprite spriteWithFile:@"StarSmall.png"];
		self.star3.position = ccp (90,275);
		self.star3.tag = 806;
		[self addChild:self.star3];
		youHaveStar3 = YES;
	}
	[self removeChildByTag:801 cleanup:YES];
	[self removeChildByTag:802 cleanup:YES];
	[self removeChildByTag:803 cleanup:YES];
	
	if (lives >= 1) {
		self.heart1 = [CCSprite spriteWithFile:@"redheart.png"];
		self.heart1.position = ccp(20,300);
		self.heart1.tag = 801;
		[self addChild:self.heart1];
	}
	else {
		self.heart1 = [CCSprite spriteWithFile:@"Blackheart.png"];
		self.heart1.position = ccp(20,300);
		self.heart1.tag = 801;
		[self addChild:self.heart1];
	}

	if (lives >= 2) {
		self.heart2 = [CCSprite spriteWithFile:@"redheart.png"];
		self.heart2.position = ccp(55,300);
		self.heart2.tag = 802;
		[self addChild:self.heart2];
	}
	else {
		self.heart2 = [CCSprite spriteWithFile:@"Blackheart.png"];
		self.heart2.position = ccp(55,300);
		self.heart2.tag = 802;
		[self addChild:self.heart2];
	}

	if (lives == 3) {
		self.heart3 = [CCSprite spriteWithFile:@"redheart.png"];
		self.heart3.position = ccp (90,300);
		self.heart3.tag = 803;
		[self addChild:self.heart3];
	}
	else {
		self.heart3 = [CCSprite spriteWithFile:@"Blackheart.png"];
		self.heart3.position = ccp (90,300);
		self.heart3.tag = 803;
		[self addChild:self.heart3];
	}

	
	self.enterDoorButton = [CCSprite spriteWithFile:@"Enterdoor.png"];
	self.enterDoorButton.tag = 999;
	self.enterDoorButton.position = ccp(445,295);
	[self addChild:self.enterDoorButton z:0];
	/*
	//NSString *seconds = (String)second;
	//clock
	NSString *clockFile = [NSString stringWithFormat:@"Clock_%d-%d.png", hour%12 +1, (second-1)%12*5];
	self.clockImage = [CCSprite spriteWithFile:clockFile];
	self.clockImage.position = ccp(winWidth/2,260);
	self.clockImage.tag = 1000;
	[self addChild:self.clockImage z:0];
     */
	
	
	//tornado
	tornadoTimerMax = (Floor+1)*300;
	if (theresDefinitelyATornado == YES) {
		if (tornadoTimer%2 == 1) {
			[self removeChildByTag:555 cleanup:YES];
		}
		if (tornadoTimer%2 == 0) {
			[self removeChildByTag:556 cleanup:YES];
		}
		if (deleteThatStuff == YES) {
			theresATornado = NO;
			theresDefinitelyATornado = NO;
			deleteThatStuff = NO;
			youJustLostALife = NO;
			[self removeChildByTag:555 cleanup:YES];
			[self removeChildByTag:556 cleanup:YES];
		}
		
	}
	
	if (theresATornado == YES) {
		NSLog(@"tornado timer %d", tornadoTimer);
		theresDefinitelyATornado = YES;
		if (tornadoTimer%2 == 0) {
			self.tornado = [CCSprite spriteWithFile:@"Tornado.png"];
			self.tornado.position = ccp(tornadoX,tornadoY);
			self.tornado.tag = 555;
			[self addChild:self.tornado];
		}
		if (tornadoTimer%2 == 1) {
			self.tornado = [CCSprite spriteWithFile:@"Tornado2.png"];
			self.tornado.position = ccp(tornadoX,tornadoY);
			self.tornado.tag = 556;
			[self addChild:self.tornado];
		}
		
		if (tornadoTimer <= tornadoTimerMax) {
			if (self.player.position.x > self.tornado.position.x) {
				tornadoX += tornadoSpeed;
			}
			if (self.player.position.x < self.tornado.position.x) {
				tornadoX -= tornadoSpeed;
			}
		}
		
		if (tornadoTimer > tornadoTimerMax) {
			tornadoX += tornadoSpeed;
			if (self.tornado.position.x > winWidth +20) {
				deleteThatStuff = YES;
			}
		}
		float xDif = player.position.x - tornado.position.x;
		float yDif = player.position.y - tornado.position.y;
		float distance = sqrtf(xDif*xDif+yDif*yDif);
		if (distance < 30 && youJustLostALife == NO) {
			lives --;
			youJustLostALife = YES;
			tornadoTimer = tornadoTimerMax;
		}
		tornadoTimer++;
	}
	
	//gameOver
	if (lives == 0) {
		[self performSelector: @selector(gameOver:) withObject:nil afterDelay:0.2];
	}
}

-(void) moveSprite:(ccTime) dt{
	if (x > 415 && x < 475 && y < 315 && y > 285 && Door != NoDoor && theresATornado == NO) {
		youAreClickingTheEnterDoorButton = YES;
		areYouEnteringDoor = YES;
	}
	//middle click
	else if (x > winWidth/2 -80 && x < winWidth/2 +80 && youAreCurrentlyJumping == NO) {
		youAreJumping = YES;
	}
	
	else if (x < winWidth/2 - 80) 
	{
		//[self schedule:@selector(animation_left:) interval:0.1];
		if (anotherTimer%5 == 0 && youAreCurrentlyJumping == NO) {
			[self animation_left:0.1];
		}
		anotherTimer++;
	}
	else if (x > winWidth/2 + 80) 
	{
		//[self schedule:@selector(animation_right:) interval:0.1];
		if (anotherTimer%5 == 0 && youAreCurrentlyJumping == NO) {
			[self animation_right:0.1];
		}
		anotherTimer++;
	}	
	if (Room != Room3 && Room != Room1){
		if ((self.player.position.x + self.player.contentSize.width/4) > winWidth && theresATornado == NO) {
			Room++;
		
			self.player.position = ccp(self.player.contentSize.width/4, self.player.position.y);
			[self removeChildByTag:101 cleanup:YES];
			[self removeChildByTag:102 cleanup:YES];
			[self removeChildByTag:103 cleanup:YES];
			[self removeChildByTag:701 cleanup:YES];
			[self removeChildByTag:702 cleanup:YES];
			[self removeChildByTag:703 cleanup:YES];
			[self schedule:@selector(replaceBackground:) interval:0.0];
		}
		if ((self.player.position.x - self.player.contentSize.width/4) < 0 && theresATornado == NO) {
			Room--;
							
			self.player.position = ccp(winWidth - self.player.contentSize.width/4, self.player.position.y);
			[self removeChildByTag:101 cleanup:YES];
			[self removeChildByTag:102 cleanup:YES];
			[self removeChildByTag:103 cleanup:YES];
			[self removeChildByTag:701 cleanup:YES];
			[self removeChildByTag:702 cleanup:YES];
			[self removeChildByTag:703 cleanup:YES];
			[self schedule:@selector(replaceBackground:) interval:0.0];
		}
		
		if (x < winWidth/2 - 80) //self.player.position.x) 
		{
			if (theresATornado == YES && self.player.position.x - self.player.contentSize.height/4 > 0) {
				self.player.position = ccp(self.player.position.x - playerSpeed, self.player.position.y);
				movingLeft = YES;
			}
			if (theresATornado == NO) {
				self.player.position = ccp(self.player.position.x - playerSpeed, self.player.position.y);
				movingLeft = YES;
			}
		}
	
		if (x > winWidth/2 + 80 && youAreClickingTheEnterDoorButton == NO) //self.player.position.x) 
		{
			if (theresATornado == YES && self.player.position.x + self.player.contentSize.height/4 < winWidth) {
				self.player.position = ccp(self.player.position.x + playerSpeed, self.player.position.y);
				movingRight = YES;
			}
			if (theresATornado == NO) {
				self.player.position = ccp(self.player.position.x + playerSpeed, self.player.position.y);
				movingRight = YES;
			}
		}
	}
	if (Room == Room3) {
		if (self.player.position.x - self.player.contentSize.width/4 < 0 && theresATornado == NO) {
			
			Room--;
			
			self.player.position = ccp(winWidth - self.player.contentSize.width/4, self.player.position.y);
			[self removeChildByTag:101 cleanup:YES];
			[self removeChildByTag:102 cleanup:YES];
			[self removeChildByTag:103 cleanup:YES];
			[self removeChildByTag:701 cleanup:YES];
			[self removeChildByTag:702 cleanup:YES];
			[self removeChildByTag:703 cleanup:YES];
			[self schedule:@selector(replaceBackground:) interval:0.0];
		}		
		if (x < winWidth/2 - 80) 
		{
			if (theresATornado == YES && self.player.position.x - self.player.contentSize.height/4 > 0) {
				self.player.position = ccp(self.player.position.x - playerSpeed, self.player.position.y);
				movingLeft = YES;
			}
			if (theresATornado == NO) {
				self.player.position = ccp(self.player.position.x - playerSpeed, self.player.position.y);
				movingLeft = YES;
			}
		}
		if (x > winWidth/2 + 80 && self.player.position.x + self.player.contentSize.height/4 < winWidth && youAreClickingTheEnterDoorButton == NO) 
		{
			self.player.position = ccp(self.player.position.x + playerSpeed, self.player.position.y);
			movingRight = YES;
		}
		
	}
	if (Room == Room1) {
		if (self.player.position.x + self.player.contentSize.width/4 > winWidth && theresATornado == NO) {
			
			Room++;
			
			self.player.position = ccp(self.player.contentSize.width/4, self.player.position.y);
			[self removeChildByTag:101 cleanup:YES];
			[self removeChildByTag:102 cleanup:YES];
			[self removeChildByTag:103 cleanup:YES];
			[self removeChildByTag:701 cleanup:YES];
			[self removeChildByTag:702 cleanup:YES];
			[self removeChildByTag:703 cleanup:YES];
			[self schedule:@selector(replaceBackground:) interval:0.0];
		}		
		if (x < winWidth/2 - 80 && self.player.position.x - self.player.contentSize.height/4 > 0) 
		{
			self.player.position = ccp(self.player.position.x - playerSpeed, self.player.position.y);
			movingLeft = YES;
		}
		if (x > winWidth/2 + 80 && youAreClickingTheEnterDoorButton == NO) 
		{
			if (theresATornado == YES && self.player.position.x + self.player.contentSize.height/4 < winWidth) {
				self.player.position = ccp(self.player.position.x + playerSpeed, self.player.position.y);
				movingRight = YES;
			}
			if (theresATornado == NO) {
				self.player.position = ccp(self.player.position.x + playerSpeed, self.player.position.y);
				movingRight = YES;
			}
		}
	}
}

-(void) animation_right:(ccTime) dt{
	//NSLog(@"right animation");
	timer++;
	timer = timer % 10;
	
	playerX = self.player.position.x;
	playerY = self.player.position.y;
	switch (timer) {
		case 0:
			self.player = [CCSprite spriteWithFile:@"Running1.png"];
			player.position = ccp(playerX,playerY);
			player.tag = 2;
			[self addChild:self.player z:10];
			break;
		case 1:
			self.player = [CCSprite spriteWithFile:@"Running2.png"];
			player.position = ccp(playerX,playerY);
			player.tag = 3;
			[self addChild:self.player z:10];
			break;
		case 2:
			self.player = [CCSprite spriteWithFile:@"Running3.png"];
			player.position = ccp(playerX,playerY);
			player.tag = 4;
			[self addChild:self.player z:10];
			break;
		case 3:
			self.player = [CCSprite spriteWithFile:@"Running4.png"];
			player.position = ccp(playerX,playerY);
			player.tag = 5;
			[self addChild:self.player z:10];
			break;
		case 4:
			self.player = [CCSprite spriteWithFile:@"Running5.png"];
			player.position = ccp(playerX,playerY);
			player.tag = 6;
			[self addChild:self.player z:10];
			break;
		case 5:
			self.player = [CCSprite spriteWithFile:@"Running6.png"];
			player.position = ccp(playerX,playerY);
			player.tag = 7;
			[self addChild:self.player z:10];
			break;
		case 6:
			self.player = [CCSprite spriteWithFile:@"Running7.png"];
			player.position = ccp(playerX,playerY);
			player.tag = 8;
			[self addChild:self.player z:10];
			break;
		case 7:
			self.player = [CCSprite spriteWithFile:@"Running8.png"];
			player.position = ccp(playerX,playerY);
			player.tag = 9;
			[self addChild:self.player z:10];
			break;
		case 8:
			self.player = [CCSprite spriteWithFile:@"Running9.png"];
			player.position = ccp(playerX,playerY);
			player.tag = 10;
			[self addChild:self.player z:10];
			break;
		case 9:
			self.player = [CCSprite spriteWithFile:@"Running10.png"];
			player.position = ccp(playerX,playerY);
			player.tag = 11;
			[self addChild:self.player z:10];
			break;
		default:
			break;
	}
	
	[self removeChildByTag:playerTag cleanup:YES];
	playerTag = self.player.tag;
	//[self unschedule:@selector(animation_right:)];
}

-(void) animation_left:(ccTime) dt{
	//NSLog(@"left animation");
	timer++;
	timer = timer % 10;
	
	playerX = self.player.position.x;
	playerY = self.player.position.y;
	switch (timer) {
		case 0:
			self.player = [CCSprite spriteWithFile:@"RunningBack1.png"];
			player.position = ccp(playerX,playerY);
			player.tag = 12;
			[self addChild:self.player z:10];
			break;
		case 1:
			self.player = [CCSprite spriteWithFile:@"RunningBack2.png"];
			player.position = ccp(playerX,playerY);
			player.tag = 13;
			[self addChild:self.player z:10];
			break;
		case 2:
			self.player = [CCSprite spriteWithFile:@"RunningBack3.png"];
			player.position = ccp(playerX,playerY);
			player.tag = 14;
			[self addChild:self.player z:10];
			break;
		case 3:
			self.player = [CCSprite spriteWithFile:@"RunningBack4.png"];
			player.position = ccp(playerX,playerY);
			player.tag = 15;
			[self addChild:self.player z:10];
			break;
		case 4:
			self.player = [CCSprite spriteWithFile:@"RunningBack5.png"];
			player.position = ccp(playerX,playerY);
			player.tag = 16;
			[self addChild:self.player z:10];
			break;
		case 5:
			self.player = [CCSprite spriteWithFile:@"RunningBack6.png"];
			player.position = ccp(playerX,playerY);
			player.tag = 17;
			[self addChild:self.player z:10];
			break;
		case 6:
			self.player = [CCSprite spriteWithFile:@"RunningBack7.png"];
			player.position = ccp(playerX,playerY);
			player.tag = 18;
			[self addChild:self.player z:10];
			break;
		case 7:
			self.player = [CCSprite spriteWithFile:@"RunningBack8.png"];
			player.position = ccp(playerX,playerY);
			player.tag = 19;
			[self addChild:self.player z:10];
			break;
		case 8:
			self.player = [CCSprite spriteWithFile:@"RunningBack9.png"];
			player.position = ccp(playerX,playerY);
			player.tag = 20;
			[self addChild:self.player z:10];
			break;
		case 9:
			self.player = [CCSprite spriteWithFile:@"RunningBack10.png"];
			player.position = ccp(playerX,playerY);
			player.tag = 21;
			[self addChild:self.player z:10];
			break;
		default:
			break;
	}
	
	[self removeChildByTag:playerTag cleanup:YES];
	playerTag = self.player.tag;
	//[self unschedule:@selector(animation_left:)];	
}

-(void) standing_animation:(ccTime) dt{
	//NSLog(@"standing animation");
	timer++;
	timer = timer % 2;
	if (youAreCurrentlyJumping == NO) {
		playerX = self.player.position.x;
		playerY = self.player.position.y;
		switch (timer) {
			case 0:
				self.player = [CCSprite spriteWithFile:@"Standing.png"];
				player.position = ccp(playerX,playerY);
				player.tag = 1;
				[self addChild:self.player z:10];
				break;
			case 1:
				self.player = [CCSprite spriteWithFile:@"Standing2.png"];
				player.position = ccp(playerX,playerY);
				player.tag = 22;
				[self addChild:self.player z:10];
				break;
			default:
				break;
		}
		
		[self removeChildByTag:playerTag cleanup:YES];
		playerTag = self.player.tag;
	}
}

-(void) jump_animation{
	NSLog(@"jump animation called");
	//[self schedule:@selector(jump_animation)]; for calling method(1/60 sec)
	youAreCurrentlyJumping = YES;
	jumptime++; //jumptime = 0; where the jump method is called
	float yCoordinate = (498.2)*(jumptime/60)-(428.75)*(jumptime/60)*(jumptime/60);
	NSLog(@"yCoordinate = %f", yCoordinate);
	[self removeChildByTag:playerTag cleanup:YES];
    /*
	if (movingRight == YES) {
		self.player = [CCSprite spriteWithFile:@"JumpingRight.png"];
	}
	else if (movingLeft == YES){
		self.player = [CCSprite spriteWithFile:@"JumpingLeft.png"];
	}
	else if (movingLeft == NO && movingRight == NO){
		//self.player = [CCSprite spriteWithFile:@"JumpingUp.png"];
	}
     */
	self.player.tag = 23;
	self.player.position = ccp(myX, myY + yCoordinate);
	[self addChild:self.player z:10];
	
	playerTag = self.player.tag;
	if (jumptime == 70) {
		self.player.position = ccp(self.player.position.x, self.player.contentSize.height/2);
		[self unschedule:@selector(jump_animation)];
		youAreCurrentlyJumping = NO;
	}
}

-(void) dealloc{
	[player release];
	[background release];
	[doorType release];
	[doorHeight release];
	[backgroundDoor1 release];
	[backgroundDoor2 release];
	[backgroundDoor3 release];
	[doorOpen release];
	[clockImage release];
	[enterDoorButton release];
	[heart1 release];
	[heart2 release];
	[heart3 release];
	[star release];
	[tornado release];
	[doorImage1 release];
	[doorImage2 release];
	[doorImage3 release];
	[tagImage1 release];
	[tagImage2 release];
	[tagImage3 release];
	[star1 release];
	[star2 release];
	[star3 release];
		
	[super dealloc];
}

@end
