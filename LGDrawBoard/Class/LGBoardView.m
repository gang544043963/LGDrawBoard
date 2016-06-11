//
//  LGBoardView.m
//  LGDrawBoard
//
//  Created by ligang on 16/6/10.
//  Copyright © 2016年 JJ. All rights reserved.
//

#import "LGBoardView.h"
#import "LGDrawer.h"
#import "LGColorSelectView.h"

#define SELF_WIDTH self.frame.size.width
#define SELF_HEIGHT self.frame.size.height
#define TOOLBAR_HEIGHT 40

@interface LGBoardView() <UIActionSheetDelegate,UIImagePickerControllerDelegate,LGColorSelectViewDelegate> {
	
	UIBarButtonItem *_colorItem;
	UIBarButtonItem *_undoItem;
	UIBarButtonItem *_redoItem;
	UIBarButtonItem *_deleteItem;
	UIBarButtonItem *_saveItem;
	UIBarButtonItem *_albumItem;
	
	UIColor *_paintColor;
}

@property (nonatomic, strong) UIToolbar *toolBar;
@property (nonatomic, strong) LGDrawer *drawer;
@property (nonatomic, strong) UIButton *colorBtn;
@property (nonatomic, strong) LGColorSelectView *colorSelectView;


@end

@implementation LGBoardView

#pragma mark - OverWrite Methods

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		[self addSubview:self.drawer];
		[self addSubview:self.toolBar];
		[self addSubview:self.colorBtn];
		[self addSubview:self.colorSelectView];
	}
	return self;
}

#pragma mark - Getters

- (UIToolbar *)toolBar {
	if (!_toolBar) {
		_toolBar = [[UIToolbar alloc] init];
		_toolBar.backgroundColor = [UIColor clearColor];
		_toolBar.frame = CGRectMake(0, SELF_HEIGHT - TOOLBAR_HEIGHT, SELF_WIDTH, TOOLBAR_HEIGHT);
		
		
		//颜色
		_colorItem = [[UIBarButtonItem alloc] initWithCustomView:[[UIView alloc] init]];
		
		//回撤
		_undoItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"撤销"] style:UIBarButtonItemStylePlain target:self action:@selector(undo)];
		
		//恢复
		_redoItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"重做"] style:UIBarButtonItemStylePlain target:self action:@selector(redo)];
		
		//全部删除
		_deleteItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(delete)];
		
		//保存
		_saveItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(save)];
		
		//相册
		_albumItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(album)];
		
		UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
		
		
		_toolBar.items = @[_colorItem,space,_undoItem,space,_redoItem,space,_deleteItem,space,_saveItem,space,_albumItem];
	}
	return _toolBar;
}

- (LGDrawer *)drawer {
	if (!_drawer) {
		_drawer = [[LGDrawer alloc] initWithFrame:self.frame];
		_drawer.width = 3;
	}
	return _drawer;
}

- (UIButton *)colorBtn {
	if (!_colorBtn) {
		_colorBtn = [[UIButton alloc] initWithFrame:CGRectMake(_toolBar.frame.origin.x + 15, _toolBar.frame.origin.y + 10, 20, 20)];
		_colorBtn.layer.cornerRadius = 3;
		[_colorBtn setBackgroundColor:[UIColor blackColor]];
		[_colorBtn addTarget:self action:@selector(colorBtnTouched) forControlEvents:UIControlEventTouchUpInside];
	}
	return _colorBtn;
}

- (LGColorSelectView *)colorSelectView {
	if (!_colorSelectView) {
		_colorSelectView = [[LGColorSelectView alloc] initWithFrame:CGRectMake(10, SELF_HEIGHT - TOOLBAR_HEIGHT - SELECT_HEIGHT - 10, SELECT_WIDTH, SELECT_HEIGHT)];
		_colorSelectView.backgroundColor = [UIColor lightGrayColor];
		_colorSelectView.delegate = self;
		_colorSelectView.hidden = YES;
	}
	return _colorSelectView;
}

#pragma mark - Private Methods

- (void)colorBtnTouched {
	_colorSelectView.hidden = !_colorSelectView.hidden;
}

- (void)undo {
	[self.drawer undo];
}

- (void)redo {
	[self.drawer redo];
}

- (void)delete {
	[self.drawer clearScreen];
}

- (void)save {
	UIGraphicsBeginImageContext(_drawer.bounds.size);
	[_drawer.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	UIImageWriteToSavedPhotosAlbum(viewImage, nil, nil, nil);
}

- (void)album {
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册",@"相机", nil];
	[actionSheet showInView:self];
}

- (void)presentPickerWithType:(UIImagePickerControllerSourceType)type {
	if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
		UIImagePickerController *picker = [[UIImagePickerController alloc] init];
		picker.sourceType = type;
		picker.delegate = self;
		UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
		[window.rootViewController presentViewController:picker animated:NO completion:nil];
	}
}

#pragma mark - Observer

//- (void)observeValueForKeyPath:(NSString *)keyPath
//					  ofObject:(id)object
//						change:(NSDictionary<NSString *,id> *)change
//					   context:(void *)context
//{
//	if([keyPath isEqualToString:@"lines"]){
//		NSMutableArray * lines = [self.drawer mutableArrayValueForKey:@"lines"];
//		if (lines.count) {
//			[_undoItem setEnabled:YES];
//			[_deleteItem setEnabled:YES];
//			
//		}else{
//			[_undoItem setEnabled:NO];
//			[_deleteItem setEnabled:NO];
//		}
//	}else if([keyPath isEqualToString:@"canceledLines"]){
//		NSMutableArray * canceledLines = [self.drawer mutableArrayValueForKey:@"canceledLines"];
//		if (canceledLines.count) {
//			[_redoItem setEnabled:YES];
//		}else{
//			[_redoItem setEnabled:NO];
//			
//		}
//		
//	}
//}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	UIImagePickerControllerSourceType type = UIImagePickerControllerSourceTypePhotoLibrary;
	if (buttonIndex == 1) {
		type = UIImagePickerControllerSourceTypeCamera;
	}
	[self presentPickerWithType:type];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
	[picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
	UIImage *image = [[UIImage alloc] init];
	image = [info objectForKey:UIImagePickerControllerOriginalImage];
	self.drawer.layer.contents = (__bridge id _Nullable)(image.CGImage);
	[picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - LGColorSelectViewDelegate

- (void)selectView:(LGColorSelectView *)selectView tipedColor:(UIColor *)color {
	self.colorBtn.backgroundColor = color;
	self.drawer.lineColor = color;
	self.colorSelectView.hidden = YES;
}

@end
