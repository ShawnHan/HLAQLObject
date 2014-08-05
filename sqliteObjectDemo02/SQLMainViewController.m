//
//  SQLMainViewController.m
//  sqliteObjectDemo02
//
//  Created by Shawn on 14-8-1.
//  Copyright (c) 2014年 hanlong. All rights reserved.
//

#import "SQLMainViewController.h"
#import "SQLDetailViewController.h"
#import "Database.h"

@interface SQLMainViewController ()

@property (strong, nonatomic) Database *dataBase;
@end

@implementation SQLMainViewController

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
    self.view.backgroundColor = [UIColor whiteColor];
    
    _dataBase = [[Database alloc] init];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)gotoDetail:(id)sender {
    SQLDetailViewController *detailView = [[SQLDetailViewController alloc] init];
    [self.navigationController pushViewController:detailView animated:YES];
}
- (IBAction)saveAction:(id)sender {
    [self.dataBase saveDataWithStartDate:[NSDate date]
                              FinishDate:[NSDate date]
                                  Result:@"yes"];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
