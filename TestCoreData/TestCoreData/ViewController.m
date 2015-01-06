//
//  ViewController.m
//  TestCoreData
//
//  Created by jjx on 15/1/6.
//  Copyright (c) 2015年 jjx. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    AppDelegate* delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* content = [delegate managedObjectContext];

    NSEntityDescription* entity = [NSEntityDescription entityForName:@"Line" inManagedObjectContext:content];

    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];

    NSError* error;
    NSArray* array = [content executeFetchRequest:request error:&error];

    for (NSManagedObject* ob in array) {
        NSString* lineNum = [ob valueForKey:@"lineNumber"];
        NSString* lineStr = [ob valueForKey:@"lineText"];

        NSLog(@"lineNum = %@", lineNum);
        NSLog(@"lineStr = %@", lineStr);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sender:(id)sender
{
    AppDelegate* delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];

    NSManagedObjectContext* content = [delegate managedObjectContext];

    int number = [[self.m_lineNumber text] intValue];
    NSString* lineString = [self.m_lineString text];

    NSFetchRequest* request = [[NSFetchRequest alloc] init];

    NSEntityDescription* entotyDes = [NSEntityDescription entityForName:@"Line" inManagedObjectContext:content];

    [request setEntity:entotyDes];

    NSPredicate* pred = [NSPredicate predicateWithFormat:@"lineNumber == %d", 1];
    [request setPredicate:pred];

    NSManagedObject* line = nil;

    NSError* error;

    NSArray* array = [content executeFetchRequest:request error:&error];

    if (array == nil) {
        NSLog(@"error");
    }

    if ([array count] > 0) {
        line = [array objectAtIndex:0];
    }
    else {
        line = [NSEntityDescription insertNewObjectForEntityForName:@"Line" inManagedObjectContext:content];
    }

    [line setValue:[NSNumber numberWithInt:number] forKey:@"lineNumber"];
    [line setValue:lineString forKey:@"lineText"];

    [content save:&error];
}
@end
