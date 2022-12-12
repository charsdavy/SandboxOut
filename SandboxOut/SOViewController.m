//
//  SOViewController.m
//  SandboxOut
//
//  Created by dengwei on 2022/9/14.
//

#import "SOViewController.h"
#import "SandboxOut.h"
#import <QuickLook/QuickLook.h>

@implementation SOTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.fileNameLabel];
    }
    return self;
}

- (UILabel *)fileNameLabel
{
    if (!_fileNameLabel) {
        _fileNameLabel = [[UILabel alloc] init];
        _fileNameLabel.font = [UIFont systemFontOfSize:14.0];
        _fileNameLabel.textColor = [UIColor blackColor];
        _fileNameLabel.userInteractionEnabled = NO;
    }
    return _fileNameLabel;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize size = self.bounds.size;
    if (size.width <= 0 || size.height <= 0) {
        return;
    }
    self.fileNameLabel.frame = CGRectMake(16.0, 0, size.width - 16.0 * 2.0, size.height);
}

@end

@interface SOViewController ()<UITableViewDelegate, UITableViewDataSource, QLPreviewControllerDelegate, QLPreviewControllerDataSource>

@property (nonatomic, strong) NSArray<SOFileItem *> *dataSource;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSString *currentPreviewPath;

@end

@implementation SOViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _debugMode = NO;
        _sandboxOut = [[SandboxOut alloc] init];
    }
    return self;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupSubviews];
    
    [self loadFilesWithPath:nil];
}

- (void)setupSubviews
{
    [self.view addSubview:self.tableView];
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.rowHeight = 52.0;
    }
    return _tableView;
}

- (void)setSandboxOut:(SandboxOut *)sandboxOut
{
    _sandboxOut = sandboxOut;
}

- (void)loadFilesWithPath:(NSString *)path
{
    self.dataSource = [self.sandboxOut traverseFilesWithRootPath:path];
    [self.tableView reloadData];
}

- (void)showFileOperationSheet:(SOFileItem *)fileItem
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"SandboxOut" message:fileItem.name preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    __weak __typeof(self) weakself = self;
    [alertController addAction:[UIAlertAction actionWithTitle:@"Preview" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakself quickLookFileWithPath:fileItem.path];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Send" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakself shareFileWithPath:fileItem.path];
    }]];
    if ([(NSString *)[UIDevice currentDevice].model hasPrefix:@"iPad"]) {
        alertController.popoverPresentationController.sourceView = self.view;
        alertController.popoverPresentationController.sourceRect = CGRectMake([UIScreen mainScreen].bounds.size.width * 0.5, [UIScreen mainScreen].bounds.size.height, 10, 10);
    }
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)shareFileWithPath:(NSString *)path
{
    NSURL *url = [NSURL fileURLWithPath:path];
    NSArray *objectsToShare = @[url];
    
    UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
    NSArray *excludedActivities = @[UIActivityTypePostToTwitter, UIActivityTypePostToFacebook,
                                    UIActivityTypePostToWeibo,
                                    UIActivityTypeMessage, UIActivityTypeMail,
                                    UIActivityTypePrint, UIActivityTypeCopyToPasteboard,
                                    UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll,
                                    UIActivityTypeAddToReadingList, UIActivityTypePostToFlickr,
                                    UIActivityTypePostToVimeo, UIActivityTypePostToTencentWeibo];
    controller.excludedActivityTypes = excludedActivities;
    
    if ([(NSString *)[UIDevice currentDevice].model hasPrefix:@"iPad"]) {
        controller.popoverPresentationController.sourceView = self.view;
        controller.popoverPresentationController.sourceRect = CGRectMake([UIScreen mainScreen].bounds.size.width * 0.5, [UIScreen mainScreen].bounds.size.height, 10, 10);
    }
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)quickLookFileWithPath:(NSString *)path
{
    self.currentPreviewPath = path;
    
    QLPreviewController *viewController = [[QLPreviewController alloc] init];
    viewController.delegate = self;
    viewController.dataSource = self;
    [viewController reloadData];
    [self presentViewController:viewController animated:YES completion:nil];
}

#pragma mark - QLPreviewControllerDelegate, QLPreviewControllerDataSource

- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller
{
    if (self.currentPreviewPath.length <= 0) {
        return 0;
    }
    return 1;
}

- (nonnull id<QLPreviewItem>)previewController:(nonnull QLPreviewController *)controller previewItemAtIndex:(NSInteger)index {
    NSURL *url = [NSURL fileURLWithPath:self.currentPreviewPath];
    if (!url && self.debugMode) {
        NSLog(@"Sandbox Out error: QLPreviewItem is Nil");
    }
    return url;
}

- (BOOL)previewController:(QLPreviewController *)controller shouldOpenURL:(NSURL *)url forPreviewItem:(id<QLPreviewItem>)item
{
    return YES;
}

- (CGRect)previewController:(QLPreviewController *)controller frameForPreviewItem:(id<QLPreviewItem>)item inSourceView:(UIView * _Nullable __autoreleasing *)view
{
    return CGRectZero;
}

- (void)previewControllerDidDismiss:(QLPreviewController *)controller
{
    self.currentPreviewPath = nil;
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.dataSource.count <= 0) {
        return 0;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SOTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SOTableViewCellId"];
    if (!cell) {
        cell = [[SOTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SOTableViewCellId"];
    }
    
    SOFileItem *fileItem = [self.dataSource objectAtIndex:indexPath.row];
    cell.fileNameLabel.text = fileItem.name;
    if (fileItem.type == SOFileItemFile) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    SOFileItem *fileItem = [self.dataSource objectAtIndex:indexPath.row];
    if (fileItem.type == SOFileItemFile) {
        if ([NSThread isMainThread]) {
            [self showFileOperationSheet:fileItem];
        } else {
            __weak __typeof(self) weakself = self;
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself showFileOperationSheet:fileItem];
            });
        }
    } else if (fileItem.type == SOFileItemDirectory) {
        [self loadFilesWithPath:fileItem.path];
    } else if (fileItem.type == SOFileItemUp) {
        [self loadFilesWithPath:[fileItem.path stringByDeletingLastPathComponent]];
    }
}

@end
