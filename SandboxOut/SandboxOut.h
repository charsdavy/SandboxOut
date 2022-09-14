//
//  SandboxOut.h
//  SandboxOut
//
//  Created by dengwei on 2022/9/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, SOFileItemType) {
    SOFileItemUp, /// 上一层
    SOFileItemDirectory, /// 文件夹
    SOFileItemFile /// 文件数据
};

@interface SOFileItem : NSObject
/// 名称
@property (nonatomic, copy) NSString *name;
/// 地址
@property (nonatomic, copy) NSString *path;
/// 数据类型
@property (nonatomic, assign) SOFileItemType type;

- (instancetype)initWithName:(NSString *)name path:(NSString *)path type:(SOFileItemType)type;

@end

@interface SandboxOut : NSObject

/// 开启 debug 模式，默认 NO
@property (nonatomic, assign) BOOL debugMode;

- (instancetype)initWithRootPath:(nonnull NSString *)rootPath;

/// 遍历指定路径的文件
/// - Parameter rootPath: 需要遍历的文件/文件夹路径，默认 NSHomeDirectory()
- (nullable NSArray<SOFileItem *> *)traverseFilesWithRootPath:(nullable NSString *)rootPath;

@end

NS_ASSUME_NONNULL_END
