//
//  Database.m
//  sqliteObjectDemo02
//
//  Created by Shawn on 14-8-1.
//  Copyright (c) 2014年 hanlong. All rights reserved.
//

#import "Database.h"

@implementation Database

static Database *_database;

-(id)init
{
    if ((self = [super init])) {
        NSString *docsDir;
        NSArray *dirPaths;
        // Get the documents directory
        dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        
        docsDir = dirPaths[0];
        
        // Build the path to the database file
        _databasePath = [[NSString alloc]
                         initWithString: [docsDir stringByAppendingPathComponent:
                                          @"testResult.sqlite"]];
        
        NSLog(@"path == %@",_databasePath);
        
        NSFileManager *filemgr = [NSFileManager defaultManager];
        
        if ([filemgr fileExistsAtPath:_databasePath] == NO) {
            const char *dbpath = [_databasePath UTF8String];
            if (sqlite3_open(dbpath, &_database) == SQLITE_OK) {
                
                char *errMsg;
                const char *sql_stmt = "CREATE TABLE IF NOT EXISTS CONTACTS (ID INTEGER PRIMARY KEY AUTOINCREMENT, STARTTIME TEXT, FINISHTIME TEXT, RESULT TEXT)";
                if (sqlite3_exec(_database, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK ) {
                    NSLog(@"Failed to create table");
                }
                sqlite3_close(_database);
            } else {
                NSLog(@"Failed to open/create database");
            }
        }
        
    }
    return self;
}

-(void)saveDataWithStartDate:(NSDate *)startDate FinishDate:(NSDate *)finishDate Result:(NSString *)result
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSString *startStr = [formatter stringFromDate:startDate];
    NSString *finishStr = [formatter stringFromDate:finishDate];
    
    NSLog(@"Start time = %@, checkresult = %@, finish time = %@",startStr,result,finishStr);
    //**************************************
    sqlite3_stmt *statement;
    const char *dbpath = [_databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &_database) == SQLITE_OK) {
        
        NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO CONTACTS (starttime, finishtime, result) VALUES (\"%@\", \"%@\",\"%@\")",startStr, finishStr, result];
        
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(_database, insert_stmt, -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE) {
            
            NSLog(@"data add success!");
        }
        else
        {
            NSLog(@"failed to add data");
        }
        sqlite3_finalize(statement);
        sqlite3_close(_database);
        
    }
    
}
-(void)dataOutPut
{
    NSLog(@"dataoutput");
    const char *dbpath = [_databasePath UTF8String];
    
    //SELECT ROW,FIELD_DATA FROM FIELDS ORDER BY ROW
    sqlite3_stmt *stmt;
    if (sqlite3_open(dbpath, &_database) == SQLITE_OK) {
        NSString *quary = @"SELECT * FROM CONTACTS";
        NSLog(@"data = %@",quary);
        const char *query_stmt = [quary UTF8String];
        if (sqlite3_prepare_v2(_database, query_stmt, -1, &stmt, NULL) == SQLITE_OK) {
            NSLog(@"sqlite ok");
            
            while (sqlite3_step(stmt)==SQLITE_ROW) {
                
                
                int idInt = sqlite3_column_int(stmt, 0);//id in the sqlite
                
                char *name = (char *)sqlite3_column_text(stmt, 1);
                NSString *nameString = [[NSString alloc] initWithUTF8String:name];
                
                char *sex = (char *)sqlite3_column_text(stmt, 2);
                NSString *sexString = [[NSString alloc] initWithUTF8String:sex];
                
                char *address = (char *)sqlite3_column_text(stmt, 3);
                NSString *addressString = [[NSString alloc] initWithUTF8String:address];
                
                NSLog(@"id: %i starr: %@, finish: %@, result: %@",idInt,nameString,sexString,addressString);
            }
            
            sqlite3_finalize(stmt);
        }
        sqlite3_close(_database);
    }
    
}
-(void)deleteSQLiteData
{
    const char *dbpath = [_databasePath UTF8String];
    
    sqlite3_stmt *stmt;
    
    if (sqlite3_open(dbpath, &_database) == SQLITE_OK) {
        
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM CONTACTS"];
        const char *delete_stmt = [sql UTF8String];
        if(sqlite3_prepare_v2(_database, delete_stmt, -1, &stmt, NULL) == SQLITE_OK){
            NSLog(@"delete sqlite successfully");
            while (sqlite3_step(stmt) == SQLITE_ROW) {
                NSLog(@"result is here");
            }
            
            
        sqlite3_finalize(stmt);
        }
        sqlite3_close(_database);
    }
    [self deleteID];
}
-(void)deleteID
{
    const char *dbpath = [_databasePath UTF8String];
    
    sqlite3_stmt *stmt;
    
    if (sqlite3_open(dbpath, &_database) == SQLITE_OK) {
        
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM sqlite_sequence"];
        const char *delete_stmt = [sql UTF8String];
        if(sqlite3_prepare_v2(_database, delete_stmt, -1, &stmt, NULL) == SQLITE_OK){
            NSLog(@"delete id number successfully");
            while (sqlite3_step(stmt) == SQLITE_ROW) {
                NSLog(@"result is here");
            }
            
            
            sqlite3_finalize(stmt);
        }
        sqlite3_close(_database);
    }

}

-(int)getDatabaseCount
{
    int count = 0;
    
    if (sqlite3_open([self.databasePath UTF8String], &_database) == SQLITE_OK) {
        NSLog(@"count sqlite ok");
        //NSString *query = @"SELECT COUNT(*) FROM CONTACTS";
        const char* sqlStmt = "SELECT COUNT(*) FROM CONTACTS";
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(_database, sqlStmt, -1, &statement, NULL) == SQLITE_OK)
        {
            NSLog(@"sqlite prepare ok");
            while (sqlite3_step(statement) == SQLITE_ROW) {
                count = sqlite3_column_int(statement, 0);
                NSLog(@"count == %i",count);
                
            }
        }
        else
        {
            NSLog(@"Failed from sqlite3_prepare_v2. Error is: %s", sqlite3_errmsg(_database));
        }
        sqlite3_finalize(statement);
        sqlite3_close(_database);
    }
    
    
    return count;
}


@end
