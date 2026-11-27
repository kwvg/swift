// This source file is part of the Swift.org open source project
//
// Copyright (c) 2026 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for Swift project authors

#import <Foundation/Foundation.h>

@interface EncodingImplementation : NSObject
- (_Bool)echoC:(_Bool)value;
- (BOOL)echoObjC:(BOOL)value;
- (signed char)echoChar:(signed char)value;
@property (nonatomic) _Bool cFlag;
@property (nonatomic) BOOL objcFlag;
@property (nonatomic) signed char charFlag;
@end

@interface EncodingImplementation (Extra)
- (_Bool)categoryC:(_Bool)value;
@end
