# SandboxOut

[![Objc](https://img.shields.io/badge/Objc-blue?style=flat-square)](https://img.shields.io/badge/Objc?style=flat-square)
[![Platforms](https://img.shields.io/badge/Platforms-iOS-yellowgreen?style=flat-square)](https://img.shields.io/badge/Platforms-iOS-Green?style=flat-square)
[![Twitter](https://img.shields.io/badge/twitter-@charsdavy-blue.svg?style=flat-square)](https://twitter.com/charsdavy)

Quickly browse the iOS sandbox data in the App and perform operations.

# Usage

## CocoaPods

```
platform :ios, '11.0'

target 'SampleTarget' do
    pod 'SandboxOut'
end
```

## Manual

### import file

```
#import "SandboxOut.h"
#import "SOViewController.h"
```

## Default file path

```
SOViewController *viewController = [[SOViewController alloc] init];
[self.navigationController pushViewController:viewController animated:YES];
```

## Custom file path

```
SandboxOut *sandboxOut = [[SandboxOut alloc] initWithRootPath:@"your custom files path"];
SOViewController *viewController = [[SOViewController alloc] init];
viewController.sandboxOut = sandboxOut;
[self.navigationController pushViewController:viewController animated:YES];
```
