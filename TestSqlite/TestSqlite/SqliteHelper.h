//
//  SqliteHelper.h
//  TestSqlite
//
//  Created by jjx on 15/1/6.
//  Copyright (c) 2015年 jjx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

#define TABLE_NAME @"light"
#define ID @"id"
#define NAME @"name"
#define LIGHT_GROUP @"lightGroup"

@interface SqliteHelper : NSObject {

    sqlite3* m_db;
}

+ (SqliteHelper*)getInstance;

- (id)initSqlite;
- (void)execSql:(NSString*)sql;
- (void)queryData:(NSString*)sql;

@end
