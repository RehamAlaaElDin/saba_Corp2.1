//
//  CDVInAppBrowserWKWebView.h
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


#import <Cordova/CDVPlugin.h>
#import <Cordova/CDVInvokedUrlCommand.h>
#import <Cordova/CDVScreenOrientationDelegate.h>
#import "CDVInAppBrowserWKWebViewUIDelegate.h"

#ifdef __CORDOVA_4_0_0
    #import <Cordova/CDVUIWebViewDelegate.h>
#else
    #import <Cordova/CDVWebViewDelegate.h>
#endif

@class CDVInAppBrowserWKWebViewViewController;

@interface CDVInAppBrowserWKWebView : CDVPlugin {
    BOOL _injectedIframeBridge;
}

@property (nonatomic, retain) CDVInAppBrowserWKWebViewViewController* InAppBrowserWKWebViewViewController;
@property (nonatomic, copy) NSString* callbackId;
@property (nonatomic, copy) NSRegularExpression *callbackIdPattern;

- (void)open:(CDVInvokedUrlCommand*)command;
- (void)close:(CDVInvokedUrlCommand*)command;
- (void)injectScriptCode:(CDVInvokedUrlCommand*)command;
- (void)show:(CDVInvokedUrlCommand*)command;
- (void)hide:(CDVInvokedUrlCommand*)command;

@end

@interface CDVInAppBrowserWKWebViewOptions : NSObject {}

@property (nonatomic, assign) BOOL location;
@property (nonatomic, assign) BOOL toolbar;
@property (nonatomic, copy) NSString* closebuttoncaption;
@property (nonatomic, copy) NSString* toolbarposition;
@property (nonatomic, assign) BOOL clearcache;
@property (nonatomic, assign) BOOL clearsessioncache;

@property (nonatomic, copy) NSString* presentationstyle;
@property (nonatomic, copy) NSString* transitionstyle;

@property (nonatomic, assign) BOOL enableviewportscale;
@property (nonatomic, assign) BOOL mediaplaybackrequiresuseraction;
@property (nonatomic, assign) BOOL allowinlinemediaplayback;
@property (nonatomic, assign) BOOL keyboarddisplayrequiresuseraction;
@property (nonatomic, assign) BOOL suppressesincrementalrendering;
@property (nonatomic, assign) BOOL hidden;
@property (nonatomic, assign) BOOL disallowoverscroll;

+ (CDVInAppBrowserWKWebViewOptions*)parseOptions:(NSString*)options;

@end

@interface CDVInAppBrowserWKWebViewViewController : UIViewController <CDVScreenOrientationDelegate,WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>{
    @private
    NSString* _userAgent;
    NSString* _prevUserAgent;
    NSInteger _userAgentLockToken;
    CDVInAppBrowserWKWebViewOptions *_browserOptions;
    
#ifdef __CORDOVA_4_0_0
    CDVUIWebViewDelegate* _webViewDelegate;
#else
    CDVWebViewDelegate* _webViewDelegate;
#endif
    
}
@property (nonatomic, strong) IBOutlet WKWebView* webView;
@property (nonatomic, strong) IBOutlet WKWebViewConfiguration* configuration;
@property (nonatomic, strong) IBOutlet UIBarButtonItem* closeButton;
@property (nonatomic, strong) IBOutlet UILabel* addressLabel;
@property (nonatomic, strong) IBOutlet UIBarButtonItem* backButton;
@property (nonatomic, strong) IBOutlet UIBarButtonItem* forwardButton;
//@property (nonatomic, strong) IBOutlet UIActivityIndicatorView* spinner;
@property (nonatomic, strong) IBOutlet UIToolbar* toolbar;
@property (nonatomic, strong) IBOutlet CDVInAppBrowserWKWebViewUIDelegate* webViewUIDelegate;

@property (nonatomic, weak) id <CDVScreenOrientationDelegate> orientationDelegate;
@property (nonatomic, weak) CDVInAppBrowserWKWebView* navigationDelegate;
@property (nonatomic) NSURL* currentURL;

- (void)close;
- (void)navigateTo:(NSURL*)url;
- (void)showLocationBar:(BOOL)show;
- (void)showToolBar:(BOOL)show : (NSString *) toolbarPosition;
- (void)setCloseButtonTitle:(NSString*)title;

- (id)initWithUserAgent:(NSString*)userAgent prevUserAgent:(NSString*)prevUserAgent browserOptions: (CDVInAppBrowserWKWebViewOptions*) browserOptions;

@end

@interface CDVInAppBrowserWKWebViewNavigationController : UINavigationController

@property (nonatomic, weak) id <CDVScreenOrientationDelegate> orientationDelegate;

@end

