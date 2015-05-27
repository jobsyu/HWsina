//
//  UIGlobalCommon.m
//  Movie
//
//  Created by qianfeng on 14-10-11.
//  Copyright (c) 2014年 Albert. All rights reserved.
//

#import "UIGlobalCommon.h"

const CGFloat kDefaultRowHeight = 44;

const CGFloat kDefaultPortraitToolbarHeight   = 44;
const CGFloat kDefaultLandscapeToolbarHeight  = 33;

const CGFloat kDefaultPortraitKeyboardHeight      = 216;
const CGFloat kDefaultLandscapeKeyboardHeight     = 160;
const CGFloat kDefaultPadPortraitKeyboardHeight   = 264;
const CGFloat kDefaultPadLandscapeKeyboardHeight  = 352;

const CGFloat kGroupedTableCellInset = 9;
const CGFloat kGroupedPadTableCellInset = 42;

const CGFloat kDefaulransitionDuration      = 0.3;
const CGFloat kDefaultFasransitionDuration  = 0.2;
const CGFloat kDefaultFlipTransitionDuration  = 0.7;



///////////////////////////////////////////////////////////////////////////////////////////////////
float OSVersion()
{
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
BOOL OSVersionIsAtLeast(float version)
{
    static const CGFloat kEpsilon = 0.0000001;
#ifdef __IPHONE_8_0
    return 8.0 - version >= -kEpsilon;
#endif
#ifdef __IPHONE_7_0
    return 7.0 - version >= -kEpsilon;
#endif
#ifdef __IPHONE_6_0
    return 6.0 - version >= -kEpsilon;
#endif
#ifdef __IPHONE_5_1
    return 5.1 - version >= -kEpsilon;
#endif
#ifdef __IPHONE_5_0
    return 5.0 - version >= -kEpsilon;
#endif
#ifdef __IPHONE_4_2
    return 4.2 - version >= -kEpsilon;
#endif
#ifdef __IPHONE_4_1
    return 4.1 - version >= -kEpsilon;
#endif
#ifdef __IPHONE_4_0
    return 4.0 - version >= -kEpsilon;
#endif
#ifdef __IPHONE_3_2
    return 3.2 - version >= -kEpsilon;
#endif
#ifdef __IPHONE_3_1
    return 3.1 - version >= -kEpsilon;
#endif
#ifdef __IPHONE_3_0
    return 3.0 - version >= -kEpsilon;
#endif
#ifdef __IPHONE_2_2
    return 2.2 - version >= -kEpsilon;
#endif
#ifdef __IPHONE_2_1
    return 2.1 - version >= -kEpsilon;
#endif
#ifdef __IPHONE_2_0
    return 2.0 - version >= -kEpsilon;
#endif
    return NO;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
BOOL IsKeyboardVisible() {
    // Operates on the assumption that the keyboard is visible if and only if there is a first
    // responder; i.e. a control responding to key events
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    return ![window isFirstResponder];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
BOOL IsPhoneSupported() {
    NSString* deviceType = [UIDevice currentDevice].model;
    return [deviceType isEqualToString:@"iPhone"];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
BOOL IsPad() {
#ifdef __IPHONE_3_2
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
#else
    return NO;
#endif
}


///////////////////////////////////////////////////////////////////////////////////////////////////
UIDeviceOrientation DeviceOrientation() {
    UIDeviceOrientation orient = [UIDevice currentDevice].orientation;
    if (UIDeviceOrientationUnknown == orient) {
        return UIDeviceOrientationPortrait;
        
    } else {
        return orient;
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
BOOL IsSupportedOrientation(UIInterfaceOrientation orientation) {
    if (IsPad()) {
        return YES;
        
    } else {
        switch (orientation) {
            case UIInterfaceOrientationPortrait:
            case UIInterfaceOrientationLandscapeLeft:
            case UIInterfaceOrientationLandscapeRight:
                return YES;
            default:
                return NO;
        }
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
CGAffineTransform RotateTransformForOrientation(UIInterfaceOrientation orientation) {
    if (orientation == UIInterfaceOrientationLandscapeLeft) {
        return CGAffineTransformMakeRotation(M_PI*1.5);
        
    } else if (orientation == UIInterfaceOrientationLandscapeRight) {
        return CGAffineTransformMakeRotation(M_PI/2);
        
    } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
        return CGAffineTransformMakeRotation(-M_PI);
        
    } else {
        return CGAffineTransformIdentity;
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////

CGRect ApplicationBounds()
{
    return [UIScreen mainScreen].bounds;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
CGRect ApplicationFrame() {
    CGRect frame = [UIScreen mainScreen].applicationFrame;
    return CGRectMake(0, 0, frame.size.width, frame.size.height);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
CGFloat ToolbarHeightForOrientation(UIInterfaceOrientation orientation) {
    if (UIInterfaceOrientationIsPortrait(orientation) || IsPad()) {
        return ROW_HEIGHT;
        
    } else {
        return LANDSCAPE_TOOLBAR_HEIGHT;
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
CGFloat KeyboardHeightForOrientation(UIInterfaceOrientation orientation) {
    if (IsPad()) {
        return UIInterfaceOrientationIsPortrait(orientation) ? IPAD_KEYBOARD_HEIGHT
        : IPAD_LANDSCAPE_KEYBOARD_HEIGHT;
        
    } else {
        return UIInterfaceOrientationIsPortrait(orientation) ? KEYBOARD_HEIGHT
        : LANDSCAPE_KEYBOARD_HEIGHT;
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
CGFloat GroupedTableCellInset() {
    return IsPad() ? kGroupedPadTableCellInset : kGroupedTableCellInset;
}


