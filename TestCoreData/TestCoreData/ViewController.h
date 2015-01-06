//
//  ViewController.h
//  TestCoreData
//
//  Created by jjx on 15/1/6.
//  Copyright (c) 2015年 jjx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *m_lineNumber;

@property (weak, nonatomic) IBOutlet UITextField *m_lineString;

- (IBAction)sender:(id)sender;
@end
