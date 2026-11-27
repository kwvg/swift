//===--- objc_implementation_strong_layout.swift --------------------------===//
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

// RUN: %target-swift-frontend(mock-sdk: %clang-importer-sdk) -I %S/Inputs/abi -F %clang-importer-sdk-path/frameworks %s -import-objc-header %S/Inputs/objc_implementation_strong_layout.h -emit-ir -target %target-future-triple | %FileCheck %s
// REQUIRES: OS=macosx
// REQUIRES: objc_interop
// REQUIRES: CPU=arm64 || CPU=x86_64

import Foundation

// Scalar bytes before a pointer, consecutive pointers, and a scalar gap.
// The bitmap starts at aligned instanceStart (8), not at the object header.
// CHECK-DAG: @_STRONG_IVAR_LAYOUT_StrongLayout = internal constant [3 x i8] c"\12\11\00"
// CHECK-DAG: @_STRONG_IVAR_LAYOUT_LongStrongLayout = internal constant [5 x i8] c"\0F\02\F0!\00"
// CHECK-DAG: @_METACLASS_DATA_StrongLayout = {{.*}}i32 0, ptr null,
// CHECK-DAG: @_DATA_StrongLayout = {{.*}}i32 0, ptr @_STRONG_IVAR_LAYOUT_StrongLayout, {{.*}}ptr @_IVARS_StrongLayout, ptr null,
// CHECK-DAG: @_DATA_LongStrongLayout = {{.*}}i32 0, ptr @_STRONG_IVAR_LAYOUT_LongStrongLayout, {{.*}}ptr @_IVARS_LongStrongLayout, ptr null,

@_objcImplementation extension StrongLayout {
  private var head: UInt8 = 0
  private var first: NSObject? = nil
  private var second: NSObject? = nil
  private var gap: UInt64 = 0
  private var third: NSObject? = nil
  private var unsafe: UnsafeMutableRawPointer? = nil
}

@_objcImplementation extension LongStrongLayout {
  private var object0: NSObject? = nil
  private var object1: NSObject? = nil
  private var object2: NSObject? = nil
  private var object3: NSObject? = nil
  private var object4: NSObject? = nil
  private var object5: NSObject? = nil
  private var object6: NSObject? = nil
  private var object7: NSObject? = nil
  private var object8: NSObject? = nil
  private var object9: NSObject? = nil
  private var object10: NSObject? = nil
  private var object11: NSObject? = nil
  private var object12: NSObject? = nil
  private var object13: NSObject? = nil
  private var object14: NSObject? = nil
  private var object15: NSObject? = nil
  private var object16: NSObject? = nil
  private var gap0: UInt64 = 0
  private var gap1: UInt64 = 0
  private var gap2: UInt64 = 0
  private var gap3: UInt64 = 0
  private var gap4: UInt64 = 0
  private var gap5: UInt64 = 0
  private var gap6: UInt64 = 0
  private var gap7: UInt64 = 0
  private var gap8: UInt64 = 0
  private var gap9: UInt64 = 0
  private var gap10: UInt64 = 0
  private var gap11: UInt64 = 0
  private var gap12: UInt64 = 0
  private var gap13: UInt64 = 0
  private var gap14: UInt64 = 0
  private var gap15: UInt64 = 0
  private var gap16: UInt64 = 0
  private var tail: NSObject? = nil
}

class NativeReference {}
struct Aggregate { var object: NSObject? }
struct PODAggregate { var value: UInt64 = 0 }
struct Generic<T> { var value: T }

// Every unsupported field suppresses the entire map, including private fields.
// CHECK-DAG: @_DATA_PrivateNativeLayout = {{.*}}i32 0, ptr null, {{.*}}ptr @_IVARS_PrivateNativeLayout, ptr null,
// CHECK-DAG: @_DATA_WeakLayout = {{.*}}i32 0, ptr null, {{.*}}ptr @_IVARS_WeakLayout, ptr null,
// CHECK-DAG: @_DATA_UnownedLayout = {{.*}}i32 0, ptr null, {{.*}}ptr @_IVARS_UnownedLayout, ptr null,
// CHECK-DAG: @_DATA_AggregateLayout = {{.*}}i32 0, ptr null, {{.*}}ptr @_IVARS_AggregateLayout, ptr null,
// CHECK-DAG: @_DATA_PODAggregateLayout = {{.*}}i32 0, ptr null, {{.*}}ptr @_IVARS_PODAggregateLayout, ptr null,
// CHECK-DAG: @_DATA_GenericLayout = {{.*}}i32 0, ptr null, {{.*}}ptr @_IVARS_GenericLayout, ptr null,
// CHECK-DAG: @_DATA_NoStrongLayout = {{.*}}i32 0, ptr null, {{.*}}ptr @_IVARS_NoStrongLayout, ptr null,

@_objcImplementation extension PrivateNativeLayout {
  private var object: NSObject? = nil
  private var hidden: NativeReference? = nil
}
@_objcImplementation extension WeakLayout {
  private var object: NSObject? = nil
  private weak var hidden: NSObject? = nil
}
@_objcImplementation extension UnownedLayout {
  private var object: NSObject? = nil
  private unowned var hidden: NSObject? = nil
}
@_objcImplementation extension AggregateLayout {
  private var object: NSObject? = nil
  private var hidden = Aggregate(object: nil)
}
@_objcImplementation extension PODAggregateLayout {
  private var object: NSObject? = nil
  private var hidden = PODAggregate()
}
@_objcImplementation extension GenericLayout {
  private var object: NSObject? = nil
  private var hidden = Generic(value: UInt64(0))
}
@_objcImplementation extension NoStrongLayout {
  private var scalar: UInt64 = 0
  private var unsafe: UnsafeRawPointer? = nil
}
