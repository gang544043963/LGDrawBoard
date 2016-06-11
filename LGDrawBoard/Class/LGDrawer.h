//
//  LGDrawManager.h
//  LGDrawBoard
//
//  Created by ligang on 16/6/10.
//  Copyright © 2016年 JJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LGDrawer : UIView

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, strong) UIColor *lineColor;

/**
 *  撤销的线条数组
 */
@property (nonatomic, strong)NSMutableArray * canceledLines;
/**
 *  线条数组
 */
@property (nonatomic, strong)NSMutableArray * lines;

/**
 *  清屏
 */
- (void)clearScreen;

/**
 *  撤销
 */
- (void)undo;

/**
 *  恢复
 */
- (void)redo;

@end
