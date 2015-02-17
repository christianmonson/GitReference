//
//  ViewController.m
//  GitReference
//
//  Created by David Monson on 2/2/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "ViewController.h"

static CGFloat margin = 15;
static CGFloat topLabelHeight = 20;
static CGFloat heightForLabel = 25;
static NSString * const Command = @"command";
static NSString * const Reference = @"reference";

@interface ViewController ()

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGFloat topMargin = 20;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, topMargin, self.view.frame.size.width, self.view.frame.size.height - topMargin)];
    [self.view addSubview:scrollView];
    
    CGFloat widthMinusMargin = self.view.frame.size.width - 2 * margin;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, topMargin, widthMinusMargin, heightForLabel)];
    titleLabel.text = @"GitReference";
    [scrollView addSubview:titleLabel];
    
    CGFloat top = topMargin + 20 + margin * 2;
    
    for (NSDictionary *gitCommand in [self gitCommands]) {
        NSString *commandString = gitCommand[Command];
        NSString *referenceString = gitCommand[Reference];
        
        
        UILabel *commandLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, top, widthMinusMargin, heightForLabel)];
        commandLabel.text = commandString;
        commandLabel.textColor = [UIColor greenColor];
        commandLabel.font = [UIFont systemFontOfSize:17];
        [scrollView addSubview:commandLabel];
        
        top += (margin + heightForLabel);
        
        CGFloat heightForReference = [self heightOfReferenceString:referenceString];
        
        UILabel *referenceLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, top, widthMinusMargin, heightForReference)];
        referenceLabel.numberOfLines = 0;
        referenceLabel.text = referenceString;
        referenceLabel.textColor = [UIColor redColor];
        referenceLabel.font = [UIFont systemFontOfSize:15];
        [scrollView addSubview:referenceLabel];
        
        top += (heightForReference + margin * 2);
        
    }
    
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, top);
}

- (NSArray *)gitCommands {
    
    return @[@{Command: @"git status", Reference: @": shows changed files"},
             @{Command: @"git diff", Reference: @": shows actual changes"},
             @{Command: @"git add .", Reference: @": adds changed files to the commit"},
             @{Command: @"git commit -m \"notes\"", Reference: @": commits the changes"},
             @{Command: @"git push origin _branch_", Reference: @": pushes commits to branch named _branch_"},
             @{Command: @"git log", Reference: @": displays progress log"},
             @{Command: @"git comment --amend", Reference: @": re-enter last commit message"}
             ];
    
}

- (CGFloat)heightOfReferenceString:(NSString *)reference {
    
    CGRect bounding = [reference boundingRectWithSize:CGSizeMake(self.view.frame.size.width - 2 * margin, 0)
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}
                                              context:nil];
    
    return bounding.size.height;
    
}


@end