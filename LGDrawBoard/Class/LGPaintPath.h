//
//  LGPaintPath.h
//  LGDrawBoard
//
//  Created by ligang on 16/6/10.
//  Copyright © 2016年 JJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LGPaintPath : UIBezierPath

+ (instancetype)paintPathWithLineWidth:(CGFloat)width
							startPoint:(CGPoint)startP;

@end
