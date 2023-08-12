//
//  CDVInAppBrowserWKWebView.m
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


#import "CDVInAppBrowserWKWebView.h"
#import <Cordova/CDVPluginResult.h>
#import <Cordova/CDVUserAgentUtil.h>
#import "AppDelegate.h"
#import "Utils.h"
#import "objc/runtime.h"

#define    kInAppBrowserWKWebViewTargetSelf @"_self"
#define    kInAppBrowserWKWebViewTargetSystem @"_system"
#define    kInAppBrowserWKWebViewTargetBlank @"_blank"

#define    kInAppBrowserWKWebViewToolbarBarPositionBottom @"bottom"
#define    kInAppBrowserWKWebViewToolbarBarPositionTop @"top"

#define    IAB_BRIDGE_NAME @"cordova_iab"

#define    TOOLBAR_HEIGHT 44.0
#define    STATUSBAR_HEIGHT 20.0
#define    LOCATIONBAR_HEIGHT 21.0
#define    FOOTER_HEIGHT ((TOOLBAR_HEIGHT) + (LOCATIONBAR_HEIGHT))

NSString* url;
BOOL canNvigateToUIWeb;

NSString *jsMessageName;
NSString *clientUrlScheme;
NSString *orelyUrl;
BOOL isIframe;
NSString *iframeName;

#pragma mark CDVInAppBrowserWKWebView

@interface CDVInAppBrowserWKWebView () {
    NSInteger _previousStatusBarStyle;
}

-(BOOL) onApp2AppCallBack:(NSURL *) url;

@end

// need to swap out a method, so swizzling it here
static void swizzleMethod(Class class, SEL destinationSelector, SEL sourceSelector);

@implementation AppDelegate (identityUrlHandling)

+ (void)load {
    swizzleMethod([AppDelegate class],
                  @selector(application:openURL:sourceApplication:annotation:),
                  @selector(identity_application:openURL:sourceApplication:annotation:));
    
}
    
- (BOOL)identity_application: (UIApplication *)application
                     openURL: (NSURL *)url
           sourceApplication: (NSString *)sourceApplication
                  annotation: (id)annotation {
    if(!url){
        return NO;
    }
        
    if([[url absoluteString] hasPrefix:clientUrlScheme]){
        CDVInAppBrowserWKWebView *iabwk = [self.viewController getCommandInstance:@"InAppBrowserWKWebView"];
        [iabwk onApp2AppCallBack:url];
    }
    return NO;
}

@end

static void swizzleMethod(Class class, SEL destinationSelector, SEL sourceSelector) {
    Method destinationMethod = class_getInstanceMethod(class, destinationSelector);
    Method sourceMethod = class_getInstanceMethod(class, sourceSelector);
    
    // If the method doesn't exist, add it.  If it does exist, replace it with the given implementation.
    if (class_addMethod(class, destinationSelector, method_getImplementation(sourceMethod), method_getTypeEncoding(sourceMethod))) {
        class_replaceMethod(class, destinationSelector, method_getImplementation(destinationMethod), method_getTypeEncoding(destinationMethod));
    } else {
        method_exchangeImplementations(destinationMethod, sourceMethod);
    }
}


@implementation CDVInAppBrowserWKWebView

- (void)pluginInitialize
{
    _previousStatusBarStyle = -1;
    _callbackIdPattern = nil;
}

-(BOOL) onApp2AppCallBack:(NSURL *) url{
    
    //NSString *theWindows = isIframe? @"document.getElementById('iframe').contentWindow": @"window";
    NSString *theWindows = isIframe? [[@"document.getElementById('" stringByAppendingString:iframeName] stringByAppendingString:@"').contentWindow"] : @"window";

    NSString *javaScript = [[[[[theWindows stringByAppendingString:@".postMessage('"] stringByAppendingString:url.absoluteString] stringByAppendingString:@"','"] stringByAppendingString: orelyUrl] stringByAppendingString:@"')"];
    
    /*NSString *javaScript1 = [[@"setTimeout(function(){" stringByAppendingString:javaScript] stringByAppendingString:@"},500)"] ;*/
    
    [self evaluateJavaScript:javaScript];
    return true;
}


- (id)settingForKey:(NSString*)key
{
    return [self.commandDelegate.settings objectForKey:[key lowercaseString]];
}

- (void)onReset
{
    [self close:nil];
}

- (void)close:(CDVInvokedUrlCommand*)command
{
    if (self.InAppBrowserWKWebViewViewController == nil) {
        NSLog(@"IAB.close() called but it was already closed.");
        return;
    }
    // Things are cleaned up in browserExit.
    [self.InAppBrowserWKWebViewViewController close];
}

- (BOOL) isSystemUrl:(NSURL*)url
{
	if ([[url host] isEqualToString:@"itunes.apple.com"]) {
		return YES;
	}

	return NO;
}

- (void)open:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult;

    url = [command argumentAtIndex:0];
    NSString* target = [command argumentAtIndex:1 withDefault:kInAppBrowserWKWebViewTargetSelf];
    NSString* options = [command argumentAtIndex:2 withDefault:@"" andClass:[NSString class]];
    
    NSString *filePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"hybridConfig.plist"];
    NSDictionary* plistDictionary = [[NSDictionary alloc] initWithContentsOfFile:filePath];
    NSArray *app2Appconfig = [plistDictionary objectForKey:@"app2appConfiguration"];
    clientUrlScheme  = [[app2Appconfig valueForKey:@"clientUrlScheme"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    //jsMessageName = [[app2Appconfig valueForKey:@"jsMessageName"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    jsMessageName = @"launchApp2App";//Hardcoding for LuxTrust. Use above line for passing from plugin.xml
    //isIframe = [[[app2Appconfig valueForKey:@"isUsingIframe"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] boolValue];
    iframeName = [[app2Appconfig valueForKey:@"iframeName"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    isIframe = ([[iframeName uppercaseString] isEqualToString:@"NONE"] || [iframeName length] == 0) ? NO : YES;
    orelyUrl = [[app2Appconfig valueForKey:@"orelyUrl"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

    self.callbackId = command.callbackId;

    if (url != nil) {
#ifdef __CORDOVA_4_0_0
        NSURL* baseUrl = [self.webViewEngine URL];
#else
        NSURL* baseUrl = [self.webView.request URL];
#endif
        NSURL* absoluteUrl = [[NSURL URLWithString:url relativeToURL:baseUrl] absoluteURL];

        if ([self isSystemUrl:absoluteUrl]) {
            target = kInAppBrowserWKWebViewTargetSystem;
        }

        if ([target isEqualToString:kInAppBrowserWKWebViewTargetSelf]) {
            [self openInCordovaWebView:absoluteUrl withOptions:options];
        } else if ([target isEqualToString:kInAppBrowserWKWebViewTargetSystem]) {
            [self openInSystem:absoluteUrl];
        } else { // _blank or anything else
            [self openInInAppBrowserWKWebView:absoluteUrl withOptions:options];
        }

        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"incorrect number of arguments"];
    }

    [pluginResult setKeepCallback:[NSNumber numberWithBool:YES]];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)openInInAppBrowserWKWebView:(NSURL*)url withOptions:(NSString*)options
{
    CDVInAppBrowserWKWebViewOptions* browserOptions = [CDVInAppBrowserWKWebViewOptions parseOptions:options];

    if (browserOptions.clearcache) {
        NSHTTPCookie *cookie;
        NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (cookie in [storage cookies])
        {
            if (![cookie.domain isEqual: @".^filecookies^"]) {
                [storage deleteCookie:cookie];
            }
        }
    }

    if (browserOptions.clearsessioncache) {
        NSHTTPCookie *cookie;
        NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (cookie in [storage cookies])
        {
            if (![cookie.domain isEqual: @".^filecookies^"] && cookie.isSessionOnly) {
                [storage deleteCookie:cookie];
            }
        }
    }

    if (self.InAppBrowserWKWebViewViewController == nil) {
        NSString* userAgent = [CDVUserAgentUtil originalUserAgent];
        NSString* overrideUserAgent = [self settingForKey:@"OverrideUserAgent"];
        NSString* appendUserAgent = [self settingForKey:@"AppendUserAgent"];
        if(overrideUserAgent){
            userAgent = overrideUserAgent;
        }
        if(appendUserAgent){
            userAgent = [userAgent stringByAppendingString: appendUserAgent];
        }
        self.InAppBrowserWKWebViewViewController = [[CDVInAppBrowserWKWebViewViewController alloc] initWithUserAgent:userAgent prevUserAgent:[self.commandDelegate userAgent] browserOptions: browserOptions];
        self.InAppBrowserWKWebViewViewController.navigationDelegate = self;
        
        if ([self.viewController conformsToProtocol:@protocol(CDVScreenOrientationDelegate)]) {
            self.InAppBrowserWKWebViewViewController.orientationDelegate = (UIViewController <CDVScreenOrientationDelegate>*)self.viewController;
        }
    }

    [self.InAppBrowserWKWebViewViewController showLocationBar:browserOptions.location];
    //[self.InAppBrowserWKWebViewViewController showToolBar:browserOptions.toolbar :browserOptions.toolbarposition];
    //-----HIDING TOOL BAR INTENTIONALLY  :) ----------------------------------------
    [self.InAppBrowserWKWebViewViewController showToolBar:NO :browserOptions.toolbarposition];
    if (browserOptions.closebuttoncaption != nil) {
        [self.InAppBrowserWKWebViewViewController setCloseButtonTitle:browserOptions.closebuttoncaption];
    }
    // Set Presentation Style
    UIModalPresentationStyle presentationStyle = UIModalPresentationFullScreen; // default
    if (browserOptions.presentationstyle != nil) {
        if ([[browserOptions.presentationstyle lowercaseString] isEqualToString:@"pagesheet"]) {
            presentationStyle = UIModalPresentationPageSheet;
        } else if ([[browserOptions.presentationstyle lowercaseString] isEqualToString:@"formsheet"]) {
            presentationStyle = UIModalPresentationFormSheet;
        }
    }
    self.InAppBrowserWKWebViewViewController.modalPresentationStyle = presentationStyle;

    // Set Transition Style
    UIModalTransitionStyle transitionStyle = UIModalTransitionStyleCoverVertical; // default
    if (browserOptions.transitionstyle != nil) {
        if ([[browserOptions.transitionstyle lowercaseString] isEqualToString:@"fliphorizontal"]) {
            transitionStyle = UIModalTransitionStyleFlipHorizontal;
        } else if ([[browserOptions.transitionstyle lowercaseString] isEqualToString:@"crossdissolve"]) {
            transitionStyle = UIModalTransitionStyleCrossDissolve;
        }
    }
    self.InAppBrowserWKWebViewViewController.modalTransitionStyle = transitionStyle;

    // prevent webView from bouncing
    if (browserOptions.disallowoverscroll) {
        if ([self.InAppBrowserWKWebViewViewController.webView respondsToSelector:@selector(scrollView)]) {
            ((UIScrollView*)[self.InAppBrowserWKWebViewViewController.webView scrollView]).bounces = NO;
        } else {
            for (id subview in self.InAppBrowserWKWebViewViewController.webView.subviews) {
                if ([[subview class] isSubclassOfClass:[UIScrollView class]]) {
                    ((UIScrollView*)subview).bounces = NO;
                }
            }
        }
    }
    
    [self.InAppBrowserWKWebViewViewController navigateTo:url];
    [self show:nil withNoAnimate:browserOptions.hidden];
}

- (void)show:(CDVInvokedUrlCommand*)command{
    [self show:command withNoAnimate:NO];
}

- (void)show:(CDVInvokedUrlCommand*)command withNoAnimate:(BOOL)noAnimate
{
    BOOL initHidden = NO;
    if(command == nil && noAnimate == YES){
        initHidden = YES;
    }
    
    if (self.InAppBrowserWKWebViewViewController == nil) {
        NSLog(@"Tried to show IAB after it was closed.");
        return;
    }
    if (_previousStatusBarStyle != -1) {
        NSLog(@"Tried to show IAB while already shown");
        return;
    }
    
    if(!initHidden){
        _previousStatusBarStyle = [UIApplication sharedApplication].statusBarStyle;
    }
    
    __block CDVInAppBrowserWKWebViewNavigationController* nav = [[CDVInAppBrowserWKWebViewNavigationController alloc]
                                                        initWithRootViewController:self.InAppBrowserWKWebViewViewController];
    nav.orientationDelegate = self.InAppBrowserWKWebViewViewController;
    nav.navigationBarHidden = YES;
    nav.modalPresentationStyle = self.InAppBrowserWKWebViewViewController.modalPresentationStyle;
    
    __weak CDVInAppBrowserWKWebView* weakSelf = self;
    
    // Run later to avoid the "took a long time" log message.
    dispatch_async(dispatch_get_main_queue(), ^{
        if (weakSelf.InAppBrowserWKWebViewViewController != nil) {
            CGRect frame = [[UIScreen mainScreen] bounds];
            if(initHidden){
                frame.origin.x = -10000;
            }
            
            UIWindow *tmpWindow = [[UIWindow alloc] initWithFrame:frame];
            UIViewController *tmpController = [[UIViewController alloc] init];
            
            [tmpWindow setRootViewController:tmpController];
            [tmpWindow setWindowLevel:UIWindowLevelNormal];
            
            [tmpWindow makeKeyAndVisible];
            [tmpController presentViewController:nav animated:!noAnimate completion:nil];
        }
    });
}

- (void)hide:(CDVInvokedUrlCommand*)command
{
    if (self.InAppBrowserWKWebViewViewController == nil) {
        NSLog(@"Tried to hide IAB after it was closed.");
        return;
        
        
    }
    if (_previousStatusBarStyle == -1) {
        NSLog(@"Tried to hide IAB while already hidden");
        return;
    }
    
    _previousStatusBarStyle = [UIApplication sharedApplication].statusBarStyle;
    
    // Run later to avoid the "took a long time" log message.
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.InAppBrowserWKWebViewViewController != nil) {
            _previousStatusBarStyle = -1;
            [self.InAppBrowserWKWebViewViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
        }
    });
}

- (void)openInCordovaWebView:(NSURL*)url withOptions:(NSString*)options
{
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
#ifdef __CORDOVA_4_0_0
        [self.webViewEngine loadRequest:request];
#else
    if ([self.commandDelegate URLIsWhitelisted:url]) {
        [self.webView loadRequest:request];
        } else { // this assumes the InAppBrowserWKWebView can be excepted from the white-list
        [self openInInAppBrowserWKWebView:url withOptions:options];
    }
#endif
    
}

- (void)openInSystem:(NSURL*)url
{
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:CDVPluginHandleOpenURLNotification object:url]];
    [[UIApplication sharedApplication] openURL:url];
}

// This is a helper method for the inject{Script|Style}{Code|File} API calls, which
// provides a consistent method for injecting JavaScript code into the document.
//
// If a wrapper string is supplied, then the source string will be JSON-encoded (adding
// quotes) and wrapped using string formatting. (The wrapper string should have a single
// '%@' marker).
//
// If no wrapper is supplied, then the source string is executed directly.

- (void)injectDeferredObject:(NSString*)source withWrapper:(NSString*)jsWrapper
{
    // Ensure a message handler bridge is created to communicate with the CDVInAppBrowserViewController
    [self evaluateJavaScript: [NSString stringWithFormat:@"(function(w){if(!w._cdvMessageHandler) {w._cdvMessageHandler = function(id,d){w.webkit.messageHandlers.%@.postMessage({d:d, id:id});}}})(window)", IAB_BRIDGE_NAME]];
    
    if (jsWrapper != nil) {
        NSData* jsonData = [NSJSONSerialization dataWithJSONObject:@[source] options:0 error:nil];
        NSString* sourceArrayString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        if (sourceArrayString) {
            NSString* sourceString = [sourceArrayString substringWithRange:NSMakeRange(1, [sourceArrayString length] - 2)];
            NSString* jsToInject = [NSString stringWithFormat:jsWrapper, sourceString];
            [self evaluateJavaScript:jsToInject];
        }
    } else {
        [self evaluateJavaScript:source];
    }
}

//Synchronus helper for javascript evaluation

- (NSString *)evaluateJavaScript:(NSString *)script {
    __block NSString *resultString = nil;
    __block BOOL finished = NO;
    __block NSString* _script = script;
    
    [self.InAppBrowserWKWebViewViewController.webView evaluateJavaScript:script completionHandler:^(id result, NSError *error) {
        if (error == nil) {
            if (result != nil) {
                resultString = result;
                NSLog(@"%@", resultString);
            }
        } else {
            NSLog(@"evaluateJavaScript error : %@ : %@", error.localizedDescription, _script);
        }
        finished = YES;
    }];
    
    while (!finished)
    {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
    
    return resultString;
}

- (void)injectScriptCode:(CDVInvokedUrlCommand*)command
{
    NSString* jsWrapper = nil;
    
    if ((command.callbackId != nil) && ![command.callbackId isEqualToString:@"INVALID"]) {
        jsWrapper = [NSString stringWithFormat:@"_cdvMessageHandler('%@',JSON.stringify([eval(%%@)]));", command.callbackId];
    }
    [self injectDeferredObject:[command argumentAtIndex:0] withWrapper:jsWrapper];
}

- (void)injectScriptFile:(CDVInvokedUrlCommand*)command
{
    NSString* jsWrapper;
    
    if ((command.callbackId != nil) && ![command.callbackId isEqualToString:@"INVALID"]) {
        jsWrapper = [NSString stringWithFormat:@"(function(d) { var c = d.createElement('script'); c.src = %%@; c.onload = function() { _cdvMessageHandler('%@'); }; d.body.appendChild(c); })(document)", command.callbackId];
    } else {
        jsWrapper = @"(function(d) { var c = d.createElement('script'); c.src = %@; d.body.appendChild(c); })(document)";
    }
    [self injectDeferredObject:[command argumentAtIndex:0] withWrapper:jsWrapper];

}

- (void)injectStyleCode:(CDVInvokedUrlCommand*)command
{
    NSString* jsWrapper;
    
    if ((command.callbackId != nil) && ![command.callbackId isEqualToString:@"INVALID"]) {
        jsWrapper = [NSString stringWithFormat:@"(function(d) { var c = d.createElement('style'); c.innerHTML = %%@; c.onload = function() { _cdvMessageHandler('%@'); }; d.body.appendChild(c); })(document)", command.callbackId];
    } else {
        jsWrapper = @"(function(d) { var c = d.createElement('style'); c.innerHTML = %@; d.body.appendChild(c); })(document)";
    }
    [self injectDeferredObject:[command argumentAtIndex:0] withWrapper:jsWrapper];
}

- (void)injectStyleFile:(CDVInvokedUrlCommand*)command
{
    NSString* jsWrapper;
    
    if ((command.callbackId != nil) && ![command.callbackId isEqualToString:@"INVALID"]) {
        jsWrapper = [NSString stringWithFormat:@"(function(d) { var c = d.createElement('link'); c.rel='stylesheet'; c.type='text/css'; c.href = %%@; c.onload = function() { _cdvMessageHandler('%@'); }; d.body.appendChild(c); })(document)", command.callbackId];
    } else {
        jsWrapper = @"(function(d) { var c = d.createElement('link'); c.rel='stylesheet', c.type='text/css'; c.href = %@; d.body.appendChild(c); })(document)";
    }
    [self injectDeferredObject:[command argumentAtIndex:0] withWrapper:jsWrapper];
}

- (BOOL)isValidCallbackId:(NSString *)callbackId
{
    NSError *err = nil;
    // Initialize on first use
    if (self.callbackIdPattern == nil) {
        self.callbackIdPattern = [NSRegularExpression regularExpressionWithPattern:@"^InAppBrowserWKWebView[0-9]{1,10}$" options:0 error:&err];
        if (err != nil) {
            // Couldn't initialize Regex; No is safer than Yes.
            return NO;
        }
    }
    if ([self.callbackIdPattern firstMatchInString:callbackId options:0 range:NSMakeRange(0, [callbackId length])]) {
        return YES;
    }
    return NO;
}

/**
 * The message handler bridge provided for the InAppBrowserWKWebView is capable of executing any oustanding callback belonging
 * to the InAppBrowserWKWebView plugin. Care has been taken that other callbacks cannot be triggered, and that no
 * other code execution is possible.
 */
- (BOOL)webView:(WKWebView*)theWebView decidePolicyForNavigationAction:(NSURLRequest*)request
{
    NSURL* url = request.URL;
    BOOL isTopLevelNavigation = [request.URL isEqual:[request mainDocumentURL]];
    
    //if is an app store link, let the system handle it, otherwise it fails to load it
    if ([[ url scheme] isEqualToString:@"itms-appss"] || [[ url scheme] isEqualToString:@"itms-apps"]) {
        [theWebView stopLoading];
        [self openInSystem:url];
        return NO;
    }
    else if ((self.callbackId != nil) && isTopLevelNavigation) {
        // Send a loadstart event for each top-level navigation (includes redirects).
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK
                                                      messageAsDictionary:@{@"type":@"loadstart", @"url":[url absoluteString]}];
        [pluginResult setKeepCallback:[NSNumber numberWithBool:YES]];
        
        [self.commandDelegate sendPluginResult:pluginResult callbackId:self.callbackId];
    }
    
    return YES;
}

#pragma mark WKScriptMessageHandler delegate
- (void)userContentController:(nonnull WKUserContentController *)userContentController didReceiveScriptMessage:(nonnull WKScriptMessage *)message {
    
    CDVPluginResult* pluginResult = nil;
    
    NSDictionary* messageContent = (NSDictionary*) message.body;
    NSString* scriptCallbackId = messageContent[@"id"];
    
    if([messageContent objectForKey:@"d"]){
        NSString* scriptResult = messageContent[@"d"];
        NSError* __autoreleasing error = nil;
        NSData* decodedResult = [NSJSONSerialization JSONObjectWithData:[scriptResult dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
        if ((error == nil) && [decodedResult isKindOfClass:[NSArray class]]) {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsArray:(NSArray*)decodedResult];
        } else {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_JSON_EXCEPTION];
        }
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsArray:@[]];
    }
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:scriptCallbackId];
}

- (void)didStartProvisionalNavigation:(WKWebView*)theWebView
{
    _injectedIframeBridge = NO;
}

- (void)didFinishNavigation:(WKWebView*)theWebView
{
    if (self.callbackId != nil) {
        // TODO: It would be more useful to return the URL the page is actually on (e.g. if it's been redirected).
        NSString* url = [self.InAppBrowserWKWebViewViewController.currentURL absoluteString];
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK
                                                      messageAsDictionary:@{@"type":@"loadstop", @"url":url}];
        [pluginResult setKeepCallback:[NSNumber numberWithBool:YES]];
        
        [self.commandDelegate sendPluginResult:pluginResult callbackId:self.callbackId];
    }
}

- (void)webView:(WKWebView*)theWebView didFailNavigation:(NSError*)error
{
    if (self.callbackId != nil) {
        NSString* url = [self.InAppBrowserWKWebViewViewController.currentURL absoluteString];
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR
                                                      messageAsDictionary:@{@"type":@"loaderror", @"url":url, @"code": [NSNumber numberWithInteger:error.code], @"message": error.localizedDescription}];
        [pluginResult setKeepCallback:[NSNumber numberWithBool:YES]];
        
        [self.commandDelegate sendPluginResult:pluginResult callbackId:self.callbackId];
    }
}

- (void)browserExit
{
    if (self.callbackId != nil) {
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK
                                                      messageAsDictionary:@{@"type":@"exit"}];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:self.callbackId];
        self.callbackId = nil;
    }
    
    [self.InAppBrowserWKWebViewViewController.configuration.userContentController removeScriptMessageHandlerForName:IAB_BRIDGE_NAME];
    self.InAppBrowserWKWebViewViewController.configuration = nil;
    
    [self.InAppBrowserWKWebViewViewController.webView stopLoading];
    [self.InAppBrowserWKWebViewViewController.webView removeFromSuperview];
    [self.InAppBrowserWKWebViewViewController.webView setUIDelegate:nil];
    [self.InAppBrowserWKWebViewViewController.webView setNavigationDelegate:nil];
    self.InAppBrowserWKWebViewViewController.webView = nil;
    
    // Set navigationDelegate to nil to ensure no callbacks are received from it.
    self.InAppBrowserWKWebViewViewController.navigationDelegate = nil;
    self.InAppBrowserWKWebViewViewController = nil;
    
    if (IsAtLeastiOSVersion(@"7.0")) {
        if (_previousStatusBarStyle != -1) {
            [[UIApplication sharedApplication] setStatusBarStyle:_previousStatusBarStyle];
            
        }
    }
    
    _previousStatusBarStyle = -1; // this value was reset before reapplying it. caused statusbar to stay black on ios7
}

@end

#pragma mark CDVInAppBrowserWKWebViewViewController

@implementation CDVInAppBrowserWKWebViewViewController

@synthesize currentURL;

BOOL viewRenderedAtLeastOnce = FALSE;
BOOL isExiting = FALSE;

- (id)initWithUserAgent:(NSString*)userAgent prevUserAgent:(NSString*)prevUserAgent browserOptions: (CDVInAppBrowserWKWebViewOptions*) browserOptions
{
    self = [super init];
    if (self != nil) {
        _userAgent = userAgent;
        _prevUserAgent = prevUserAgent;
        _browserOptions = browserOptions;
        self.webViewUIDelegate = [[CDVInAppBrowserWKWebViewUIDelegate alloc] initWithTitle:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"]];
        [self.webViewUIDelegate setViewController:self];

        [self createViews];
    }
    
    return self;
}

-(void)dealloc {
    //NSLog(@"dealloc");
}

-(NSString *) getCookiesAsStringforWKWebView:(NSHTTPCookie *) cookie{
    return [NSString stringWithFormat:@"%@=%@",[cookie name], [cookie value]];
}

- (void)createViews
{
    // We create the views in code for primarily for ease of upgrades and not requiring an external .xib to be included

    CGRect webViewBounds = self.view.bounds;
    BOOL toolbarIsAtBottom = ![_browserOptions.toolbarposition isEqualToString:kInAppBrowserWKWebViewToolbarBarPositionTop];
    webViewBounds.size.height -= _browserOptions.location ? FOOTER_HEIGHT : TOOLBAR_HEIGHT;
    WKUserContentController* userContentController = [[WKUserContentController alloc] init];
    
    //Code to Get Cookie from the NSHTTPCookieStorage, set by UIWebView
    NSMutableString *script = [[NSMutableString alloc] init];
    for (NSHTTPCookie *cookie in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]) {
        [script appendString:[NSString stringWithFormat:@"document.cookie='%@';",[self getCookiesAsStringforWKWebView:cookie]]];
    }
    NSLog(@"Cookies: %@", script);
    WKUserScript * cookieScript = [[WKUserScript alloc]
                                   initWithSource: script
                                   injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
    [userContentController addUserScript:cookieScript];
    
    [userContentController addScriptMessageHandler:self name:@"gotoUIWebView"];
    [userContentController addScriptMessageHandler:self name:jsMessageName];
    
    WKWebViewConfiguration* configuration = [[WKWebViewConfiguration alloc] init];
    configuration.userContentController = userContentController;
    //configuration.processPool = [[CDVWKProcessPoolFactory sharedFactory] sharedProcessPool];
    [configuration.userContentController addScriptMessageHandler:self name:IAB_BRIDGE_NAME];
    
    self.webView = [[WKWebView alloc] initWithFrame:webViewBounds configuration:configuration];


    [self.view addSubview:self.webView];
    [self.view sendSubviewToBack:self.webView];

    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self.webViewUIDelegate;
    self.webView.backgroundColor = [UIColor whiteColor];

    self.webView.clearsContextBeforeDrawing = YES;
    self.webView.clipsToBounds = YES;
    self.webView.contentMode = UIViewContentModeScaleToFill;
    self.webView.multipleTouchEnabled = YES;
    self.webView.opaque = YES;
    self.webView.userInteractionEnabled = YES;
    self.automaticallyAdjustsScrollViewInsets = YES;
    [self.webView setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
    self.webView.allowsLinkPreview = NO;
    self.webView.allowsBackForwardNavigationGestures = NO;

//    self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//    [self.spinner setColor:[UIColor grayColor]];
//    self.spinner.alpha = 1.000;
//    self.spinner.autoresizesSubviews = YES;
//    self.spinner.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
//    self.spinner.clearsContextBeforeDrawing = NO;
//    self.spinner.clipsToBounds = NO;
//    self.spinner.contentMode = UIViewContentModeScaleToFill;
//    self.spinner.frame = CGRectMake(self.view.frame.size.width / 2 - 10, self.view.frame.size.height / 2 - 10, 20, 20);
//    self.spinner.hidden = NO;
//    self.spinner.hidesWhenStopped = YES;
//    self.spinner.multipleTouchEnabled = NO;
//    self.spinner.opaque = NO;
//    self.spinner.userInteractionEnabled = NO;
//    [self.spinner stopAnimating];

    self.closeButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(close)];
    self.closeButton.enabled = YES;
    

    UIBarButtonItem* flexibleSpaceButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];

    UIBarButtonItem* fixedSpaceButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedSpaceButton.width = 20;


    float toolbarY = toolbarIsAtBottom ? self.view.bounds.size.height - TOOLBAR_HEIGHT : 0.0;
    CGRect toolbarFrame = CGRectMake(0.0, toolbarY, self.view.bounds.size.width, TOOLBAR_HEIGHT);

    self.toolbar = [[UIToolbar alloc] initWithFrame:toolbarFrame];
    self.toolbar.alpha = 1.000;
    self.toolbar.autoresizesSubviews = YES;
    self.toolbar.autoresizingMask = toolbarIsAtBottom ? (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin) : UIViewAutoresizingFlexibleWidth;
    self.toolbar.barStyle = UIBarStyleBlackOpaque;
    self.toolbar.clearsContextBeforeDrawing = NO;
    self.toolbar.clipsToBounds = NO;
    self.toolbar.contentMode = UIViewContentModeScaleToFill;
    self.toolbar.hidden = NO;
    self.toolbar.multipleTouchEnabled = NO;
    self.toolbar.opaque = NO;
    self.toolbar.userInteractionEnabled = YES;

    CGFloat labelInset = 5.0;
    float locationBarY = toolbarIsAtBottom ? self.view.bounds.size.height - FOOTER_HEIGHT : self.view.bounds.size.height - LOCATIONBAR_HEIGHT;

    self.addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelInset, locationBarY, self.view.bounds.size.width - labelInset, LOCATIONBAR_HEIGHT)];
    self.addressLabel.adjustsFontSizeToFitWidth = NO;
    self.addressLabel.alpha = 1.000;
    self.addressLabel.autoresizesSubviews = YES;
    self.addressLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    self.addressLabel.backgroundColor = [UIColor clearColor];
    self.addressLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    self.addressLabel.clearsContextBeforeDrawing = YES;
    self.addressLabel.clipsToBounds = YES;
    self.addressLabel.contentMode = UIViewContentModeScaleToFill;
    self.addressLabel.enabled = YES;
    self.addressLabel.hidden = NO;
    self.addressLabel.lineBreakMode = NSLineBreakByTruncatingTail;

    if ([self.addressLabel respondsToSelector:NSSelectorFromString(@"setMinimumScaleFactor:")]) {
        [self.addressLabel setValue:@(10.0/[UIFont labelFontSize]) forKey:@"minimumScaleFactor"];
    } else if ([self.addressLabel respondsToSelector:NSSelectorFromString(@"setMinimumFontSize:")]) {
        [self.addressLabel setValue:@(10.0) forKey:@"minimumFontSize"];
    }

    self.addressLabel.multipleTouchEnabled = NO;
    self.addressLabel.numberOfLines = 1;
    self.addressLabel.opaque = NO;
    self.addressLabel.shadowOffset = CGSizeMake(0.0, -1.0);
    self.addressLabel.text = NSLocalizedString(@"Loading...", nil);
    self.addressLabel.textAlignment = NSTextAlignmentLeft;
    self.addressLabel.textColor = [UIColor colorWithWhite:1.000 alpha:1.000];
    self.addressLabel.userInteractionEnabled = NO;

    NSString* frontArrowString = NSLocalizedString(@"►", nil); // create arrow from Unicode char
    self.forwardButton = [[UIBarButtonItem alloc] initWithTitle:frontArrowString style:UIBarButtonItemStylePlain target:self action:@selector(goForward:)];
    self.forwardButton.enabled = YES;
    self.forwardButton.imageInsets = UIEdgeInsetsZero;

    NSString* backArrowString = NSLocalizedString(@"◄", nil); // create arrow from Unicode char
    self.backButton = [[UIBarButtonItem alloc] initWithTitle:backArrowString style:UIBarButtonItemStylePlain target:self action:@selector(goBack:)];
    self.backButton.enabled = YES;
    self.backButton.imageInsets = UIEdgeInsetsZero;

    [self.toolbar setItems:@[self.closeButton, flexibleSpaceButton, self.backButton, fixedSpaceButton, self.forwardButton]];

    self.view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.toolbar];
    [self.view addSubview:self.addressLabel];
    //[self.view addSubview:self.spinner];
}


- (void) setWebViewFrame : (CGRect) frame {
    NSLog(@"Setting the WebView's frame to %@", NSStringFromCGRect(frame));
    [self.webView setFrame:frame];
}

- (void)setCloseButtonTitle:(NSString*)title
{
    // the advantage of using UIBarButtonSystemItemDone is the system will localize it for you automatically
    // but, if you want to set this yourself, knock yourself out (we can't set the title for a system Done button, so we have to create a new one)
    self.closeButton = nil;
    self.closeButton = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(close)];
    self.closeButton.enabled = YES;
    self.closeButton.tintColor = [UIColor colorWithRed:60.0 / 255.0 green:136.0 / 255.0 blue:230.0 / 255.0 alpha:1];
    
    NSMutableArray* items = [self.toolbar.items mutableCopy];
    [items replaceObjectAtIndex:0 withObject:self.closeButton];
    [self.toolbar setItems:items];
}

- (void)showLocationBar:(BOOL)show
{
    CGRect locationbarFrame = self.addressLabel.frame;

    BOOL toolbarVisible = !self.toolbar.hidden;

    // prevent double show/hide
    if (show == !(self.addressLabel.hidden)) {
        return;
    }

    if (show) {
        self.addressLabel.hidden = NO;

        if (toolbarVisible) {
            // toolBar at the bottom, leave as is
            // put locationBar on top of the toolBar

            CGRect webViewBounds = self.view.bounds;
            webViewBounds.size.height -= FOOTER_HEIGHT;
            [self setWebViewFrame:webViewBounds];

            locationbarFrame.origin.y = webViewBounds.size.height;
            self.addressLabel.frame = locationbarFrame;
        } else {
            // no toolBar, so put locationBar at the bottom

            CGRect webViewBounds = self.view.bounds;
            webViewBounds.size.height -= LOCATIONBAR_HEIGHT;
            [self setWebViewFrame:webViewBounds];

            locationbarFrame.origin.y = webViewBounds.size.height;
            self.addressLabel.frame = locationbarFrame;
        }
    } else {
        self.addressLabel.hidden = YES;

        if (toolbarVisible) {
            // locationBar is on top of toolBar, hide locationBar

            // webView take up whole height less toolBar height
            CGRect webViewBounds = self.view.bounds;
            webViewBounds.size.height -= TOOLBAR_HEIGHT;
            [self setWebViewFrame:webViewBounds];
        } else {
            // no toolBar, expand webView to screen dimensions
            [self setWebViewFrame:self.view.bounds];
        }
    }
}

- (void)showToolBar:(BOOL)show : (NSString *) toolbarPosition
{
    CGRect toolbarFrame = self.toolbar.frame;
    CGRect locationbarFrame = self.addressLabel.frame;

    BOOL locationbarVisible = !self.addressLabel.hidden;

    // prevent double show/hide
    if (show == !(self.toolbar.hidden)) {
        return;
    }

    if (show) {
        self.toolbar.hidden = NO;
        CGRect webViewBounds = self.view.bounds;

        if (locationbarVisible) {
            // locationBar at the bottom, move locationBar up
            // put toolBar at the bottom
            webViewBounds.size.height -= FOOTER_HEIGHT;
            locationbarFrame.origin.y = webViewBounds.size.height;
            self.addressLabel.frame = locationbarFrame;
            self.toolbar.frame = toolbarFrame;
        } else {
            // no locationBar, so put toolBar at the bottom
            CGRect webViewBounds = self.view.bounds;
            webViewBounds.size.height -= TOOLBAR_HEIGHT;
            self.toolbar.frame = toolbarFrame;
        }

        if ([toolbarPosition isEqualToString:kInAppBrowserWKWebViewToolbarBarPositionTop]) {
            toolbarFrame.origin.y = 0;
            webViewBounds.origin.y += toolbarFrame.size.height;
            [self setWebViewFrame:webViewBounds];
        } else {
            toolbarFrame.origin.y = (webViewBounds.size.height + LOCATIONBAR_HEIGHT);
        }
        [self setWebViewFrame:webViewBounds];

    } else {
        self.toolbar.hidden = YES;

        if (locationbarVisible) {
            // locationBar is on top of toolBar, hide toolBar
            // put locationBar at the bottom

            // webView take up whole height less locationBar height
            CGRect webViewBounds = self.view.bounds;
            webViewBounds.size.height -= LOCATIONBAR_HEIGHT;
            [self setWebViewFrame:webViewBounds];

            // move locationBar down
            locationbarFrame.origin.y = webViewBounds.size.height;
            self.addressLabel.frame = locationbarFrame;
        } else {
            // no locationBar, expand webView to screen dimensions
            [self setWebViewFrame:self.view.bounds];
        }
    }
}

- (void)viewDidLoad
{
    viewRenderedAtLeastOnce = FALSE;
    [super viewDidLoad];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    if (isExiting && (self.navigationDelegate != nil) && [self.navigationDelegate respondsToSelector:@selector(browserExit)]) {
        [self.navigationDelegate browserExit];
        isExiting = FALSE;
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (void)close
{
    [CDVUserAgentUtil releaseLock:&_userAgentLockToken];
    self.currentURL = nil;
    
    __weak UIViewController* weakSelf = self;
    
    // Run later to avoid the "took a long time" log message.
    dispatch_async(dispatch_get_main_queue(), ^{
        isExiting = TRUE;
        if ([weakSelf respondsToSelector:@selector(presentingViewController)]) {
            [[weakSelf presentingViewController] dismissViewControllerAnimated:YES completion:nil];
        } else {
            [[weakSelf parentViewController] dismissViewControllerAnimated:YES completion:nil];
        }
    });

}


- (void)navigateTo:(NSURL*)url
{
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
    NSMutableString *script = [[NSMutableString alloc] init];
    for (NSHTTPCookie *cookie in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]) {
        [script appendString:[NSString stringWithFormat:@"%@;",[self getCookiesAsStringforWKWebView:cookie]]];
    }
    [request addValue:script forHTTPHeaderField:@"Cookie"];
    
    if (_userAgentLockToken != 0) {
        [self.webView loadRequest:request];
    } else {
        __weak CDVInAppBrowserWKWebViewViewController* weakSelf = self;
        [CDVUserAgentUtil acquireLock:^(NSInteger lockToken) {
            _userAgentLockToken = lockToken;
            [CDVUserAgentUtil setUserAgent:_userAgent lockToken:lockToken];
            [weakSelf.webView loadRequest:request];
        }];
    }
}

- (void)goBack:(id)sender
{
    [self.webView goBack];
}

- (void)goForward:(id)sender
{
    [self.webView goForward];
}

- (void)viewWillAppear:(BOOL)animated
{
    if (IsAtLeastiOSVersion(@"7.0") && !viewRenderedAtLeastOnce) {
        viewRenderedAtLeastOnce = TRUE;
        CGRect viewBounds = [self.webView bounds];
        viewBounds.origin.y = STATUSBAR_HEIGHT;
        viewBounds.size.height = viewBounds.size.height - STATUSBAR_HEIGHT;
        self.webView.frame = viewBounds;
        [[UIApplication sharedApplication] setStatusBarStyle:[self preferredStatusBarStyle]];
    }
    [self rePositionViews];
    
    [super viewWillAppear:animated];
}

//
// On iOS 7 the status bar is part of the view's dimensions, therefore it's height has to be taken into account.
// The height of it could be hardcoded as 20 pixels, but that would assume that the upcoming releases of iOS won't
// change that value.
//
- (float) getStatusBarOffset {
    CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
    float statusBarOffset = IsAtLeastiOSVersion(@"7.0") ? MIN(statusBarFrame.size.width, statusBarFrame.size.height) : 0.0;
    return statusBarOffset;
}

- (void) rePositionViews {
    if ([_browserOptions.toolbarposition isEqualToString:kInAppBrowserWKWebViewToolbarBarPositionTop]) {
        [self.webView setFrame:CGRectMake(self.webView.frame.origin.x, TOOLBAR_HEIGHT, self.webView.frame.size.width, self.webView.frame.size.height)];
        [self.toolbar setFrame:CGRectMake(self.toolbar.frame.origin.x, [self getStatusBarOffset], self.toolbar.frame.size.width, self.toolbar.frame.size.height)];
    }
}

#pragma mark WKNavigationDelegate

- (void)webView:(WKWebView *)theWebView didStartProvisionalNavigation:(WKNavigation *)navigation{
    
    // loading url, start spinner, update back/forward
    
    self.addressLabel.text = NSLocalizedString(@"Loading...", nil);
    self.backButton.enabled = theWebView.canGoBack;
    self.forwardButton.enabled = theWebView.canGoForward;
    
    //[self.spinner startAnimating];
    
    return [self.navigationDelegate didStartProvisionalNavigation:theWebView];
}

- (void)webView:(WKWebView *)theWebView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    NSURL *url = navigationAction.request.URL;
    NSURL *mainDocumentURL = navigationAction.request.mainDocumentURL;
    
    BOOL isTopLevelNavigation = [url isEqual:mainDocumentURL];
    
    if (isTopLevelNavigation) {
        self.currentURL = url;
    }
    
    [self.navigationDelegate webView:theWebView decidePolicyForNavigationAction:navigationAction.request];
    
    decisionHandler(WKNavigationActionPolicyAllow);
    
}

- (void)webView:(WKWebView *)theWebView didFinishNavigation:(WKNavigation *)navigation
{
    if(canNvigateToUIWeb){
        canNvigateToUIWeb = NO;
        return;
    }
    // update url, stop spinner, update back/forward
    self.addressLabel.text = [self.currentURL absoluteString];
    self.backButton.enabled = theWebView.canGoBack;
    self.forwardButton.enabled = theWebView.canGoForward;
    theWebView.scrollView.contentInset = UIEdgeInsetsZero;
    
    //[self.spinner stopAnimating];
    
    // Work around a bug where the first time a PDF is opened, all UIWebViews
    // reload their User-Agent from NSUserDefaults.
    // This work-around makes the following assumptions:
    // 1. The app has only a single Cordova Webview. If not, then the app should
    //    take it upon themselves to load a PDF in the background as a part of
    //    their start-up flow.
    // 2. That the PDF does not require any additional network requests. We change
    //    the user-agent here back to that of the CDVViewController, so requests
    //    from it must pass through its white-list. This *does* break PDFs that
    //    contain links to other remote PDF/websites.
    // More info at https://issues.apache.org/jira/browse/CB-2225
    BOOL isPDF = NO;
    //TODO webview class
    //BOOL isPDF = [@"true" isEqualToString :[theWebView evaluateJavaScript:@"document.body==null"]];
    if (isPDF) {
        [CDVUserAgentUtil setUserAgent:_prevUserAgent lockToken:_userAgentLockToken];
    }
    
    [self.navigationDelegate didFinishNavigation:theWebView];
}

- (void)webView:(WKWebView*)theWebView failedNavigation:(NSString*) delegateName withError:(nonnull NSError *)error{
    // log fail message, stop spinner, update back/forward
    NSLog(@"webView:%@ - %ld: %@", delegateName, (long)error.code, [error localizedDescription]);
    
    self.backButton.enabled = theWebView.canGoBack;
    self.forwardButton.enabled = theWebView.canGoForward;
    //[self.spinner stopAnimating];
    
    self.addressLabel.text = NSLocalizedString(@"Load Error", nil);
    
    [self.navigationDelegate webView:theWebView didFailNavigation:error];
}

- (void)webView:(WKWebView*)theWebView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(nonnull NSError *)error
{
    [self webView:theWebView failedNavigation:@"didFailNavigation" withError:error];
}

- (void)webView:(WKWebView*)theWebView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(nonnull NSError *)error
{
    [self webView:theWebView failedNavigation:@"didFailProvisionalNavigation" withError:error];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showMessage:[error localizedDescription]];
    });
}

/////////////////////////----TODO:MAY REMOVE THIS METHOD----//////////////////////////
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *credential))completionHandler {
    NSLog(@"Allow all");
    SecTrustRef serverTrust = challenge.protectionSpace.serverTrust;
    CFDataRef exceptions = SecTrustCopyExceptions (serverTrust);
    SecTrustSetExceptions (serverTrust, exceptions);
    CFRelease (exceptions);
    completionHandler (NSURLSessionAuthChallengeUseCredential, [NSURLCredential credentialForTrust:serverTrust]);
}
//////////////////////////////////////----END----//////////////////////////////////////

//An alert box to show error messages
-(void)showMessage:(NSString*)message
{
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:[Utils localizedStringForKey:@"alert_title"]
                                  message:message
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:[Utils localizedStringForKey:@"ok"] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        //closing the WKWebView
        [self close];
    }];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark WKScriptMessageHandler delegate
- (void)userContentController:(nonnull WKUserContentController *)userContentController didReceiveScriptMessage:(nonnull WKScriptMessage *)message {
    if([message.name isEqualToString:@"gotoUIWebView"]){
        canNvigateToUIWeb = YES;
        
        AppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
        CDVViewController* topview = appDelegate.viewController;
        NSURL* appurl = [NSURL URLWithString:url];
        NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:appurl];
        NSMutableString *script = [[NSMutableString alloc] init];
        for (NSHTTPCookie *cookie in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]) {
            [script appendString:[NSString stringWithFormat:@"%@;",[self getCookiesAsStringforWKWebView:cookie]]];
        }
        [request addValue:script forHTTPHeaderField:@"Cookie"];
        [(UIWebView *)topview.webViewEngine reload];
        [self close];
        return;
    }
    
    if([message.name isEqualToString:jsMessageName]){
        NSString *urlString = message.body;
        NSURL *app2appUrl = [NSURL URLWithString:urlString];
        [[UIApplication sharedApplication]  openURL:app2appUrl];
        return;
    }
    
    if (![message.name isEqualToString:IAB_BRIDGE_NAME]) {
        return;
    }
    //NSLog(@"Received script message %@", message.body);
    [self.navigationDelegate userContentController:userContentController didReceiveScriptMessage:message];
}


#pragma mark CDVScreenOrientationDelegate

- (BOOL)shouldAutorotate
{
    if ((self.orientationDelegate != nil) && [self.orientationDelegate respondsToSelector:@selector(shouldAutorotate)]) {
        return [self.orientationDelegate shouldAutorotate];
    }
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    if ((self.orientationDelegate != nil) && [self.orientationDelegate respondsToSelector:@selector(supportedInterfaceOrientations)]) {
        return [self.orientationDelegate supportedInterfaceOrientations];
    }
    
    return 1 << UIInterfaceOrientationPortrait;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ((self.orientationDelegate != nil) && [self.orientationDelegate respondsToSelector:@selector(shouldAutorotateToInterfaceOrientation:)]) {
        return [self.orientationDelegate shouldAutorotateToInterfaceOrientation:interfaceOrientation];
    }
    
    return YES;
}

@end

@implementation CDVInAppBrowserWKWebViewOptions

- (id)init
{
    if (self = [super init]) {
        // default values
        self.location = YES;
        self.toolbar = YES;
        self.closebuttoncaption = nil;
        self.toolbarposition = kInAppBrowserWKWebViewToolbarBarPositionBottom;
        self.clearcache = NO;
        self.clearsessioncache = NO;
        
        self.enableviewportscale = NO;
        self.mediaplaybackrequiresuseraction = NO;
        self.allowinlinemediaplayback = NO;
        self.keyboarddisplayrequiresuseraction = YES;
        self.suppressesincrementalrendering = NO;
        self.hidden = NO;
        self.disallowoverscroll = NO;
    }
    
    return self;
}

+ (CDVInAppBrowserWKWebViewOptions*)parseOptions:(NSString*)options
{
    CDVInAppBrowserWKWebViewOptions* obj = [[CDVInAppBrowserWKWebViewOptions alloc] init];
    
    // NOTE: this parsing does not handle quotes within values
    NSArray* pairs = [options componentsSeparatedByString:@","];
    
    // parse keys and values, set the properties
    for (NSString* pair in pairs) {
        NSArray* keyvalue = [pair componentsSeparatedByString:@"="];
        
        if ([keyvalue count] == 2) {
            NSString* key = [[keyvalue objectAtIndex:0] lowercaseString];
            NSString* value = [keyvalue objectAtIndex:1];
            NSString* value_lc = [value lowercaseString];
            
            BOOL isBoolean = [value_lc isEqualToString:@"yes"] || [value_lc isEqualToString:@"no"];
            NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
            [numberFormatter setAllowsFloats:YES];
            BOOL isNumber = [numberFormatter numberFromString:value_lc] != nil;
            
            // set the property according to the key name
            if ([obj respondsToSelector:NSSelectorFromString(key)]) {
                if (isNumber) {
                    [obj setValue:[numberFormatter numberFromString:value_lc] forKey:key];
                } else if (isBoolean) {
                    [obj setValue:[NSNumber numberWithBool:[value_lc isEqualToString:@"yes"]] forKey:key];
                } else {
                    [obj setValue:value forKey:key];
                }
            }
        }
    }
    
    return obj;
}

@end

@implementation CDVInAppBrowserWKWebViewNavigationController : UINavigationController

- (void) dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion {
    if ( self.presentedViewController) {
        [super dismissViewControllerAnimated:flag completion:completion];
    }
}

- (void) viewDidLoad {

    CGRect statusBarFrame = [self invertFrameIfNeeded:[UIApplication sharedApplication].statusBarFrame];
    statusBarFrame.size.height = STATUSBAR_HEIGHT;
    // simplified from: http://stackoverflow.com/a/25669695/219684
    
    UIToolbar* bgToolbar = [[UIToolbar alloc] initWithFrame:statusBarFrame];
    bgToolbar.barStyle = UIBarStyleDefault;
    [bgToolbar setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [self.view addSubview:bgToolbar];
    
    [super viewDidLoad];
}

- (CGRect) invertFrameIfNeeded:(CGRect)rect {
    // We need to invert since on iOS 7 frames are always in Portrait context
    if (!IsAtLeastiOSVersion(@"8.0")) {
        if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])) {
            CGFloat temp = rect.size.width;
            rect.size.width = rect.size.height;
            rect.size.height = temp;
        }
        rect.origin = CGPointZero;
    }
    return rect;
}


#pragma mark CDVScreenOrientationDelegate

- (BOOL)shouldAutorotate
{
    if ((self.orientationDelegate != nil) && [self.orientationDelegate respondsToSelector:@selector(shouldAutorotate)]) {
        return [self.orientationDelegate shouldAutorotate];
    }
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    if ((self.orientationDelegate != nil) && [self.orientationDelegate respondsToSelector:@selector(supportedInterfaceOrientations)]) {
        return [self.orientationDelegate supportedInterfaceOrientations];
    }
    
    return 1 << UIInterfaceOrientationPortrait;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ((self.orientationDelegate != nil) && [self.orientationDelegate respondsToSelector:@selector(shouldAutorotateToInterfaceOrientation:)]) {
        return [self.orientationDelegate shouldAutorotateToInterfaceOrientation:interfaceOrientation];
    }
    
    return YES;
}


@end

