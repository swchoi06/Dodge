//
//  DodgeEndGame.h
//  Dodge
//
//  Created by Sukwon Choi on 9/8/14.
//  Copyright (c) 2014 Wafflestudio. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface DodgeEndGame : SKScene

//Nodes
@property (nonatomic) SKSpriteNode *buttonRestart;
@property (nonatomic) SKSpriteNode *buttonShare;
@property (nonatomic) SKSpriteNode *backBar;

//Labels
@property (nonatomic) SKLabelNode *labelScore;
@property (nonatomic) SKLabelNode *labelScoreText;

@property (nonatomic) SKLabelNode *labelBestScore;
@property (nonatomic) SKLabelNode *labelBestScoreText;

@end
