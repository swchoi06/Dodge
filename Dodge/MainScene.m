//
//  MainScene.m
//  Dodge
//
//  Created by Sukwon Choi on 9/8/14.
//  Copyright (c) 2014 Wafflestudio. All rights reserved.
//

#import "MainScene.h"
#import "DodgeScene.h"
#import "DodgeGameSetting.h"
#import "DodgeSound.h"



@interface MainScene (){
    DodgeSound *sound;
}
@end

@implementation MainScene
@synthesize contentCreated;

- (void)didMoveToView:(SKView *)view{
    if(!self.contentCreated){
        [self createSceneContents];
        self.contentCreated = YES;
    }
}
-(void)createSceneContents{
    //Set background color
    self.backgroundColor = BACKGROUND_COLOR_MENU;
    
    //Send message to RPViewController to hide iAd.
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hideAd" object:nil];
    
    //Initial sound classs
    sound = [[DodgeSound alloc] init];
    [sound initSound];
    
    //Set interface
    [self setButtonStart];
    [self setLogo];
    [self setLabels];
}
#pragma mark Interface

- (void)setButtonStart {
    //Set object image size and position.
    _buttonStart = [SKSpriteNode spriteNodeWithImageNamed:@"buttonStart"];
    _buttonStart.size = CGSizeMake(SIZE_OF_BUTTON_START, SIZE_OF_BUTTON_START);
    _buttonStart.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    _buttonStart.zPosition = 40;
    //Add object to scene
    [self addChild:_buttonStart];
}

- (void)setLogo {
    //Set object image size and position.
    _logo = [SKSpriteNode spriteNodeWithImageNamed:@"logo"];
    _logo.size = CGSizeMake(SIZE_OF_LOGO, SIZE_OF_LOGO / 3);
    _logo.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 100 * 85);
    _logo.zPosition = 45;
    //Add object to scene
    [self addChild:_logo];
}

- (void)setLabels {
    //Set font type
    _bestScore = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    //Set different font size to any device
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ){
        _bestScore.fontSize = FONT_SIZE_BIG * 2;
    }
    else {
        _bestScore.fontSize = FONT_SIZE_BIG;
    }
    //Set font color
    _bestScore.fontColor = FONT_COLOR_DARK;
    //Set object positions
    _bestScore.zPosition = 30;
    _bestScore.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 100 * 10);
    //Set label text
    _bestScore.text = [NSString stringWithFormat:@"%ld", (long)[[NSUserDefaults standardUserDefaults] integerForKey:@"bestScore"]];
    //Add object to scene
    [self addChild:_bestScore];
    
    //Set font type
    _bestScoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    //Set different font size to any device
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ){
        _bestScoreLabel.fontSize = FONT_SIZE * 2;
    }
    else {
        _bestScoreLabel.fontSize = FONT_SIZE;
    }
    //Set font color
    _bestScoreLabel.fontColor = FONT_COLOR_DARK;
    //Set object positions
    _bestScoreLabel.zPosition = 30;
    _bestScoreLabel.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 100 * 5);
    //Set label text
    _bestScoreLabel.text = [NSString stringWithFormat:@"Best score"];
    //Add object to scene
    [self addChild:_bestScoreLabel];
}


#pragma mark Programm

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //Get location
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        //If touch _buttonStart
        if ([_buttonStart containsPoint:location])
        {
            //Change scene
            [self changeSceneToGame];
            //Play sound
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
