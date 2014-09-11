//
//  DodgeGameSetting.h
//  Dodge
//
//  Created by Sukwon Choi on 9/8/14.
//  Copyright (c) 2014 Wafflestudio. All rights reserved.
//

#ifndef Dodge_DodgeGameSetting_h
#define Dodge_DodgeGameSetting_h

//Color
#define BACKGROUND_COLOR_GAME [UIColor colorWithRed:(255/255.0) green:(255/255.0) blue:(255/255.0) alpha:1]
#define BACKGROUND_COLOR_MENU [UIColor colorWithRed:(240/255.0) green:(240/255.0) blue:(240/255.0) alpha:1]

#define FONT_COLOR_DARK [UIColor colorWithRed:(52/255.0) green:(52/255.0) blue:(52/255.0) alpha:1]
#define FONT_COLOR_WHITE [UIColor colorWithRed:(255/255.0) green:(255/255.0) blue:(255/255.0) alpha:1]

#define COLOR_FOR_START_MESSAGE_BAR [UIColor colorWithRed:(243/255.0) green:(201/255.0) blue:(94/255.0) alpha:1]
#define COLOR_FOR_GUIDED_MISSILE [UIColor redColor]
#define COLOR_FOR_GAME_CENTER [UIColor colorWithRed:(255/255.0) green:(255/255.0) blue:(255/255.0) alpha:0]

//Interface
#define NORMAL_MODE 0
#define HARDCORE_MODE 1

#define FONT_SIZE 17
#define FONT_SIZE_BIG 30
#define FONT_SIZE_LABEL_SCORE 36
#define FONT_SIZE_END 35

#define SIZE_OF_BUTTON_START self.size.width / 100 * 45
#define SIZE_OF_BUTTON_TWITTER self.size.width / 100 * 20
#define SIZE_OF_BUTTON_RESTART self.size.width / 100 * 30
#define SIZE_OF_LOGO self.size.width / 100 * 80
#define SIZE_OF_START_MESSAGE_BAR self.frame.size.height / 100 * 20

#define SIZE_OF_PIXEL self.size.width / 100 * 10
#define SIZE_OF_PLAYER self.size.width / 100 * 5
#define SIZE_OF_PLAYER_PHYSICAL_BODY self.size.width / 100 *3

#define PLAYER_LOCATION_OFFSET 50

#define SIZE_OF_WIDTH self.frame.size.width
#define SIZE_OF_HEIGHT self.frame.size.height

#define POSITION_OF_START_MESSAGE_BAR self.frame.size.height / 100 * 15

#define START_MESSAGE @"DRAG TO START"

//Game setting
#define START_ANIMATION_TIME 0.2

#define TARGET_START_POSITION self.frame.size.height / 100 * 120

#define SPACE_HEIGHT_FOR_PIXEL self.frame.size.height / 100 * 20
#define SPACE_HEIGHT_FOR_LABEL self.frame.size.height / 100 * 90

#define MAX_SPEED -600
#define HARDCORE_MAX_SPEED -650

#define DEFAULT_ROCK_INTERVAL 0.09
#define HARDCORE_ROCK_INTERVAL 0.07

#define HARDCORE_THRESHOLD 50



#endif
