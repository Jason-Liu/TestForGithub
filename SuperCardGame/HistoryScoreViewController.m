//
//  HistoryScoreViewController.m
//  SuperCardGame
//
//  Created by Jason on 14-6-8.
//  Copyright (c) 2014年 Jason. All rights reserved.
//

#import "HistoryScoreViewController.h"

@interface HistoryScoreViewController ()
@property (weak, nonatomic) IBOutlet UILabel *bestScoreLabel;
@end

@implementation HistoryScoreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.bestScoreLabel.text = [NSString stringWithFormat:@"Best Score: %d",self.bestScore];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
