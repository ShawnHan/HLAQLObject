//
//  Database.h
//  sqliteObjectDemo02
//
//  Created by Shawn on 14-8-1.
//  Copyright (c) 2014年 hanlong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface Database : NSObject {
    sqlite3 *_database;
}
@property (strong, nonatomic) NSString *databasePath;

-(void)saveDataWithStartDate:(NSDate *)startDate FinishDate:(NSDate *)finishDate Result:(NSString *)result;

-(void)dataOutPut;

-(int)getDatabaseCount;

-(void)deleteSQLiteData;

-(int)getPassedTestNumber;

-(double)averageTime;


@end
