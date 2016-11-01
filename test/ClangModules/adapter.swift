// RUN: %target-swift-frontend(mock-sdk: %clang-importer-sdk) -parse -verify -I %S/Inputs/custom-modules %s
// RUN: %target-swift-frontend(mock-sdk: %clang-importer-sdk) -parse -verify -I %S/Inputs/custom-modules -DREVERSED %s

// REQUIRES: objc_interop

// Do not import Foundation! This tests indirect visibility.
#if REVERSED
import Redeclaration
import AppKit
#else
import AppKit
import Redeclaration
#endif

let encoding: UInt = NSUTF8StringEncoding

let viaTypedef: Redeclaration.NSPoint = AppKit.NSPoint(x: 0, y: 0)
Redeclaration.NSStringToNSString(AppKit.NSStringToNSString("abc")) // expected-warning {{result of call is unused}}

let viaStruct: Redeclaration.FooStructA = AppKit.FooStructA()
let forwardDecl: Redeclaration.Tribool = AppKit.Tribool() // expected-error {{no type named 'Tribool' in module 'Redeclaration'}}
