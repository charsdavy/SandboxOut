//
//  SOViewController.h
//  SandboxOut
//
//  Created by dengwei on 2022/9/14.
//

#import <UIKit/UIKit.h>

@class SandboxOut;

NS_ASSUME_NONNULL_BEGIN

@interface SOTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *fileNameLabel;

@end

@interface SOViewController : UIViewController

@property (nonatomic, strong) SandboxOut *sandboxOut;
/// 开启 debug 模式，默认 NO
@property (nonatomic, assign) BOOL debugMode;

@end

NS_ASSUME_NONNULL_END
