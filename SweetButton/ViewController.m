//
//  ViewController.m
//  SweetButton
//
//  Created by Martin Henry on 11/4/15.
//  Copyright © 2015 Martin Henry. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property UIButton *mainButton;
@property UIButton *buttonSave;
@property UIButton *buttonLoad;
@property UIButton *buttonClear;
@property UIDynamicAnimator *dynamicAnimator;
@property BOOL areButtonsFanned;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    self.buttonSave = [self createButtonWithTitle:@"save" color:[UIColor yellowColor]];
    self.buttonLoad = [self createButtonWithTitle:@"load" color:[UIColor greenColor]];
    self.buttonClear = [self createButtonWithTitle:@"clear" color:[UIColor redColor]];
    self.mainButton = [self createButtonWithTitle:@"menu" color:[UIColor grayColor]];
    [self.mainButton addTarget:self action:@selector(fanButtons:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIButton *)createButtonWithTitle:(NSString *)title color:(UIColor *)color {
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 50, self.view.frame.size.height - 50, 50, 50)];
    button.layer.borderWidth = 1.0;
    button.layer.cornerRadius = button.bounds.size.width / 2.0;
    button.backgroundColor = color;
    button.layer.borderColor = [UIColor purpleColor].CGColor;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [self.view addSubview:button];
    return button;
}

- (void)fanButtons:(UIButton *)sender {
    [self.dynamicAnimator removeAllBehaviors];
    if (self.areButtonsFanned) {
        [self fanIn];
    } else {
        [self fanOut];
    }
    self.areButtonsFanned = !self.areButtonsFanned;
}

- (void)fanIn {
    UISnapBehavior *snapBehavior;
    snapBehavior = [[UISnapBehavior alloc] initWithItem:self.buttonSave snapToPoint:self.mainButton.center];
    [self.dynamicAnimator addBehavior:snapBehavior];
    snapBehavior = [[UISnapBehavior alloc] initWithItem:self.buttonLoad snapToPoint:self.mainButton.center];
    [self.dynamicAnimator addBehavior:snapBehavior];
    snapBehavior = [[UISnapBehavior alloc] initWithItem:self.buttonClear snapToPoint:self.mainButton.center];
    [self.dynamicAnimator addBehavior:snapBehavior];
}

- (void)fanOut {
    CGPoint point;
    UISnapBehavior *snapBehavior;
    point = CGPointMake(self.mainButton.frame.origin.x - 50, self.mainButton.frame.origin.y + 25);
    snapBehavior = [[UISnapBehavior alloc] initWithItem:self.buttonSave snapToPoint:point];
    snapBehavior.damping = 0.1;
    [self.dynamicAnimator addBehavior:snapBehavior];
    
    point = CGPointMake(self.mainButton.frame.origin.x - 50, self.mainButton.frame.origin.y - 50);
    snapBehavior = [[UISnapBehavior alloc] initWithItem:self.buttonLoad snapToPoint:point];
        snapBehavior.damping = 0.1;
    [self.dynamicAnimator addBehavior:snapBehavior];
    
    point = CGPointMake(self.mainButton.frame.origin.x + 25, self.mainButton.frame.origin.y - 50);
    snapBehavior = [[UISnapBehavior alloc] initWithItem:self.buttonClear snapToPoint:point];
    [self.dynamicAnimator addBehavior:snapBehavior];
}

@end
