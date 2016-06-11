//
//  LGColorSelectView.m
//  LGDrawBoard
//
//  Created by ligang on 16/6/10.
//  Copyright © 2016年 JJ. All rights reserved.
//

#import "LGColorSelectView.h"

const NSInteger colorNum = 14;

@implementation LGColorSelectView

#pragma mark - OverWrite Methods

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		[self setup];
		self.backgroundColor = [UIColor colorWithWhite:200 alpha:1];
		self.layer.borderColor = [UIColor grayColor].CGColor;
		self.layer.borderWidth = 1;
	}
	return self;
}

#pragma mark - Pravite Methods

- (void)setup {
	for (NSInteger i = 0; i < colorNum; i++) {
		UIButton *colorBtn = [[UIButton alloc] init];
		colorBtn.tag = i;
		colorBtn.backgroundColor = self.colorArray[i];
		if (i < 7) {
			colorBtn.frame = CGRectMake(1 + i * (CUB_WIDTH + 1), 1, CUB_WIDTH, CUB_WIDTH);
		} else {
			colorBtn.frame = CGRectMake(1 + (i - 7) * (CUB_WIDTH + 1), CUB_WIDTH + 2, CUB_WIDTH, CUB_WIDTH);
		}
		[colorBtn addTarget:self action:@selector(colorSelected:) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:colorBtn];
	}
}

- (void)colorSelected:(UIButton *)btn {
	NSInteger tag = btn.tag;
	if (self.delegate && [self.delegate respondsToSelector:@selector(selectView:tipedColor:)]) {
		[self.delegate selectView:self tipedColor:self.colorArray[tag]];
	}
}

#pragma mark - Getters

- (NSMutableArray *)colorArray {
	if (!_colorArray) {
		_colorArray = [NSMutableArray array];
		[_colorArray addObject:[UIColor blackColor]];
		[_colorArray addObject:[UIColor darkGrayColor]];
		[_colorArray addObject:[UIColor lightGrayColor]];
		[_colorArray addObject:[UIColor grayColor]];
		[_colorArray addObject:[UIColor redColor]];
		[_colorArray addObject:[UIColor greenColor]];
		[_colorArray addObject:[UIColor blueColor]];
		[_colorArray addObject:[UIColor cyanColor]];
		[_colorArray addObject:[UIColor yellowColor]];
		[_colorArray addObject:[UIColor magentaColor]];
		[_colorArray addObject:[UIColor orangeColor]];
		[_colorArray addObject:[UIColor purpleColor]];
		[_colorArray addObject:[UIColor brownColor]];
		[_colorArray addObject:[UIColor whiteColor]];
	}
	return _colorArray;
}

@end
