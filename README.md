# SandboxOut

[![Objc](https://img.shields.io/badge/Objc-blue?style=flat-square)](https://img.shields.io/badge/Objc?style=flat-square)
[![Platforms](https://img.shields.io/badge/Platforms-iOS-yellowgreen?style=flat-square)](https://img.shields.io/badge/Platforms-iOS-Green?style=flat-square)
[![Twitter](https://img.shields.io/badge/twitter-@charsdavy-blue.svg?style=flat-square)](https://twitter.com/charsdavy)

Quickly browse the iOS sandbox data in the App and perform operations.

# Usage

## import file

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

# Demo

![截图1](./Docs/ScreenShot-1.png)
![截图2](./Docs/ScreenShot-2.png)
