//
//  DodgeSound.m
//  Dodge
//
//  Created by Sukwon Choi on 9/8/14.
//  Copyright (c) 2014 Wafflestudio. All rights reserved.
//

#import "DodgeSound.h"

@implementation DodgeSound
-(void)initSound{
    //Init sounds
    NSURL *buttonClickURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"buttonClick" ofType:@"mp3"]];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)buttonClickURL, &buttonClick);
    NSURL *endGameClickURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"endGame" ofType:@"mp3"]];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)endGameClickURL, &endGame);
    NSURL *getOnePointURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"getOnePoint" ofType:@"mp3"]];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)getOnePointURL, &getOnePoint);
}

//Play sound methods

-(void)playSoundButtonClick {
    //If buttonClick initial play sound if not initial him and play.
    if (buttonClick) {
        AudioServicesPlaySystemSound(buttonClick);
    }
    else {
        [self initSound];
        [self playSoundButtonClick];
    }
}

-(void)playEndGame {
    //If endGame initial play sound if not initial him and play.
    if (endGame) {
        AudioServicesPlaySystemSound(endGame);
    }
    else {
        [self initSound];
        [self playEndGame];
    }
}

-(void)playGetOnePoint {
    //If getOnePoint initial play sound if not initial him and play.
    if (getOnePoint) {
        AudioServicesPlaySystemSound(getOnePoint);
    }
    else {
        [self initSound];
        [self playGetOnePoint];
    }
}

@end
