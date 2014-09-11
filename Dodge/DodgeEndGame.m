//
//  DodgeEndGame.m
//  Dodge
//
//  Created by Sukwon Choi on 9/8/14.
//  Copyright (c) 2014 Wafflestudio. All rights reserved.
//

#import "DodgeEndGame.h"
#import "DodgeScene.h"
#import "DodgeSound.h"
#import "DodgeGameSetting.h"

@implementation DodgeEndGame{
    DodgeSound *sound;
}

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        //Set background color
        self.backgroundColor = BACKGROUND_COLOR_MENU;
        
        //Send message to RPViewController to show iAd.
        [[NSNotificationCenter defaultCenter] postNotificationName:@"showAd" object:nil];
        
        //Initial sound class
        sound = [[DodgeSound alloc] init];
        [sound initSound];
        
        //Set best score
        if ([[NSUserDefaults standardUserDefaults] doubleForKey:@"score"] > [[NSUserDefaults standardUserDefaults] doubleForKey:@"bestScore"]) {
            [[NSUserDefaults standardUserDefaults] setDouble:[[NSUserDefaults standardUserDefaults] doubleForKey:@"score"] forKey:@"bestScore"];
        }
        
        //Set objects
        [self setButtonRestart];
        [self setButtonShare];
        [self setLabels];
        [self setBackBar];
    }
    return self;
}

#pragma mark Interface

- (void)setButtonRestart {
    //Set object image size and position.
    _buttonRestart = [SKSpriteNode spriteNodeWithImageNamed:@"buttonRestart"];
    _buttonRestart.size = CGSizeMake(SIZE_OF_BUTTON_RESTART, SIZE_OF_BUTTON_RESTART);
    _buttonRestart.position = CGPointMake(self.size.width / 2, self.size.height / 100 * 35);
    //Add object to scene
    [self addChild:_buttonRestart];
}

- (void)setButtonShare {
    //Set object image size and position.
    _buttonShare = [SKSpriteNode spriteNodeWithImageNamed:@"buttonTwitter"];
    _buttonShare.size = CGSizeMake(SIZE_OF_BUTTON_TWITTER, SIZE_OF_BUTTON_TWITTER);
    _buttonShare.position = CGPointMake(self.size.width / 2, self.size.height / 100 * 15);
    //Add object to scene
    [self addChild:_buttonShare];
}

- (void)setBackBar {
    //Set object image size and position.
    _backBar = [SKSpriteNode spriteNodeWithImageNamed:@"backBarEndScene"];
    _backBar.size = CGSizeMake(SIZE_OF_LOGO, SIZE_OF_START_MESSAGE_BAR);
    _backBar.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 100 * 70);
    _backBar.zPosition = 35;
    //Add object to scene
    [self addChild:_backBar];
}

- (void)setLabels {
    //Set font style
    _labelScore = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    //Set different font size to any device
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ){
        _labelScore.fontSize = FONT_SIZE_END * 2;
    }
    else {
        _labelScore.fontSize = FONT_SIZE_END;
    }
    //Set font color
    _labelScore.fontColor = FONT_COLOR_DARK;
    //Set positions of object
    _labelScore.position = CGPointMake(self.frame.size.width / 4, self.frame.size.height / 100 * 65);
    _labelScore.zPosition = 40;
    //Set text to label
    _labelScore.text = [NSString stringWithFormat:@"%.2f", (double)[[NSUserDefaults standardUserDefaults] doubleForKey:@"score"]];
    //Add object to scene
    [self addChild:_labelScore];
    
    //Set font style
    _labelScoreText = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    //Set different font size to any device
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ){
        _labelScoreText.fontSize = FONT_SIZE * 2;
    }
    else {
        _labelScoreText.fontSize = FONT_SIZE;
    }
    //Set font color
    _labelScoreText.fontColor = FONT_COLOR_DARK;
    //Set positions of object
    _labelScoreText.position = CGPointMake(self.frame.size.width / 4, self.frame.size.height / 100 * 75);
    _labelScoreText.zPosition = 40;
    //Set text to label
    _labelScoreText.text = @"You score";
    //Add object to scene
    [self addChild:_labelScoreText];
    
    
    
    
    
    //Set font style
    _labelBestScore = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    //Set different font size to any device
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ){
        _labelBestScore.fontSize = FONT_SIZE_END * 2;
    }
    else {
        _labelBestScore.fontSize = FONT_SIZE_END;
    }
    //Set font color
    _labelBestScore.fontColor = FONT_COLOR_DARK;
    //Set positions of object
    _labelBestScore.position = CGPointMake(self.frame.size.width *3  / 4, self.frame.size.height / 100 * 65);
    _labelBestScore.zPosition = 40;
    //Set text to label
    _labelBestScore.text = [NSString stringWithFormat:@"%.2f", (double)[[NSUserDefaults standardUserDefaults] doubleForKey:@"bestScore"]];
    //Add object to scene
    [self addChild:_labelBestScore];
    
    //Set font style
    _labelBestScoreText = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    //Set different font size to any device
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ){
        _labelBestScoreText.fontSize = FONT_SIZE * 2;
    }
    else {
        _labelBestScoreText.fontSize = FONT_SIZE;
    }
    //Set font color
    _labelBestScoreText.fontColor = FONT_COLOR_DARK;
    //Set positions of object
    _labelBestScoreText.position = CGPointMake(self.frame.size.width *3 / 4, self.frame.size.height / 100 * 75);
    _labelBestScoreText.zPosition = 40;
    //Set text to label
    _labelBestScoreText.text = @"best score";
    //Add object to scene
    [self addChild:_labelBestScoreText];
}

#pragma mark Programm

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //Get location
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        //If touch restart button
        if ([_buttonRestart containsPoint:location]) {
            //Change scene
            [self changeSceneToGame];
            //Play sound
            [sound playSoundButtonClick];
        }
        //If touch twitter button
        if ([_buttonShare containsPoint:location]) {
            //Call method from RPViewController.m for get twitter message
            [[NSNotificationCenter defaultCenter] postNotificationName:@"sendTwitter" object:nil];
            //Playe sound
            [sound playSoundButtonClick];
        }
    }
}

#pragma mark Change Scene

- (void)changeSceneToGame {
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    // Create and configure the scene.
    SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
    SKScene *level = [[DodgeScene alloc] initWithSize:skView.bounds.size];
    
    [self.view presentScene:level transition:reveal];
}

@end
