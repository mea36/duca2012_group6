//
//  GameDoor.m
//  GOD
//
//  Created by DUCA on 7/24/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GameDoor.h"
#import "GamePlay.h"


@implementation GameDoor

+(id) scene{
	CCScene *scene = [CCScene node];
	
	GameDoor *layer = [GameDoor node];
	
	
	[scene addChild: layer];
	
	return scene;
}

-(id) init{
	if ( (self=[super init] )) {
		
	}
}

@end
