//
//  PlayingCardView.h
//  SuperCardGame
//
//  Created by Jason on 14-6-7.
//  Copyright (c) 2014年 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayingCardView : UIView
@property (nonatomic) NSUInteger rank;
@property (strong,nonatomic) NSString *suit;
@property (nonatomic) BOOL faceUp;
@property (nonatomic) CGFloat faceCardScaleFactor;
@property (nonatomic) BOOL isAnimated;
@end
