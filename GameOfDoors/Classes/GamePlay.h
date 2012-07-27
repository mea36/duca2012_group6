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
	CCSprite *heart1;
	CCSprite *heart2;
	CCSprite *heart3;
	CCSprite *star1;
	CCSprite *star2;
	CCSprite *star3;
	CCSprite *doorImage1;
	CCSprite *doorImage2;
	CCSprite *doorImage3;
	CCSprite *tagImage1;
	CCSprite *tagImage2;
	CCSprite *tagImage3;
	CCSprite *clockImage;
	CCSprite *enterDoorButton;
	CCSprite *star;
	CCSprite *tornado;
	
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
	int whatRoomAmIAt;
	int clock;
	int second;
	int hour;
	int starCount;
	int door1Timer;
	int door2Timer;
	int door3Timer;
	int tornadoTimer;
	int tornadoTimerMax;
	int tornadoSpeed;
	int lives;
	float jumptime;
	float myY;
	float myX;
	float tornadoY;
	float tornadoX;
	BOOL areYouEnteringDoor;
	BOOL youAreJumping;
	BOOL youAreCurrentlyJumping;
	BOOL youAreClickingTheEnterDoorButton;
	BOOL movingLeft;
	BOOL movingRight;
	BOOL theresAnObjectInDoorway1;
	BOOL theresAnObjectInDoorway2;
	BOOL theresAnObjectInDoorway3;
	BOOL youHaveStar1;
	BOOL youHaveStar2;
	BOOL youHaveStar3;
	BOOL theresATornado;
	BOOL theresDefinitelyATornado;
	BOOL deleteThatStuff;
	BOOL youJustLostALife;
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
@property (nonatomic, retain) CCSprite *doorImage1;
@property (nonatomic, retain) CCSprite *doorImage2;
@property (nonatomic, retain) CCSprite *doorImage3;
@property (nonatomic, retain) CCSprite *tagImage1;
@property (nonatomic, retain) CCSprite *tagImage2;
@property (nonatomic, retain) CCSprite *tagImage3;
@property (nonatomic, retain) CCSprite *heart1;
@property (nonatomic, retain) CCSprite *heart2;
@property (nonatomic, retain) CCSprite *heart3;
@property (nonatomic, retain) CCSprite *star1;
@property (nonatomic, retain) CCSprite *star2;
@property (nonatomic, retain) CCSprite *star3;
@property (nonatomic, retain) CCSprite *clockImage;
@property (nonatomic, retain) CCSprite *enterDoorButton;
@property (nonatomic, retain) CCSprite *star;
@property (nonatomic, retain) CCSprite *tornado;
@property (nonatomic, retain) NSMutableArray *doorType;
@property (nonatomic, retain) NSMutableArray *doorHeight;
@property (nonatomic, retain) NSMutableArray *doorOpen;

@end
