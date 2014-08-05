//
//  SQLDetailViewController.m
//  sqliteObjectDemo02
//
//  Created by Shawn on 14-8-1.
//  Copyright (c) 2014年 hanlong. All rights reserved.
//

#import "SQLDetailViewController.h"
#import "Database.h"

@interface SQLDetailViewController ()
@property (strong, nonatomic) Database *dataBase;

@end

@implementation SQLDetailViewController

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
    _dataBase = [[Database alloc] init];

    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)outputAction:(id)sender {
    [self.dataBase dataOutPut];
}
- (IBAction)deleteTable:(id)sender {
    [self.dataBase deleteSQLiteData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
