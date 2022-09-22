//
//  SandboxOut.m
//  SandboxOut
//
//  Created by dengwei on 2022/9/14.
//

#import "SandboxOut.h"

@implementation SOFileItem

- (instancetype)initWithName:(NSString *)name path:(NSString *)path type:(SOFileItemType)type
{
    self = [super init];
    if (self) {
        _name = name;
        _path = path;
        _type = type;
    }
    return self;
}

@end

@interface SandboxOut()

@property (nonatomic, copy) NSString *rootPath;

@end

@implementation SandboxOut

- (instancetype)init
{
    self = [super init];
    if (self) {
        _rootPath = NSHomeDirectory();
        _debugMode = NO;
    }
    return self;
}

- (instancetype)initWithRootPath:(NSString *)rootPath
{
    self = [self init];
    if (self) {
        _rootPath = rootPath;
    }
    return self;
}

- (NSArray<SOFileItem *> *)traverseFilesWithRootPath:(NSString *)rootPath
{
    NSMutableArray<SOFileItem *> *files = [NSMutableArray array];
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *targetPath = rootPath;
    
    if (rootPath.length <= 0 || [rootPath isEqualToString:_rootPath]) {
        targetPath = _rootPath;
    } else {
        SOFileItem *fileItem = [[SOFileItem alloc] initWithName:@"••" path:rootPath type:SOFileItemUp];
        [files addObject:fileItem];
    }
    
    NSError *error = nil;
    NSArray *paths = [fm contentsOfDirectoryAtPath:targetPath error:&error];
    if (error && _debugMode) {
        NSLog(@"Sandbox Out error: %@", error.description);
    }
    for (NSString *path in paths) {
        if ([[path lastPathComponent] hasPrefix:@"."]) {
            continue;
        }
        BOOL isDir = NO;
        NSString *fullPath = [targetPath stringByAppendingPathComponent:path];
        [fm fileExistsAtPath:fullPath isDirectory:&isDir];
        
        SOFileItem *fileItem = [[SOFileItem alloc] init];
        fileItem.path = fullPath;
        if (isDir) {
            fileItem.type = SOFileItemDirectory;
            fileItem.name = [NSString stringWithFormat:@"📁 %@", path];
        } else {
            fileItem.type = SOFileItemFile;
            fileItem.name = [NSString stringWithFormat:@"📃 %@", path];
        }
        [files addObject:fileItem];
    }
    
    if (files.count <= 0) {
        return nil;
    }
    return files;
}

@end
