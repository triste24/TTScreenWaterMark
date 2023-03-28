//
//  AppDelegate.m
//  TTScreenWaterMark
//
//  Created by dingjie.triste on 2023/3/28.
//


#import "AppDelegate.h"
#import "WatermarkView.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


-(void)applicationDidFinishLaunching:(NSNotification *)aNotification {

    NSColor *color = [NSColor colorWithCalibratedRed:0.8 green:0.8 blue:0.8 alpha:1];
    
    [WatermarkView displayScreenWatermark:@"此处显示水印" titleColor:color];
}

@end
