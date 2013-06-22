//
//  ViewController.m
//  NSStringTruncatedExample
//
//  Created by Peter Cen on 13-03-29.
//  Copyright (c) 2013 Peter Cen. All rights reserved.
//

#import "ViewController.h"
#import "NSString+TruncateWidth.h"
@interface ViewController ()
{
    UITextView *textView;
    UIScrollView *labelViews;
}
@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *title = @"This is a test for NSString+TruncateWidth, calling the componentsSeparatedByWidth will return an array of NSStrings constrained to width with the UIFont specified. The contents of this UITextView will be displayed with a constrained width of 250.0 below";
    
    textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, 300, 100)];
    [textView setDelegate:self];
    [textView setBackgroundColor:[UIColor whiteColor]];
    [textView setText:title];
    [self.view addSubview:textView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(10, 110, 300, 40)];
    [button setBackgroundColor:[UIColor colorWithRed:44.0/255.0 green:148/255.0 blue:233.0/255.0 alpha:1]];
    [button addTarget:self action:@selector(go) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Go" forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    labelViews = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 160, 300, self.view.frame.size.height-170)];
    
    [self.view addSubview:labelViews];
    
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void) go {
    for (UIView *view in [labelViews subviews]) {
        [view removeFromSuperview];
    }
    [textView resignFirstResponder];
    UIFont *font = [UIFont systemFontOfSize:12];

    NSArray *array = [textView.text componentsSeparatedByWidth:250 forFont:font maxStrings:NSIntegerMax];
    CGFloat height = 0;
    for (NSString *string in array) {
        CGSize size = [string sizeWithFont:font];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, height, size.width, size.height)];
        [label setFont:font];
        [label setBackgroundColor:[UIColor colorWithWhite:0 alpha:1]];
        [label setTextColor:[UIColor whiteColor]];
        [label setText:string];
        height += size.height;
        [labelViews addSubview:label];
    }
    [labelViews setContentSize:CGSizeMake(300, height)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
