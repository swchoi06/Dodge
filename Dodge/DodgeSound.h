//
//  DodgeSound.h
//  Dodge
//
//  Created by Sukwon Choi on 9/8/14.
//  Copyright (c) 2014 Wafflestudio. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface DodgeSound : NSObject <AVAudioRecorderDelegate, AVAudioPlayerDelegate> {
    SystemSoundID buttonClick;
    SystemSoundID endGame;
    SystemSoundID getOnePoint;
    
    AVAudioPlayer *audioPlayer;
}

-(void)initSound;

-(void)playSoundButtonClick;
-(void)playEndGame;
-(void)playGetOnePoint;

@end