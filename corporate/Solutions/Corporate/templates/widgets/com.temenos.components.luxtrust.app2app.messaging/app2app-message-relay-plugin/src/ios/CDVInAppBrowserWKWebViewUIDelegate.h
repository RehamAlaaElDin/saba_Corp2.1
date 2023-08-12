//
//  CDVInAppBrowserWKWebViewUIDelegate.h
//  EdgeHybrid
//
//  Created by Vamadevan Arun on 27/11/2017.
//  Copyright © 2017 Temenos Headquarters SA. All rights reserved.

//  This source code is protected by copyright laws and international copyright treaties,
//  as well as other intellectual property laws and treaties.
//
//  Access to, alteration, duplication or redistribution of this source code in any form
//  is not permitted without the prior written authorisation of Temenos.
//

#import <WebKit/WebKit.h>

@interface CDVInAppBrowserWKWebViewUIDelegate : NSObject <WKUIDelegate>{
    @private
    UIViewController* _viewController;
}

@property (nonatomic, copy) NSString* title;

- (instancetype)initWithTitle:(NSString*)title;
-(void) setViewController:(UIViewController*) viewController;

@end
