//
//  LGColorSelectView.h
//  LGDrawBoard
//
//  Created by ligang on 16/6/10.
//  Copyright © 2016年 JJ. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CUB_WIDTH 30

#define SELECT_WIDTH CUB_WIDTH * 7 + 8
#define SELECT_HEIGHT CUB_WIDTH * 2 + 3

@class LGColorSelectView;
@protocol LGColorSelectViewDelegate <NSObject>

- (void)selectView:(LGColorSelectView *)selectView tipedColor:(UIColor *)color;

@end

@interface LGColorSelectView : UIView


@property (nonatomic, strong) NSMutableArray *colorArray;
@property (nonatomic, weak) id<LGColorSelectViewDelegate>delegate;

@end
