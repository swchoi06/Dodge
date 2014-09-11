//
//  MainScene.h
//  Dodge
//
//  Created by Sukwon Choi on 9/8/14.
//  Copyright (c) 2014 Wafflestudio. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface MainScene : SKScene

@property BOOL contentCreated;

//Nodes
@property (nonatomic) SKSpriteNode *buttonStart;
@property (nonatomic) SKSpriteNode *logo;

//Labels
@property (nonatomic) SKLabelNode *bestScore;
@property (nonatomic) SKLabelNode *bestScoreLabel;

@end
