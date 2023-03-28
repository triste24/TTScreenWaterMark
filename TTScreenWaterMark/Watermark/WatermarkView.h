//
//  WatermarkView.h
//  ScreenWatermark
//
//  Created by triste on 2023/3/27.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface WatermarkSubView : NSView
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSColor *titleColor;
@end


@interface WatermarkView : NSView

/**
 水印初始化

 @param title 显示文本
 @param titleColor 字体颜色
 */
+ (void)displayScreenWatermark:(NSString *)title titleColor:(NSColor *)titleColor;

@end

NS_ASSUME_NONNULL_END
