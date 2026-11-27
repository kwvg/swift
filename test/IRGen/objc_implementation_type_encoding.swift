// This source file is part of the Swift.org open source project
//
// Copyright (c) 2026 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for Swift project authors

// REQUIRES: OS=macosx
// REQUIRES: objc_interop
// RUN: %target-swift-frontend(mock-sdk: %clang-importer-sdk) -I %S/Inputs/abi -F %clang-importer-sdk-path/frameworks %s -import-objc-header %S/Inputs/objc_implementation_type_encoding.h -emit-ir -target x86_64-apple-macosx13.0 | %FileCheck %s --check-prefixes=CHECK,X86
// RUN: %target-swift-frontend(mock-sdk: %clang-importer-sdk) -I %S/Inputs/abi -F %clang-importer-sdk-path/frameworks %s -import-objc-header %S/Inputs/objc_implementation_type_encoding.h -emit-ir -target arm64-apple-macosx13.0 | %FileCheck %s --check-prefixes=CHECK,ARM

// _Bool and BOOL both import as Bool, but must retain their foreign types.
// Check selector/encoding pairs so shared string constants cannot hide a
// method using the wrong encoding.
// CHECK-DAG: ptr @"\01L_selector_data(echoC:)", ptr @".str.10.B20@0:8B16"
// X86-DAG: ptr @"\01L_selector_data(echoObjC:)", ptr @".str.10.c20@0:8c16"
// ARM-DAG: ptr @"\01L_selector_data(echoObjC:)", ptr @".str.10.B20@0:8B16"
// CHECK-DAG: ptr @"\01L_selector_data(echoChar:)", ptr @".str.10.c20@0:8c16"
// CHECK-DAG: ptr @"\01L_selector_data(cFlag)", ptr @".str.7.B16@0:8"
// CHECK-DAG: ptr @"\01L_selector_data(setCFlag:)", ptr @".str.10.v20@0:8B16"
// X86-DAG: ptr @"\01L_selector_data(objcFlag)", ptr @".str.7.c16@0:8"
// X86-DAG: ptr @"\01L_selector_data(setObjcFlag:)", ptr @".str.10.v20@0:8c16"
// ARM-DAG: ptr @"\01L_selector_data(objcFlag)", ptr @".str.7.B16@0:8"
// ARM-DAG: ptr @"\01L_selector_data(setObjcFlag:)", ptr @".str.10.v20@0:8B16"
// CHECK-DAG: ptr @"\01L_selector_data(charFlag)", ptr @".str.7.c16@0:8"
// CHECK-DAG: ptr @"\01L_selector_data(setCharFlag:)", ptr @".str.10.v20@0:8c16"
// CHECK-DAG: ptr @"\01L_selector_data(categoryC:)", ptr @".str.10.B20@0:8B16"
// X86-DAG: ptr @"\01L_selector_data(swiftBool:)", ptr @".str.10.c20@0:8c16"
// ARM-DAG: ptr @"\01L_selector_data(swiftBool:)", ptr @".str.10.B20@0:8B16"

@objc @implementation extension EncodingImplementation {
  func echoC(_ value: Bool) -> Bool { value }
  func echoObjC(_ value: Bool) -> Bool { value }
  func echoChar(_ value: Int8) -> Int8 { value }

  var cFlag: Bool {
    get { true }
    set {}
  }
  var objcFlag: Bool {
    get { true }
    set {}
  }
  var charFlag: Int8 {
    get { 0 }
    set {}
  }
}

@objc(Extra) @implementation extension EncodingImplementation {
  func categoryC(_ value: Bool) -> Bool { value }
}

class SwiftEncodingControl: NSObject {
  @objc func swiftBool(_ value: Bool) -> Bool { value }
}

// Check the foreign entry points as well as their descriptive metadata.
// X86-DAG: define internal zeroext i1 @"{{.*}}5echoC{{.*}}FTo"(ptr {{.*}}, ptr {{.*}}, i1 zeroext
// X86-DAG: define internal signext i8 @"{{.*}}8echoObjC{{.*}}FTo"(ptr {{.*}}, ptr {{.*}}, i8 signext
// X86-DAG: define internal signext i8 @"{{.*}}8echoChar{{.*}}FTo"(ptr {{.*}}, ptr {{.*}}, i8 signext
