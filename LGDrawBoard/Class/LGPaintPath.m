//
//  LGPaintPath.m
//  LGDrawBoard
//
//  Created by ligang on 16/6/10.
//  Copyright © 2016年 JJ. All rights reserved.
//

#import "LGPaintPath.h"

@implementation LGPaintPath

+ (instancetype)paintPathWithLineWidth:(CGFloat)width
							startPoint:(CGPoint)startP
{
	LGPaintPath * path = [[self alloc] init];
	path.lineWidth = width;
	path.lineCapStyle = kCGLineCapRound;
	path.lineJoinStyle = kCGLineCapRound; 
	[path moveToPoint:startP];
	return path;
}

@end
