//===--- objc_implementation_strong_layout.h ------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2026 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

#import <Foundation/Foundation.h>

@interface StrongLayout : NSObject
@end

@interface LongStrongLayout : NSObject
@end

@interface PrivateNativeLayout : NSObject
@end

@interface WeakLayout : NSObject
@end

@interface UnownedLayout : NSObject
@end

@interface AggregateLayout : NSObject
@end

@interface PODAggregateLayout : NSObject
@end

@interface GenericLayout : NSObject
@end

@interface NoStrongLayout : NSObject
@end
