//
//  SuperCardGameViewController.m
//  SuperCardGame
//
//  Created by Jason on 14-6-7.
//  Copyright (c) 2014年 Jason. All rights reserved.
//

#import "SuperCardGameViewController.h"
#import "PlayingCardView.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import "CardMacthingGame.h"
#import "DXAlertView.h"
#import "HistoryScoreViewController.h"

@interface SuperCardGameViewController ()
@property (strong, nonatomic) IBOutletCollection(PlayingCardView) NSArray *playingCardViews;
@property (strong,nonatomic) Deck *deck;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong,nonatomic) CardMacthingGame *game ;
@end

@implementation SuperCardGameViewController

- (CardMacthingGame *)game
{
    if (!_game) {
        _game = [[CardMacthingGame alloc]initWithCardCount:[self.playingCardViews count] usingDeck:self.deck];
    }
    return _game;
}

- (Deck *)deck
{
    if (!_deck) {
        _deck = [[PlayingCardDeck alloc]init];
    }
    return _deck;
}

- (IBAction)swip:(UISwipeGestureRecognizer *)sender
{
    int index = [self.playingCardViews indexOfObject:sender.view];
    NSLog(@"swip has been recognized ");
    [self.game chooseCardAtIndex:index];
    [self updateUI];
}

- (void)updateUI
{
    for (PlayingCardView *playingCardView in self.playingCardViews) {
        int viewIndex = [self.playingCardViews indexOfObject:playingCardView];
        Card *card = [self.game cardAtIndex:viewIndex];
        if ([card isKindOfClass:[PlayingCard class]]) {
            PlayingCard *tempPlayingCard = (PlayingCard *)card;
            if (card.isChosen) {
                [UIView transitionWithView:playingCardView duration:1.0
                                   options:UIViewAnimationOptionTransitionFlipFromLeft
                                animations:^{
                                            playingCardView.suit = tempPlayingCard.suit;
                                            playingCardView.rank = tempPlayingCard.rank;
                                            playingCardView.faceUp = YES;}
                                completion:^(BOOL finished) {
                                                    if (finished) {
                                                        NSLog(@"finished ");
                                                    }}];
            } else if (card.isMatched && !playingCardView.isAnimated ) {
                [UIView transitionWithView:playingCardView duration:1.0
                                   options:UIViewAnimationOptionTransitionFlipFromLeft
                                animations:^{
                                    playingCardView.faceUp = YES;}
                                completion:^(BOOL finished) {
                                    if (finished) {
                                        
                                   }}];
            } else{
                playingCardView.faceUp = NO ;
            }
        }
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d",self.game.score];
    if ([self allCardsAreMacthed]) {
        DXAlertView *alterView = [[DXAlertView alloc] initWithTitle:@"Congratulations" contentText:@"You Win" leftButtonTitle:@"New Game" rightButtonTitle:@"Exit"];
        [alterView show];
        alterView.leftBlock = ^(){
            NSLog(@"left button ");
            self.game = nil;
            self.deck = nil;
            [self updateUI];
        };
        alterView.rightBlock = ^(){
            NSLog(@"right button");
            [self performSegueWithIdentifier:@"Show History" sender:self];
        };
        
    }

}

- (BOOL)allCardsAreMacthed
{
    int missMacthCount = [self.playingCardViews count];
    for (int index = 0; index < [self.playingCardViews count]; index ++) {
        Card *card = [self.game cardAtIndex:index];
        if (card.isMatched) {
            missMacthCount -= 1;
        }
    }
    return (missMacthCount <= 2 && self.game.score > 0) ? YES : NO ;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue destinationViewController] isKindOfClass:[HistoryScoreViewController class]]) {
        HistoryScoreViewController *dvc = (HistoryScoreViewController *)[segue destinationViewController];
        dvc.bestScore = self.game.score;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
//    [self drawRandomCard];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
