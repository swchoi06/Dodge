//
//  SpaceshipScene.m
//  SpriteWalkthrough
//
//  Created by Sukwon Choi on 8/25/14.
//  Copyright (c) 2014 Wafflestudio. All rights reserved.
//

#import "DodgeScene.h"
#import "DodgeGameSetting.h"
#import "DodgeEndGame.h"

@interface DodgeScene (){
    BOOL gameStart;
    
    double scoreGame;
    int stage;
    DodgeSound *sound;
}

@property BOOL contentCreated;
@end


@implementation DodgeScene
@synthesize player;
@synthesize startMessageBar, startMessageLabel;
@synthesize labelScore;

//Physic contact category

static const uint32_t playerCategory = 0x1 << 0;
static const uint32_t targetCategory = 0x1 << 1;

- (id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        //Set background color
        self.backgroundColor = BACKGROUND_COLOR_GAME;
        
        //Send message to RPViewController to hide iAd.
        [[NSNotificationCenter defaultCenter] postNotificationName:@"hideAd" object:nil];
        
        //Initial sounds class
        sound = [[DodgeSound alloc] init];
        [sound initSound];
        
        //Set gravity
        self.physicsWorld.contactDelegate = self;
        
        //Set objects
        [self setStartMessageBar];
    }
    return self;
}


#pragma mark Interface



- (void)setLabelScore {
    
    //Set label score set font type, color and other
    
    labelScore = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    
    labelScore.fontColor = FONT_COLOR_DARK;
    
    //Set diffirent font size if app run on iPad or iPhone
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ){
        
        labelScore.fontSize = FONT_SIZE_LABEL_SCORE * 2;
        
    }
    
    else {
        
        labelScore.fontSize = FONT_SIZE_LABEL_SCORE;
        
    }
    
    labelScore.position = CGPointMake(self.size.width / 2, SPACE_HEIGHT_FOR_LABEL);
    
    labelScore.text = @"0";
    
    labelScore.zPosition = 50;
    
    
    
    //Add to scene
    
    [self addChild:labelScore];
    
}

- (void)setRocks{
    [self removeActionForKey:@"createRocks"];
    SKAction *makeRocks;
    // 일반 모드
    if(stage == NORMAL_MODE){
        makeRocks = [SKAction sequence: @[
                                          [SKAction performSelector:@selector(addRock) onTarget:self],
                                          [SKAction waitForDuration:DEFAULT_ROCK_INTERVAL withRange:0.15]
                                          ]];
    }
    // 하드 모드
    else{
        makeRocks = [SKAction sequence: @[
                                          [SKAction performSelector:@selector(addRock) onTarget:self],
                                          [SKAction waitForDuration:HARDCORE_ROCK_INTERVAL withRange:0.15]
                                          ]];
    }
    
    [self runAction: [SKAction repeatActionForever:makeRocks] withKey:@"createRocks"];
}

- (void)setMissiles{
    SKAction *makeMissiles = [SKAction sequence: @[
                                                [SKAction waitForDuration:10],
                                                [SKAction performSelector:@selector(addGuidedMissile) onTarget:self]
                                                ]];
    [self runAction:[SKAction repeatActionForever:makeMissiles] withKey:@"createMissiles"];
}


#pragma mark Node



- (void)setPlayerToLocation:(CGPoint)location {
    location = CGPointMake(location.x, location.y+PLAYER_LOCATION_OFFSET);
    //Set different skin color to game object player
    
    player = [[SKSpriteNode alloc] initWithImageNamed:@"Spaceship"];
    
    player.name = @"player";
    
    
    
    //Set size and positions
    
    player.size = CGSizeMake(SIZE_OF_PLAYER, SIZE_OF_PLAYER);
    
    player.position = CGPointMake(location.x, SPACE_HEIGHT_FOR_PIXEL);
    
    player.zPosition = 40;
    
    
    
    //Setting physicsBody stats
    
    //Initial physicsBody
    
    player.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(SIZE_OF_PLAYER_PHYSICAL_BODY, SIZE_OF_PLAYER_PHYSICAL_BODY)];
    
    
    
    //Setting bitMask
    player.physicsBody.contactTestBitMask = targetCategory;
    player.physicsBody.categoryBitMask = playerCategory;
    
    
    //Set gravity stats
    
    player.physicsBody.affectedByGravity = NO;
    player.physicsBody.mass = 1000000;
    
    
    
    //Add to scene
    
    [self addChild:player];
    
}



static inline CGFloat skRandf() {
    return rand() / (CGFloat) RAND_MAX;
}

static inline CGFloat skRand(CGFloat low, CGFloat high) {
    return skRandf() * (high - low) + low;
}

- (CGPoint) randPosition{
    return CGPointMake(skRand(0, SIZE_OF_WIDTH), SIZE_OF_HEIGHT);
}

- (void)addRock
{
    SKSpriteNode *rock;
    if(stage == NORMAL_MODE){
        rock = [[SKSpriteNode alloc] initWithColor:[SKColor brownColor] size:CGSizeMake(8,8)];
    }else{
        rock = [[SKSpriteNode alloc] initWithColor:[SKColor purpleColor] size:CGSizeMake(8,8)];
    }
    rock.position = CGPointMake(skRand(0, self.size.width), self.size.height+50);
    rock.name = @"rock";
    rock.physicsBody.dynamic = YES;
    rock.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:rock.size];
    rock.physicsBody.usesPreciseCollisionDetection = NO;
    rock.physicsBody.categoryBitMask = targetCategory;
    rock.physicsBody.collisionBitMask = playerCategory;
    rock.physicsBody.contactTestBitMask = playerCategory;
    
    [self addChild:rock];
}

- (void)addGuidedMissile{
    SKSpriteNode *missile = [[SKSpriteNode alloc] initWithColor:COLOR_FOR_GUIDED_MISSILE size:CGSizeMake(15, 15)];
    missile.position = [self randPosition];
    missile.name = @"missile";
    missile.physicsBody.dynamic = NO;
    missile.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:missile.size];
    missile.physicsBody.usesPreciseCollisionDetection = NO;
    missile.physicsBody.categoryBitMask = targetCategory;
    missile.physicsBody.collisionBitMask = playerCategory;
    missile.physicsBody.contactTestBitMask = playerCategory;
    
    [self addChild:missile];
}


- (void)updateMissile{
    // update Missile
    [self enumerateChildNodesWithName:@"missile" usingBlock:^(SKNode *node, BOOL *stop) {
        CGVector offset = CGVectorMake( (player.position.x - node.position.x)/100, (player.position.y+1500 - node.position.y)/100);
        [node.physicsBody applyForce:offset];
    }];
}



- (void)setStartMessageBar {
    
    //Set different skin color to game object
    
    startMessageBar = [SKSpriteNode spriteNodeWithColor:COLOR_FOR_START_MESSAGE_BAR size:CGSizeMake(0, 0)];
    
    
    
    //Set size and positions
    
    startMessageBar.size = CGSizeMake(self.frame.size.width, SIZE_OF_START_MESSAGE_BAR);
    
    startMessageBar.position = CGPointMake(self.frame.size.width / 2, POSITION_OF_START_MESSAGE_BAR);
    
    startMessageBar.zPosition = 50;
    
    //Add object to scene
    
    [self addChild:startMessageBar];
    
    
    
    //Setting font
    
    startMessageLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    
    //Set different font size for any device
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ){
        
        startMessageLabel.fontSize = FONT_SIZE_BIG * 2;
        
    }
    
    else {
        
        startMessageLabel.fontSize = FONT_SIZE_BIG;
        
    }
    
    
    
    //Set position of object
    
    startMessageLabel.position = CGPointMake(startMessageBar.position.x, startMessageBar.position.y - (self.frame.size.height / 100 * 2.5));
    
    startMessageLabel.zPosition = 55;
    
    //Setting message to view. See RPSetting game
    
    startMessageLabel.text = START_MESSAGE;
    
    //Add object to scene
    
    [self addChild:startMessageLabel];
    
}





#pragma mark Game



- (void)startGame {
    
    //Start game method
    
    //Set lebel to view
    [self setLabelScore];
    [self setRocks];
    [self setMissiles];
    
    //Set standart setting
    
    gameStart = YES;
    
    scoreGame = 0;
    stage = NORMAL_MODE;
    
    //Hide start game message bar
    
    [self hideMessageBar];
    
}



- (void)endGame {
    //Change score stat
    [[NSUserDefaults standardUserDefaults] setDouble:scoreGame forKey:@"score"];
    
    //Change view and play sound end game
    [self changeSceneToEnd];
    [sound playEndGame];
}

-(void)openHardcore{
    NSLog(@"open Hardcore");
    stage = HARDCORE_MODE;
    [self removeActionForKey:@"createRocks"];
    [self setRocks];
}




- (void)updateLabel {
    
    //Update score label
    
    labelScore.text = [NSString stringWithFormat:@"%.2f", scoreGame];
    
}




- (void)hideMessageBar {
    
    //Animation to hide message bar
    
    //Animation to move message bar
    
    SKAction *actionMove = [SKAction moveTo:player.position duration:START_ANIMATION_TIME];
    
    //Animation to change size message bar
    
    SKAction *actionChangeSizeX = [SKAction scaleXBy:SIZE_OF_PIXEL/self.frame.size.width y:SIZE_OF_PIXEL/self.frame.size.width + (player.size.height / 2) duration:START_ANIMATION_TIME];
    
    //Remove message bar from scene
    
    SKAction *actionMoveDone = [SKAction removeFromParent];
    
    //Add actions and run it for message bar
    
    [startMessageBar runAction:[SKAction sequence:@[actionMove, actionChangeSizeX, actionMoveDone]]];
    
    [startMessageBar runAction:[SKAction sequence:@[actionChangeSizeX]]];
    
    //Add actions and run it for messar label
    
    [startMessageLabel runAction:[SKAction fadeOutWithDuration:START_ANIMATION_TIME / 4]];
    
}



#pragma mark Programm



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //Get location
    
    for (UITouch *touch in touches) {
        
        CGPoint location = [touch locationInNode:self];
        
        //If game not starting
        
        if (!gameStart) {
            // Remove all children
            [self removeAllChildren];
            
            //Start game and play sound
            [self startGame];
            
            //Set player node
            [self setPlayerToLocation:location];
            
            [sound playSoundButtonClick];
            
        }
        
    }
    
}



-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    NSEnumerator *enumerator = [touches objectEnumerator];
    
    UITouch * touch;
    
    while ((touch = [enumerator nextObject])) {
        
        CGPoint previousLocation = [touch locationInView:self.view];
        
        CGPoint currentLocation = [touch previousLocationInView:self.view];
        
        CGPoint offset = CGPointMake(currentLocation.x - previousLocation.x, currentLocation.y - previousLocation.y);
        
        
        player.position = CGPointMake(player.position.x - offset.x, player.position.y + offset.y);
        
        if(player.position.x <= 0){
            player.position = CGPointMake(0, player.position.y);
        }else if(player.position.x >= self.view.frame.size.width - player.size.width){
            player.position = CGPointMake(self.view.frame.size.width - player.size.width, player.position.y);
        }else if(player.position.y < 0){
            player.position = CGPointMake(player.position.x, 0);
        }else if(player.position.y > self.view.frame.size.height - player.size.height){
            player.position = CGPointMake(player.position.x, self.view.frame.size.height - player.size.height);
        }
    }
    
}



- (void)update:(CFTimeInterval)currentTime {
    // update Label
    scoreGame += currentTime/1000000;
    [self updateLabel];
    
    // update Missile
    [self updateMissile];
    
    // update stage
    if(scoreGame > HARDCORE_THRESHOLD && stage == NORMAL_MODE){
        [self openHardcore];
    }
}



#pragma mark - Physics Contact Helpers

-(void)didBeginContact:(SKPhysicsContact *)contact

{
    NSLog(@"contact detected");
    
    SKPhysicsBody *firstBody;
    SKPhysicsBody *secondBody;
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask)
    {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    }
    else
    {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }

     //If player contact to objects
     if ((firstBody.categoryBitMask & playerCategory) != 0){
         [self target:(SKSpriteNode *)firstBody.node didCollideWithTarget:(SKSpriteNode *)secondBody.node];
     }
}



//If player contact to target

- (void)target:(SKSpriteNode *)player didCollideWithTarget:(SKSpriteNode *)target {
    if ([target.name isEqual:@"rock"] || [target.name isEqual:@"missile"]) {
        [self endGame];
    }
}



#pragma mark Change Scene
- (void)changeSceneToEnd {
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    
    // Create and configure the scene.
    SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
    SKScene *endGame = [[DodgeEndGame alloc] initWithSize:skView.bounds.size];
    [self.view presentScene:endGame transition:reveal];
}

-(void)didSimulatePhysics
{
    [self enumerateChildNodesWithName:@"rock" usingBlock:^(SKNode *node, BOOL *stop) {
        int max_speed;
        if(stage==NORMAL_MODE) max_speed = MAX_SPEED;
        else max_speed = HARDCORE_MAX_SPEED;
        if(node.physicsBody.velocity.dy < max_speed){

            node.physicsBody.affectedByGravity = NO;
            node.physicsBody.velocity = CGVectorMake(0, max_speed);
        }
        if (node.position.y < 0)
            [node removeFromParent];
    }];
}
@end

