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

@implementation GamePlay
@synthesize player, doorType;
@synthesize background;
@synthesize doorHeight, backgroundDoor1, backgroundDoor2, backgroundDoor3;
@synthesize doorOpen, clockImage, enterDoorButton;
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
		clock=1;
		second=1;
		hour=11;
		/*
		self.background = [CCSprite spriteWithFile:@"floor0.png"];
		self.background.tag = 101;
		self.background.anchorPoint = ccp(0,0);
		[self addChild:self.background z:-1];
		*/
		self.background = [CCSprite spriteWithFile:@"Backgroundfloor.png"];
		self.background.anchorPoint = ccp(0,0);
		[self addChild:self.background z:-2];
		[self schedule:@selector(replaceBackground:)];
		
		self.enterDoorButton = [CCSprite spriteWithFile:@"Enterdoor.png"];
		self.enterDoorButton.tag = 999;
		self.enterDoorButton.position = ccp(445,295);
		[self addChild:self.enterDoorButton z:0];
		
		self.clockImage = [CCSprite spriteWithFile:@"Clock_1-00.png"];
		self.clockImage.position = ccp(winWidth/2,260);
		self.clockImage.tag = 1000;
		[self addChild:self.clockImage z:0];
		
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
				[self.doorType addObject:[NSString stringWithFormat:@"%d", arc4random()%2+1]];
			}
		}
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
		NSLog(@"%@", self.doorHeight);
		
		int j;
		self.doorOpen = [NSMutableArray array];
		for (j=0; j<36; j++) {
			[self.doorOpen addObject:[NSString stringWithFormat:@"%d", 0]];
		}
	}
	return self;
}

-(void)rotate:(ccTime) dt{
	[[CCDirector sharedDirector] setDeviceOrientation:CCDeviceOrientationLandscapeLeft];
	[self unschedule:@selector(rotate:)];
}

-(void)replaceBackground:(ccTime) dt{
	NSLog(@"background called");
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
	
	[self unschedule:@selector(replaceBackground:)];
}

-(void) enterDoor:(ccTime) dt{
	//NSLog(@"enterDoor called");
	
	int mySwitch = [[self.doorType objectAtIndex:(whatDoorAmIAt)] intValue];
	
	switch (mySwitch) {
		case 1:
			NSLog(@"Bad Door");
			if ([[self.doorOpen objectAtIndex:whatDoorAmIAt] intValue] == 0) {
				[self.doorOpen replaceObjectAtIndex:whatDoorAmIAt withObject:@"1"];
				//[[SimpleAudioEngine sharedEngine] playEffect:@"door-3-open.mp3"];
			}
			else if ([[self.doorOpen objectAtIndex:whatDoorAmIAt] intValue] == 1) {
				[self.doorOpen replaceObjectAtIndex:whatDoorAmIAt withObject:@"0"];
				//[[SimpleAudioEngine sharedEngine] playEffect:@"door-3-close.mp3"];
			}
			[self removeChildByTag:101 cleanup:YES];
			[self removeChildByTag:102 cleanup:YES];
			[self removeChildByTag:103 cleanup:YES];
			[self schedule:@selector(replaceBackground:) interval:0.0];
			break;
		case 2:
			NSLog(@"Good Door");
			if ([[self.doorOpen objectAtIndex:whatDoorAmIAt] intValue] == 0) {
				[self.doorOpen replaceObjectAtIndex:whatDoorAmIAt withObject:@"1"];
				//[[SimpleAudioEngine sharedEngine] playEffect:@"door-3-open.mp3"];
			}
			else if ([[self.doorOpen objectAtIndex:whatDoorAmIAt] intValue] == 1) {
				[self.doorOpen replaceObjectAtIndex:whatDoorAmIAt withObject:@"0"];
				//[[SimpleAudioEngine sharedEngine] playEffect:@"door-3-close.mp3"];
			}
			[self removeChildByTag:101 cleanup:YES];
			[self removeChildByTag:102 cleanup:YES];
			[self removeChildByTag:103 cleanup:YES];
			[self schedule:@selector(replaceBackground:) interval:0.0];
			break;
		case 3:
			NSLog(@"Game Door");
			break;
		case 4:
			NSLog(@"Stairs Up");
			Floor++;
			Room = Room1;
			
			self.player.position = ccp(86, self.player.position.y);
			[self removeChildByTag:101 cleanup:YES];
			[self removeChildByTag:102 cleanup:YES];
			[self removeChildByTag:103 cleanup:YES];
			[self schedule:@selector(replaceBackground:) interval:0.0];
			break;
		case 5:
			NSLog(@"Stairs Down");
			Floor--;
			Room = Room3;
			
			self.player.position = ccp(395, self.player.position.y);
			[self removeChildByTag:101 cleanup:YES];
			[self removeChildByTag:102 cleanup:YES];
			[self removeChildByTag:103 cleanup:YES];
			[self schedule:@selector(replaceBackground:) interval:0.0];
			break;
		case 6:
			NSLog(@"You Win");
			break;
		default:
			break;
	}
	areYouEnteringDoor = NO;
	[self unschedule:@selector(enterDoor:)];
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
	clock++;
	if (clock%60 == 0) {
		second++;
	}
	if (clock%(12*60)==0) {
		hour++;
	}
	
	self.enterDoorButton = [CCSprite spriteWithFile:@"Enterdoor.png"];
	self.enterDoorButton.tag = 999;
	self.enterDoorButton.position = ccp(445,295);
	[self addChild:self.enterDoorButton z:0];
	
	//NSString *seconds = (String)second;
	//clock
	NSString *clockFile = [NSString stringWithFormat:@"Clock_%d-%d.png", hour%12 +1, (second-1)%12*5];
	self.clockImage = [CCSprite spriteWithFile:clockFile];
	self.clockImage.position = ccp(winWidth/2,260);
	self.clockImage.tag = 1000;
	[self addChild:self.clockImage z:0];
	
}

-(void) moveSprite:(ccTime) dt{
	if (x > 415 && x < 475 && y < 315 && y > 285 && Door != NoDoor) {
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
		if ((self.player.position.x + self.player.contentSize.width/4) > winWidth) {
			Room++;
		
			self.player.position = ccp(self.player.contentSize.width/4, self.player.position.y);
			[self removeChildByTag:101 cleanup:YES];
			[self removeChildByTag:102 cleanup:YES];
			[self removeChildByTag:103 cleanup:YES];
			[self schedule:@selector(replaceBackground:) interval:0.0];
		}
		if ((self.player.position.x - self.player.contentSize.width/4) < 0) {
			Room--;
							
			self.player.position = ccp(winWidth - self.player.contentSize.width/4, self.player.position.y);
			[self removeChildByTag:101 cleanup:YES];
			[self removeChildByTag:102 cleanup:YES];
			[self removeChildByTag:103 cleanup:YES];
			[self schedule:@selector(replaceBackground:) interval:0.0];
		}
		
		if (x < winWidth/2 - 80) //self.player.position.x) 
		{
			self.player.position = ccp(self.player.position.x - playerSpeed, self.player.position.y);
		}
	
		if (x > winWidth/2 + 80 && youAreClickingTheEnterDoorButton == NO) //self.player.position.x) 
		{
			self.player.position = ccp(self.player.position.x + playerSpeed, self.player.position.y);
		}
	}
	if (Room == Room3) {
		if (self.player.position.x - self.player.contentSize.width/4 < 0) {
			
			Room--;
			
			self.player.position = ccp(winWidth - self.player.contentSize.width/4, self.player.position.y);
			[self removeChildByTag:101 cleanup:YES];
			[self removeChildByTag:102 cleanup:YES];
			[self removeChildByTag:103 cleanup:YES];
			[self schedule:@selector(replaceBackground:) interval:0.0];
		}		
		if (x < winWidth/2 - 80) //self.player.position.x) 
		{
			self.player.position = ccp(self.player.position.x - playerSpeed, self.player.position.y);
		}
		if (x > winWidth/2 + 80 && self.player.position.x + self.player.contentSize.height/4 < winWidth && youAreClickingTheEnterDoorButton == NO) 
		{
			self.player.position = ccp(self.player.position.x + playerSpeed, self.player.position.y);
		}
		
	}
	if (Room == Room1) {
		if (self.player.position.x + self.player.contentSize.width/4 > winWidth) {
			
			Room++;
			
			self.player.position = ccp(self.player.contentSize.width/4, self.player.position.y);
			[self removeChildByTag:101 cleanup:YES];
			[self removeChildByTag:102 cleanup:YES];
			[self removeChildByTag:103 cleanup:YES];
			[self schedule:@selector(replaceBackground:) interval:0.0];
		}		
		if (x < winWidth/2 - 80 && self.player.position.x - self.player.contentSize.height/4 > 0) 
		{
			self.player.position = ccp(self.player.position.x - playerSpeed, self.player.position.y);
		}
		if (x > winWidth/2 + 80 && youAreClickingTheEnterDoorButton == NO) 
		{
			self.player.position = ccp(self.player.position.x + playerSpeed, self.player.position.y);
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

-(void) jump_animation{
	NSLog(@"jump animation called");
	//[self schedule:@selector(jump_animation)]; for calling method(1/60 sec)
	youAreCurrentlyJumping = YES;
	jumptime++; //jumptime = 0; where the jump method is called
	float yCoordinate = (498.2)*(jumptime/60)-(428.75)*(jumptime/60)*(jumptime/60);
	NSLog(@"yCoordinate = %f", yCoordinate);
	[self removeChildByTag:playerTag cleanup:YES];
	self.player = [CCSprite spriteWithFile:@"Standing.png"]; //need a jumping image
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
}

@end
