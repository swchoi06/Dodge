//
//  SpaceshipScene.h
//  SpriteWalkthrough
//
//  Created by Sukwon Choi on 8/25/14.
//  Copyright (c) 2014 Wafflestudio. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "DodgeSound.h"

@interface DodgeScene : SKScene <SKPhysicsContactDelegate>{

}
//Nodes
@property (nonatomic) SKSpriteNode *player;
@property (nonatomic) SKSpriteNode *startMessageBar;

//Labels
@property (nonatomic) SKLabelNode *labelScore;
@property (nonatomic) SKLabelNode *startMessageLabel;


@end
