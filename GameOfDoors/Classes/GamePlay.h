//
//  GamePlay.h
//  GOD
//
//  Created by DUCA on 7/20/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "SimpleAudioEngine.h"


@interface GamePlay : CCLayer //NSObject 
{
	CCSprite *player;
	CCSprite *background;
	
	CCSprite *backgroundDoor1;
	CCSprite *backgroundDoor2;
	CCSprite *backgroundDoor3;
	CCSprite *clockImage;
	CCSprite *enterDoorButton;
	
	float x;
	float y;
	float playerX;
	float playerY;
	float playerSpeed;
	int winWidth;
	int winHeight;
	int tag;
	int timer;
	int playerTag;
	int anotherTimer;
	int whatDoorAmIAt;
	int clock;
	int second;
	int hour;
	float jumptime;
	float myY;
	float myX;
	BOOL areYouEnteringDoor;
	BOOL youAreJumping;
	BOOL youAreCurrentlyJumping;
	BOOL youAreClickingTheEnterDoorButton;
	NSMutableArray *doorType;
	NSMutableArray *doorHeight;
	NSMutableArray *doorOpen;
	
	enum {
		Floor1,
		Floor2,
		Floor3,
		Floor4
	} Floor;
	
	enum {
		Room1,
		Room2,
		Room3
	} Room;
	
	enum {
		NoDoor,
		Door1,
		Door2,
		Door3
	} Door;
}

@property (nonatomic, retain) CCSprite *player;
@property (nonatomic, retain) CCSprite *background;
@property (nonatomic, retain) CCSprite *backgroundDoor1;
@property (nonatomic, retain) CCSprite *backgroundDoor2;
@property (nonatomic, retain) CCSprite *backgroundDoor3;
@property (nonatomic, retain) CCSprite *clockImage;
@property (nonatomic, retain) CCSprite *enterDoorButton;
@property (nonatomic, retain) NSMutableArray *doorType;
@property (nonatomic, retain) NSMutableArray *doorHeight;
@property (nonatomic, retain) NSMutableArray *doorOpen;
@end
