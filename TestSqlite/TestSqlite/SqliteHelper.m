//
//  SqliteHelper.m
//  TestSqlite
//
//  Created by jjx on 15/1/6.
//  Copyright (c) 2015年 jjx. All rights reserved.
//

#import "SqliteHelper.h"

@implementation SqliteHelper

+ (SqliteHelper*)getInstance
{
    static SqliteHelper* sqliteHelper = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        sqliteHelper = [[self alloc] initSqlite];

    });

    return sqliteHelper;
}

- (id)initSqlite
{
    SqliteHelper* helper = [[SqliteHelper alloc] init];

    NSArray* pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* dataBasePath = [NSString stringWithFormat:@"%@/%@", [pathArray objectAtIndex:0], @"light.db"]; //[pathArray objectAtIndex:0];

    NSLog(@"path = %@", dataBasePath);

    if (sqlite3_open([dataBasePath UTF8String], &m_db) != SQLITE_OK) {
        sqlite3_close(m_db);
    }
    else {

        NSString* sql = @"CREATE TABLE IF NOT EXISTS light (ID INTEGER PRIMARY KEY AUTOINCREMENT, light TEXT,name TEXT,lightGroup TEXT)";

        [self execSql:sql];

        /*   NSString* insertData = [NSString stringWithFormat:@"INSERT INTO '%@' ('%@','%@','%@','%@') values (NULL,'%@','%@','%@');", @"light", @"ID", @"light", @"name", @"lightGroup", @"1", @"name", @"客厅"];

        [self execSql:insertData];*/

        [self queryData:nil];
    }

    return helper;
}

- (void)execSql:(NSString*)sql
{
    char* error;
    if (sqlite3_exec(m_db, [sql UTF8String], NULL, NULL, &error) != SQLITE_OK) {
    }
}

- (void)queryData:(NSString*)sql
{
    NSString* str = @"select * from light";

    sqlite3_stmt* statement;

    if (sqlite3_prepare_v2(m_db, [str UTF8String], -1, &statement, nil) == SQLITE_OK) {

        while (sqlite3_step(statement) == SQLITE_ROW) {
            char* _id = (char*)sqlite3_column_text(statement, 0);
            char* _light = (char*)sqlite3_column_text(statement, 1);
            char* _name = (char*)sqlite3_column_text(statement, 2);
            char* _lightGroup = (char*)sqlite3_column_text(statement, 3);

            NSLog(@"%s\t%s\t%s\t%@", _id, _light, _name, [[NSString alloc] initWithUTF8String:_lightGroup]);
        }
    }
}

@end
