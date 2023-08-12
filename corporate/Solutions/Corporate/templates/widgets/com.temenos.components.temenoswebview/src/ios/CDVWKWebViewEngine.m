/*
 Licensed to the Apache Software Foundation (ASF) under one
 or more contributor license agreements.  See the NOTICE file
 distributed with this work for additional information
 regarding copyright ownership.  The ASF licenses this file
 to you under the Apache License, Version 2.0 (the
 "License"); you may not use this file except in compliance
 with the License.  You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing,
 software distributed under the License is distributed on an
 "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 KIND, either express or implied.  See the License for the
 specific language governing permissions and limitations
 under the License.
 */

#import "CDVWKWebViewEngine.h"
#import "CDVWKWebViewUIDelegate.h"
#import "CDVWKProcessPoolFactory.h"
#import <Cordova/NSDictionary+CordovaPreferences.h>

#import "CustomURLProtocol.h"
#import "AutoDismissAlertView.h"
#import "JBDetect.h"
#import "Utils.h"
#import "PromptAlertView.h"
#import "DeviceInfo.h"
#import <Cordova/CDVUserAgentUtil.h>
#import <Cordova/CDVUIWebViewEngine.h>
#import <objc/message.h>

#define CDV_BRIDGE_NAME @"cordova"
#define CDV_WKWEBVIEW_FILE_URL_LOAD_SELECTOR @"loadFileURL:allowingReadAccessToURL:"

#define wkAppStoreAlertTag       10011
#define wkServerUpdateAlertTag   10012
#define wkSettingsAlertTag       10013
#define wkEditUrlAlertTag        10014
#define wkOfflineAlertTag        10015
#define wkSslAlertTag            10016
#define wkServerErrorAlertTag    10017
#define wkUpdateOkAlertTag       10018

NSString * const wkProgressAlertViewControllerIdentifier = @"APLProgressAlertViewController";
NSString * const wkDefaultErrorPage = @"error.html";
NSString * const wkDefaultJailbreakErrorPage = @"jberror.html";
NSString * const wkDefaultiTunesLink = @"https://itunes.apple.com";

@interface CDVWKWeakScriptMessageHandler : NSObject <WKScriptMessageHandler>

@property (nonatomic, weak, readonly) id<WKScriptMessageHandler>scriptMessageHandler;

- (instancetype)initWithScriptMessageHandler:(id<WKScriptMessageHandler>)scriptMessageHandler;

@end


@interface CDVWKWebViewEngine ()

@property (nonatomic, strong, readwrite) UIView* engineWebView;
@property (nonatomic, strong, readwrite) id <WKUIDelegate> uiDelegate;
@property (nonatomic, weak) id <WKScriptMessageHandler> weakScriptMessageHandler;

@end

// see forwardingTargetForSelector: selector comment for the reason for this pragma
#pragma clang diagnostic ignored "-Wprotocol"

@implementation CDVWKWebViewEngine

@synthesize applicationUrl;
@synthesize updateUrl;
@synthesize applicationVersion;
@synthesize developmentMode;
@synthesize initCheckedforUpdates;
@synthesize jailbreakDetection;
@synthesize localeAlias;
@synthesize pageKey;
@synthesize pageVal;
@synthesize onlineMode;
@synthesize currentUrl;
@synthesize cookies;
@synthesize htmlOfflinePage;
@synthesize sslErrorPage;
@synthesize jailbreakErrorPage;
@synthesize forceUpdateErrorPage;
@synthesize updateStatus;
@synthesize iTunesLink;
@synthesize pushNotifications;
@synthesize dynamicTheme;

@synthesize engineWebView = _engineWebView;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super init];
    if (self) {
        if (NSClassFromString(@"WKWebView") == nil) {
            return nil;
        }
        
        [self loadConfig];
        self.initCheckedforUpdates = YES;

        self.engineWebView = [[WKWebView alloc] initWithFrame:frame];
        
        self.onlineMode = YES;
        if ( ![Utils connectedToNetwork] )
        {
            self.onlineMode = NO;
            self.initCheckedforUpdates = NO;
        }
    }

    return self;
}

-(void) loadConfig{
    NSString *filePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"hybridConfig.plist"];
    NSDictionary* plistDictionary = [[NSDictionary alloc] initWithContentsOfFile:filePath];
    self.developmentMode = [[plistDictionary objectForKey:@"developmentMode"] boolValue];
    self.jailbreakDetection = [[plistDictionary objectForKey:@"jailbreakDetection"] boolValue];
    self.applicationUrl = [plistDictionary objectForKey:@"serverUrl"];
    self.updateUrl = [plistDictionary objectForKey:@"updateUrl"];
    self.htmlOfflinePage = [plistDictionary objectForKey:@"htmlOfflinePage"];
    if ( !self.htmlOfflinePage )
        self.htmlOfflinePage = wkDefaultErrorPage;
    self.sslErrorPage = [plistDictionary objectForKey:@"sslErrorPage"];
    if ( !self.sslErrorPage )
        self.sslErrorPage = wkDefaultErrorPage;
    self.jailbreakErrorPage = [plistDictionary objectForKey:@"jailbreakErrorPage"];
    if ( !self.jailbreakErrorPage )
        self.sslErrorPage = wkDefaultJailbreakErrorPage;
    
    self.forceUpdateErrorPage = [plistDictionary objectForKey:@"forceUpdateErrorPage"];
    
    
    self.iTunesLink = [plistDictionary objectForKey:@"iTunesLink"];
    if ( !self.iTunesLink )
        self.iTunesLink = wkDefaultiTunesLink;
    
    //Push notifications switch
    self.pushNotifications = [plistDictionary objectForKey:@"pushNotifications"];
    
    //Application version
    self.applicationVersion = [Utils settingsApplicationVersion];
    
    
    // App locale
    self.localeAlias = [Utils applicationLocaleAlias];
    
    //Developer mode
    
    // Get the user defined server URL from the setting bundle
    NSString *serverUrl = [Utils settingsServerUrl];
    if ( serverUrl )
        self.applicationUrl = serverUrl;
    
    //self.startPage = @"index-hybrid.html";
    
    // Add GET parameters to the server url
    //self.applicationUrl = self.startPage;
    //self.startPage = [self getAppURLWithLanguageParameter];
    
    // Get the user defined update server URL from the setting bundle
    NSString *updateServerUrl = [Utils settingsUpdateServerUrl];
    if ( updateServerUrl )
        self.updateUrl = updateServerUrl;
    
    self.pageKey = @"";
    self.pageVal = @"";
    
}


- (WKWebViewConfiguration*) createConfigurationFromSettings:(NSDictionary*)settings
{
    WKWebViewConfiguration* configuration = [[WKWebViewConfiguration alloc] init];
    configuration.processPool = [[CDVWKProcessPoolFactory sharedFactory] sharedProcessPool];
    if (settings == nil) {
        return configuration;
    }

    configuration.allowsInlineMediaPlayback = [settings cordovaBoolSettingForKey:@"AllowInlineMediaPlayback" defaultValue:NO];
    configuration.mediaPlaybackRequiresUserAction = [settings cordovaBoolSettingForKey:@"MediaPlaybackRequiresUserAction" defaultValue:YES];
    configuration.suppressesIncrementalRendering = [settings cordovaBoolSettingForKey:@"SuppressesIncrementalRendering" defaultValue:NO];
    configuration.mediaPlaybackAllowsAirPlay = [settings cordovaBoolSettingForKey:@"MediaPlaybackAllowsAirPlay" defaultValue:YES];
    return configuration;
}

- (void)pluginInitialize
{
    // viewController would be available now. we attempt to set all possible delegates to it, by default
    NSDictionary* settings = self.commandDelegate.settings;

    self.uiDelegate = [[CDVWKWebViewUIDelegate alloc] initWithTitle:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"]];

    CDVWKWeakScriptMessageHandler *weakScriptMessageHandler = [[CDVWKWeakScriptMessageHandler alloc] initWithScriptMessageHandler:self];

    WKUserContentController* userContentController = [[WKUserContentController alloc] init];
    [userContentController addScriptMessageHandler:weakScriptMessageHandler name:CDV_BRIDGE_NAME];

    WKWebViewConfiguration* configuration = [self createConfigurationFromSettings:settings];
    configuration.userContentController = userContentController;

    // re-create WKWebView, since we need to update configuration
    WKWebView* wkWebView = [[WKWebView alloc] initWithFrame:self.engineWebView.frame configuration:configuration];
    wkWebView.UIDelegate = self.uiDelegate;
    self.engineWebView = wkWebView;

    if (IsAtLeastiOSVersion(@"9.0") && [self.viewController isKindOfClass:[CDVViewController class]]) {
        wkWebView.customUserAgent = ((CDVViewController*) self.viewController).userAgent;
    }

    if ([self.viewController conformsToProtocol:@protocol(WKUIDelegate)]) {
        wkWebView.UIDelegate = (id <WKUIDelegate>)self.viewController;
    }

    if ([self.viewController conformsToProtocol:@protocol(WKNavigationDelegate)]) {
        wkWebView.navigationDelegate = (id <WKNavigationDelegate>)self.viewController;
    } else {
        wkWebView.navigationDelegate = (id <WKNavigationDelegate>)self;
    }

    if ([self.viewController conformsToProtocol:@protocol(WKScriptMessageHandler)]) {
        [wkWebView.configuration.userContentController addScriptMessageHandler:(id < WKScriptMessageHandler >)self.viewController name:CDV_BRIDGE_NAME];
    }

    [self updateSettings:settings];

    // check if content thread has died on resume
    NSLog(@"%@", @"CDVWKWebViewEngine will reload WKWebView if required on resume");
    [[NSNotificationCenter defaultCenter]
        addObserver:self
           selector:@selector(onAppWillEnterForeground:)
               name:UIApplicationWillEnterForegroundNotification object:nil];

    NSLog(@"Using WKWebView");

    [self addURLObserver];
}

- (void)onReset {
    [self addURLObserver];
}

static void * KVOContext = &KVOContext;

- (void)addURLObserver {
    if(!IsAtLeastiOSVersion(@"9.0")){
        [self.webView addObserver:self forKeyPath:@"URL" options:0 context:KVOContext];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if (context == KVOContext) {
        if (object == [self webView] && [keyPath isEqualToString: @"URL"] && [object valueForKeyPath:keyPath] == nil){
            NSLog(@"URL is nil. Reloading WKWebView");
            [(WKWebView*)_engineWebView reload];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void) onAppWillEnterForeground:(NSNotification*)notification {
    if ([self shouldReloadWebView]) {
        NSLog(@"%@", @"CDVWKWebViewEngine reloading!");
        [(WKWebView*)_engineWebView reload];
    }
}

- (BOOL)shouldReloadWebView
{
    WKWebView* wkWebView = (WKWebView*)_engineWebView;
    return [self shouldReloadWebView:wkWebView.URL title:wkWebView.title];
}

- (BOOL)shouldReloadWebView:(NSURL*)location title:(NSString*)title
{
    BOOL title_is_nil = (title == nil);
    BOOL location_is_blank = [[location absoluteString] isEqualToString:@"about:blank"];

    BOOL reload = (title_is_nil || location_is_blank);

#ifdef DEBUG
    NSLog(@"%@", @"CDVWKWebViewEngine shouldReloadWebView::");
    NSLog(@"CDVWKWebViewEngine shouldReloadWebView title: %@", title);
    NSLog(@"CDVWKWebViewEngine shouldReloadWebView location: %@", [location absoluteString]);
    NSLog(@"CDVWKWebViewEngine shouldReloadWebView reload: %u", reload);
#endif

    return reload;
}


- (id)loadRequest:(NSURLRequest*)request
{
    if ([self canLoadRequest:request]) { // can load, differentiate between file urls and other schemes
        if (request.URL.fileURL) {
            SEL wk_sel = NSSelectorFromString(CDV_WKWEBVIEW_FILE_URL_LOAD_SELECTOR);
            NSURL* readAccessUrl = [request.URL URLByDeletingLastPathComponent];
            return ((id (*)(id, SEL, id, id))objc_msgSend)(_engineWebView, wk_sel, request.URL, readAccessUrl);
        } else {
            return [(WKWebView*)_engineWebView loadRequest:request];
        }
    } else { // can't load, print out error
        NSString* errorHtml = [NSString stringWithFormat:
                               @"<!doctype html>"
                               @"<title>Error</title>"
                               @"<div style='font-size:2em'>"
                               @"   <p>The WebView engine '%@' is unable to load the request: %@</p>"
                               @"   <p>Most likely the cause of the error is that the loading of file urls is not supported in iOS %@.</p>"
                               @"</div>",
                               NSStringFromClass([self class]),
                               [request.URL description],
                               [[UIDevice currentDevice] systemVersion]
                               ];
        return [self loadHTMLString:errorHtml baseURL:nil];
    }
}

- (id)loadHTMLString:(NSString*)string baseURL:(NSURL*)baseURL
{
    return [(WKWebView*)_engineWebView loadHTMLString:string baseURL:baseURL];
}

- (NSURL*) URL
{
    return [(WKWebView*)_engineWebView URL];
}

- (BOOL) canLoadRequest:(NSURLRequest*)request
{
    // See: https://issues.apache.org/jira/browse/CB-9636
    SEL wk_sel = NSSelectorFromString(CDV_WKWEBVIEW_FILE_URL_LOAD_SELECTOR);

    // if it's a file URL, check whether WKWebView has the selector (which is in iOS 9 and up only)
    if (request.URL.fileURL) {
        return [_engineWebView respondsToSelector:wk_sel];
    } else {
        return YES;
    }
}

- (void)updateSettings:(NSDictionary*)settings
{
    WKWebView* wkWebView = (WKWebView*)_engineWebView;

    wkWebView.configuration.preferences.minimumFontSize = [settings cordovaFloatSettingForKey:@"MinimumFontSize" defaultValue:0.0];

    /*
     wkWebView.configuration.preferences.javaScriptEnabled = [settings cordovaBoolSettingForKey:@"JavaScriptEnabled" default:YES];
     wkWebView.configuration.preferences.javaScriptCanOpenWindowsAutomatically = [settings cordovaBoolSettingForKey:@"JavaScriptCanOpenWindowsAutomatically" default:NO];
     */

    // By default, DisallowOverscroll is false (thus bounce is allowed)
    BOOL bounceAllowed = !([settings cordovaBoolSettingForKey:@"DisallowOverscroll" defaultValue:NO]);

    // prevent webView from bouncing
    if (!bounceAllowed) {
        if ([wkWebView respondsToSelector:@selector(scrollView)]) {
            ((UIScrollView*)[wkWebView scrollView]).bounces = NO;
        } else {
            for (id subview in wkWebView.subviews) {
                if ([[subview class] isSubclassOfClass:[UIScrollView class]]) {
                    ((UIScrollView*)subview).bounces = NO;
                }
            }
        }
    }

    NSString* decelerationSetting = [settings cordovaSettingForKey:@"WKWebViewDecelerationSpeed"];
    if (!decelerationSetting) {
        // Fallback to the UIWebView-named preference
        decelerationSetting = [settings cordovaSettingForKey:@"UIWebViewDecelerationSpeed"];
    }

    if (![@"fast" isEqualToString:decelerationSetting]) {
        [wkWebView.scrollView setDecelerationRate:UIScrollViewDecelerationRateNormal];
    } else {
        [wkWebView.scrollView setDecelerationRate:UIScrollViewDecelerationRateFast];
    }

    wkWebView.allowsBackForwardNavigationGestures = [settings cordovaBoolSettingForKey:@"AllowBackForwardNavigationGestures" defaultValue:NO];
}

- (void)updateWithInfo:(NSDictionary*)info
{
    NSDictionary* scriptMessageHandlers = [info objectForKey:kCDVWebViewEngineScriptMessageHandlers];
    NSDictionary* settings = [info objectForKey:kCDVWebViewEngineWebViewPreferences];
    id navigationDelegate = [info objectForKey:kCDVWebViewEngineWKNavigationDelegate];
    id uiDelegate = [info objectForKey:kCDVWebViewEngineWKUIDelegate];

    WKWebView* wkWebView = (WKWebView*)_engineWebView;

    if (scriptMessageHandlers && [scriptMessageHandlers isKindOfClass:[NSDictionary class]]) {
        NSArray* allKeys = [scriptMessageHandlers allKeys];

        for (NSString* key in allKeys) {
            id object = [scriptMessageHandlers objectForKey:key];
            if ([object conformsToProtocol:@protocol(WKScriptMessageHandler)]) {
                [wkWebView.configuration.userContentController addScriptMessageHandler:object name:key];
            }
        }
    }

    if (navigationDelegate && [navigationDelegate conformsToProtocol:@protocol(WKNavigationDelegate)]) {
        wkWebView.navigationDelegate = navigationDelegate;
    }

    if (uiDelegate && [uiDelegate conformsToProtocol:@protocol(WKUIDelegate)]) {
        wkWebView.UIDelegate = uiDelegate;
    }

    if (settings && [settings isKindOfClass:[NSDictionary class]]) {
        [self updateSettings:settings];
    }
}

// This forwards the methods that are in the header that are not implemented here.
// Both WKWebView and UIWebView implement the below:
//     loadHTMLString:baseURL:
//     loadRequest:
- (id)forwardingTargetForSelector:(SEL)aSelector
{
    return _engineWebView;
}

- (UIView*)webView
{
    return self.engineWebView;
}

#pragma mark WKScriptMessageHandler implementation

- (void)userContentController:(WKUserContentController*)userContentController didReceiveScriptMessage:(WKScriptMessage*)message
{
    if (![message.name isEqualToString:CDV_BRIDGE_NAME]) {
        return;
    }

    CDVViewController* vc = (CDVViewController*)self.viewController;

    NSArray* jsonEntry = message.body; // NSString:callbackId, NSString:service, NSString:action, NSArray:args
    CDVInvokedUrlCommand* command = [CDVInvokedUrlCommand commandFromJson:jsonEntry];
    CDV_EXEC_LOG(@"Exec(%@): Calling %@.%@", command.callbackId, command.className, command.methodName);

    if (![vc.commandQueue execute:command]) {
#ifdef DEBUG
        NSError* error = nil;
        NSString* commandJson = nil;
        NSData* jsonData = [NSJSONSerialization dataWithJSONObject:jsonEntry
                                                           options:0
                                                             error:&error];

        if (error == nil) {
            commandJson = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        }

            static NSUInteger maxLogLength = 1024;
            NSString* commandString = ([commandJson length] > maxLogLength) ?
                [NSString stringWithFormat : @"%@[...]", [commandJson substringToIndex:maxLogLength]] :
                commandJson;

            NSLog(@"FAILED pluginJSON = %@", commandString);
#endif
    }
}

#pragma mark WKNavigationDelegate implementation

- (void)webView:(WKWebView*)webView didStartProvisionalNavigation:(WKNavigation*)navigation
{
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:CDVPluginResetNotification object:webView]];
}

- (void)webView:(WKWebView*)webView didFinishNavigation:(WKNavigation*)navigation
{
    CDVViewController* vc = (CDVViewController*)self.viewController;
    [CDVUserAgentUtil releaseLock:vc.userAgentLockToken];

    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:CDVPageDidLoadNotification object:webView]];
    
    ////////---------------------------------------------------/////////////////
    
    //Check the http status
    NSURLRequest *req = [NSURLRequest requestWithURL:webView.URL];
    NSCachedURLResponse *resp = [[NSURLCache sharedURLCache] cachedResponseForRequest:req];
    if ( [(NSHTTPURLResponse*)resp.response statusCode] >= 400 )
    {
        [self serverError];
        return;
    }
    
    NSLog(@"Url test: %@", webView.URL.absoluteString);
    
    //    if ( !self.onlineMode && ( [webView.URL.absoluteString hasPrefix:@"http:"] ||
    //                              [webView.URL.absoluteString hasPrefix:@"https:"] ) )
    //        self.onlineMode = YES;
    
    BOOL isIndexHybridHtml = [[webView.URL absoluteString] hasSuffix:@"index-hybrid.html"];
    
    if ( self.onlineMode)
    {
        if(!self.initCheckedforUpdates)
        {
            self.initCheckedforUpdates = YES;
            [self serverSync:NO];
            if (self.developmentMode)
            {
                //Check for updates
                BOOL checkForUpdates = [Utils settingsCheckForUpdates];
                if ( checkForUpdates )
                    [self checkForUpdates];
            }
            return;
        }
        // Get the dynamic theme
        NSString *stringDynamicTheme = [self stringByEvaluatingJavaScriptFromString:@"getVarsForHybrid();"];
        NSError *jsonParsingError = nil;
        NSDictionary *jsonDynamicTheme = [NSJSONSerialization JSONObjectWithData:[stringDynamicTheme dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&jsonParsingError];
        if ( !jsonParsingError )
            self.dynamicTheme = [jsonDynamicTheme valueForKey:@"currentTheme"];
        
        
        // Invoke getRefreshInfo(), and store the PAGE_KEY and PAGE_VAL
        NSString *stringParameters = [self stringByEvaluatingJavaScriptFromString:@"getRefreshInfo();"];
        
        //If not an edgeConnect page, go offline
        if ( !isIndexHybridHtml && (!stringParameters || !stringParameters.length) )
        {
            [self serverError];
            return;
        }
        
        NSDictionary *jsonParameters = [NSJSONSerialization JSONObjectWithData:[stringParameters dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&jsonParsingError];
        
        //Save the cookies
        NSLog(@"url for saving: %@", self.currentUrl);
        self.cookies = [[ NSHTTPCookieStorage sharedHTTPCookieStorage ] cookiesForURL: self.currentUrl ];
        NSString *pagekey = [jsonParameters valueForKey:@"pagekey"];
        if ( pagekey && pagekey.length )
            self.pageKey = pagekey;
        NSString *pageval = [jsonParameters valueForKey:@"pageval"];
        if ( pageval && pageval.length )
            self.pageVal = pageval;
        
    }
    else
    {
        // invoke the javascript function setRefreshInfo, which sets the form’s action (destURL) and the PAGE_KEY/PAGE_VAL on the form.
        NSString *jsRefreshInfo = [ NSString stringWithFormat:@"setRefreshInfo('%@', '%@', '%@');", self.applicationUrl, self.pageKey, self.pageVal ];
        [self stringByEvaluatingJavaScriptFromString:jsRefreshInfo];
        
        NSString *jsChangeBaseInfo = [ NSString stringWithFormat:@"wrapCallToAjaxButtonAction('%@/');", [self.applicationUrl stringByDeletingLastPathComponent]];
        [self stringByEvaluatingJavaScriptFromString:jsChangeBaseInfo];
        // Set the saved cookies for the offline mode
        //NSArray *cook =  self.cookies;
        [[ NSHTTPCookieStorage sharedHTTPCookieStorage ] setCookies:self.cookies forURL:self.currentUrl mainDocumentURL:nil];
    }
    
    
    if (isIndexHybridHtml) {
        NSString *setHybridURLoCall = [NSString stringWithFormat:@"loadHybridApp('%@', '%@', '%@');", self.applicationUrl, self.localeAlias, self.pushNotifications ];
        [self stringByEvaluatingJavaScriptFromString:setHybridURLoCall];
    }
    else
    {
        NSString *jsHasDeviceInfo = [ NSString stringWithFormat:@"hasDeviceInfo();" ];
        NSString *hasDeviceInfoString = [self stringByEvaluatingJavaScriptFromString:jsHasDeviceInfo];
        BOOL hasDeviceInfo = [hasDeviceInfoString boolValue];
        if (!hasDeviceInfo)
        {
            DeviceInfo *deviceInfo = [[DeviceInfo alloc] init];
            NSString *deviceInfoString = [deviceInfo getDeviceInfo];
            NSString *jsSetDeviceInfo = [ NSString stringWithFormat:@"setDeviceInfoInForm('%@');", deviceInfoString];
            [self stringByEvaluatingJavaScriptFromString:jsSetDeviceInfo];
            
        }
    }
    
    // Black base color for background matches the native apps
    webView.backgroundColor = [UIColor blackColor];
    
    //return [super webViewDidFinishLoad:theWebView];
    ////////---------------------------------------------------////////////////
}

- (void) checkForUpdates
{
    //Reset the current server version and perform a server sync
    //[[NSUserDefaults standardUserDefaults] removeObjectForKey:@""];
    [self serverSync:YES];
    [[NSUserDefaults standardUserDefaults] setValue:NO forKey:@"check_for_updates"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)serverSync:(BOOL)forcedUpdate {
    
    
    //Check web resources version: request:http://10.140.5.123:8282/lc/mobileUpdate?clientVersion=x
    //
    NSString *versionUrl = [NSString stringWithFormat:@"%@?clientVersion=%@", self.updateUrl, self.applicationVersion];
    NSURLRequest *requestVersion = [NSURLRequest requestWithURL:[NSURL URLWithString:versionUrl]];
    [NSURLConnection sendAsynchronousRequest:requestVersion
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
                               [self fetchResponse:data withError:error forcedUpdate:forcedUpdate];
                           }
     ];
}

- (void) fetchResponse:(NSData *)data withError:(NSError *)error forcedUpdate:(BOOL)forcedUpdate {
    if ( error ) {
        //Display the error alert
        AutoDismissAlertView *alertView = [[AutoDismissAlertView alloc] initWithTitle:[Utils localizedStringForKey:@"update_result_error"]
                                                                              message:[Utils localizedStringForKey:@"update_result_processing_error"]
                                                                             delegate:self
                                                                    cancelButtonTitle:[Utils localizedStringForKey:@"ok" ]
                                                                    otherButtonTitles: nil];
        [alertView show];
        NSLog(@"Error connecting to the server: %@", error.localizedDescription);
        return;
    }
    //Put the response in json format
    
    NSError *jsonParsingError = nil;
    
    NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonParsingError];
    
    if (jsonParsingError) {
        //Display the error alert
        AutoDismissAlertView *alertView = [[AutoDismissAlertView alloc] initWithTitle:[Utils localizedStringForKey:@"update_result_unknown_error"]
                                                                              message:error.localizedDescription
                                                                             delegate:self
                                                                    cancelButtonTitle:[Utils localizedStringForKey:@"ok" ]
                                                                    otherButtonTitles: nil];
        [alertView show];
        NSLog(@"Json parsing error: %@", jsonParsingError.localizedDescription);
        return;
    }
    //Just keeping the reference for force update
    self.updateStatus = [jsonResponse objectForKey:@"status"];
    
    NSString *status = [jsonResponse objectForKey:@"status"];
    NSString *message = [jsonResponse objectForKey:@"message"];
    
    //Evaluate the status
    BOOL forceUpdate = [self isForceUpdate];
    if ( [status isEqualToString:@"major_update"] && forceUpdate)
    {
        [self loadForeUpdateErrorPage];
        AutoDismissAlertView *alertView = [[AutoDismissAlertView alloc] initWithTitle:@""
                                                                              message:[Utils localizedStringForKey:@"update_result_major_update"]
                                                                             delegate:self
                                                                    cancelButtonTitle:nil
                                                                    otherButtonTitles:[Utils localizedStringForKey:@"ok"], [Utils localizedStringForKey:@"not_now"], nil];
        alertView.tag = wkAppStoreAlertTag;
        //[alertView show];
        [alertView showAutoDismissAlertView:NO];
        return;
    }
    
    if ( [status isEqualToString:@"major_update"] )
    {
        AutoDismissAlertView *alertView = [[AutoDismissAlertView alloc] initWithTitle:@""
                                                                              message:[Utils localizedStringForKey:@"update_result_major_update"]
                                                                             delegate:self
                                                                    cancelButtonTitle:nil
                                                                    otherButtonTitles:[Utils localizedStringForKey:@"ok"], [Utils localizedStringForKey:@"not_now"], nil];
        alertView.tag = wkAppStoreAlertTag;
        //[alertView show];
        [alertView showAutoDismissAlertView:NO];
        return;
    }
    
    if ( [status isEqualToString:@"error"] )
    {
        //Display the error alert
        AutoDismissAlertView *alertView = [[AutoDismissAlertView alloc] initWithTitle:[Utils localizedStringForKey:@"update_result_unknown_error"]
                                                                              message:message
                                                                             delegate:self
                                                                    cancelButtonTitle:[Utils localizedStringForKey:@"ok" ]
                                                                    otherButtonTitles: nil];
        //[alertView show];
        [alertView showAutoDismissAlertView:NO];
        NSLog(@"Server error: %@", message);
        return;
    }
    
    if ( [status isEqualToString:@"update"] )
    {
        AutoDismissAlertView *alertView = [[AutoDismissAlertView alloc] initWithTitle:[Utils localizedStringForKey:@""]
                                                                              message:[Utils localizedStringForKey:@"update_download_updates_now"]
                                                                             delegate:self
                                                                    cancelButtonTitle:[Utils localizedStringForKey:@"ok"]
                                                                    otherButtonTitles:[Utils localizedStringForKey:@"not_now"], nil];
        alertView.tag = wkServerUpdateAlertTag;
        alertView.userContent = jsonResponse;
        //[alertView show];
        [alertView showAutoDismissAlertView:NO];
        return;
    }
    
    if ( [status isEqualToString:@"ok"] && forcedUpdate )
    {
        AutoDismissAlertView *alertView = [[AutoDismissAlertView alloc] initWithTitle:[Utils localizedStringForKey:@""]
                                                                              message:[Utils localizedStringForKey:@"update_result_uptodate"]
                                                                             delegate:self
                                                                    cancelButtonTitle:[Utils localizedStringForKey:@"ok"]
                                                                    otherButtonTitles:nil];
        alertView.userContent = jsonResponse;
        //[alertView show];
        [alertView showAutoDismissAlertView:NO];
        return;
    }
    
}

- (NSString *)stringByEvaluatingJavaScriptFromString:(NSString *)script {
    __block NSString *resultString = @"";
    __block BOOL finished = NO;
    [(WKWebView *)self.webView evaluateJavaScript:script completionHandler:^(id result, NSError *error) {
        if (error == nil) {
            if (result != nil) {
                resultString = [NSString stringWithFormat:@"%@", result];
            }
        } else {
            NSLog(@"evaluateJavaScript error : %@", error.localizedDescription);
        }
        finished = YES;
    }];
    
    while (!finished)
    {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
    return resultString;
}

//--------------------------------------
// Privacy message alert view delegate
//______________________________________

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    // App Store redirect
    if ( alertView.tag == wkAppStoreAlertTag ) {
        if ( buttonIndex == 0 ) {
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.iTunesLink]];
        }
        return;
    }
    
    //    // Server resouces update
    //    if ( alertView.tag == wkServerUpdateAlertTag ) {
    //        if ( buttonIndex == 0 ) {
    //            AutoDismissAlertView *adAlertView = (AutoDismissAlertView *)alertView;
    //
    //            [self launchResourcesUpdate:adAlertView.userContent];
    //        }
    //        return;
    //    }
    
    // Reload due to the app Settings change TODO:// realoding in wk
    //    if ( alertView.tag == wkSettingsAlertTag ) {
    //        if ( buttonIndex == 0 ) {
    //            [self reloadWebPage];
    //        }
    //        return;
    //    }
    
    // Change the application url
    //    if ( alertView.tag == kEditUrlAlertTag ) {
    //        if ( buttonIndex == 0 ) {
    //            if ( SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0") )
    //                self.applicationUrl = [[alertView textFieldAtIndex:0].text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    //            else
    //                self.applicationUrl = [[(PromptAlertView *)alertView enteredText] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    //            [self reloadWebPage];
    //        }
    //        return;
    //    }
    
    if ( alertView.tag == wkOfflineAlertTag || alertView.tag == wkServerErrorAlertTag ) {
        if ( buttonIndex == 0 ) {
            // Load the local offline page
            [self loadOffLinePage];
        }
        return;
    }
    
    if ( alertView.tag == wkSslAlertTag ) {
        if ( buttonIndex == 0 ) {
            // Load the local offline page
            [self loadSslPage];
        }
        return;
    }
    
    //    if ( alertView.tag == wkUpdateOkAlertTag ) {
    //        [self copyWebRessources];
    //        [self reloadWebPage];
    //    }
}

- (void) serverError
{
    if ( self.onlineMode )
    {
        // Set the offline flag
        self.onlineMode = NO;
        
        AutoDismissAlertView *alertView = [[AutoDismissAlertView alloc] initWithTitle:[Utils localizedStringForKey:@"error_accessing_server_title"]
                                                                              message:[Utils localizedStringForKey:@"error_accessing_server_description"]
                                                                             delegate:self
                                                                    cancelButtonTitle:nil
                                                                    otherButtonTitles:[Utils localizedStringForKey:@"ok"], nil];
        alertView.tag = wkServerErrorAlertTag;
        [alertView show];
    }
    else
    {
        [self loadOffLinePage];
    }
    
}
- (void) loadOffLinePage
{
    NSString *filePath = [Utils localizedPathForFileResource:self.htmlOfflinePage withTheme:self.dynamicTheme];
    
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:filePath]];
    
    [(WKWebView*)_engineWebView loadRequest:requestObj];
}
- (void) sslError
{
    if ( self.onlineMode )
    {
        // Set the offline flag
        self.onlineMode = NO;
        
        AutoDismissAlertView *alertView = [[AutoDismissAlertView alloc] initWithTitle:[Utils localizedStringForKey:@"invalid_ssl_cert"]
                                                                              message:[Utils localizedStringForKey:@"invalid_ssl_cert_development"]
                                                                             delegate:self
                                                                    cancelButtonTitle:nil
                                                                    otherButtonTitles:[Utils localizedStringForKey:@"ok"], nil];
        alertView.tag = wkSslAlertTag;
        [alertView show];
    }
    else
    {
        [self loadSslPage];
    }
}
- (void) loadForeUpdateErrorPage
{
    NSString *filePath = [Utils localizedPathForFileResource:self.forceUpdateErrorPage withTheme:self.dynamicTheme];
    
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:filePath]];
    
    [(WKWebView*)_engineWebView loadRequest:requestObj];
}


- (void) loadSslPage
{
    NSString *filePath = [Utils localizedPathForFileResource:self.sslErrorPage withTheme:dynamicTheme];
    
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:filePath]];
    
    [(WKWebView*)_engineWebView loadRequest:requestObj];
}

- (BOOL) isForceUpdate
{
    return ![self.forceUpdateErrorPage isEqualToString:@""];
}
- (void) goOffline
{
    if ( self.onlineMode )
    {
        // Set the offline flag
        self.onlineMode = NO;
        
        AutoDismissAlertView *alertView = [[AutoDismissAlertView alloc] initWithTitle:[Utils localizedStringForKey:@"internet_connection_needed_title"]
                                                                              message:[Utils localizedStringForKey:@"internet_connection_needed"]
                                                                             delegate:self
                                                                    cancelButtonTitle:nil
                                                                    otherButtonTitles:[Utils localizedStringForKey:@"ok"], nil];
        alertView.tag = wkOfflineAlertTag;
        [alertView show];
    }
    else
    {
        [self loadOffLinePage];
    }
    
}


- (void)webView:(WKWebView*)theWebView didFailProvisionalNavigation:(WKNavigation*)navigation withError:(NSError*)error
{
    [self webView:theWebView didFailNavigation:navigation withError:error];
}

- (void)webView:(WKWebView*)theWebView didFailNavigation:(WKNavigation*)navigation withError:(NSError*)error
{
    CDVViewController* vc = (CDVViewController*)self.viewController;
    [CDVUserAgentUtil releaseLock:vc.userAgentLockToken];
    
    // Ignore rapid repeated clicking -999 error
    if ([error code] == NSURLErrorCancelled)
        return;
    
    // Check the network connectivity
    if ( ![Utils connectedToNetwork])
    {
        // Load the offline page
        [self goOffline];
    }
    else if ( [error code] <= -1200 && [error code] > -1300 )
    {
        //Present the optin to accept invalid ssl certificate in developemnt mode
        if ( self.developmentMode && [self.applicationUrl rangeOfString:@"://"].location != NSNotFound)
        {
            NSURLRequest *requestObj = [NSURLRequest requestWithURL:[NSURL URLWithString:self.applicationUrl]];
            connection = [NSURLConnection connectionWithRequest:requestObj delegate:self];
        }
        // Ssl error domain
        [self sslError];
    }
    else if ( [error code] <= -1005 && [error code] > -1010)
    {
        [self goOffline];
    }
    else
    {
        [self serverError];
    }

    /*NSString* message = [NSString stringWithFormat:@"Failed to load webpage with error: %@", [error localizedDescription]];
    NSLog(@"%@", message);

    NSURL* errorUrl = vc.errorURL;
    if (errorUrl) {
        errorUrl = [NSURL URLWithString:[NSString stringWithFormat:@"?error=%@", [message stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] relativeToURL:errorUrl];
        NSLog(@"%@", [errorUrl absoluteString]);
        [theWebView loadRequest:[NSURLRequest requestWithURL:errorUrl]];
    }*/
}

- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView
{
    [webView reload];
}

- (BOOL)defaultResourcePolicyForURL:(NSURL*)url
{
    // all file:// urls are allowed
    if ([url isFileURL]) {
        return YES;
    }

    return NO;
}

- (void) webView: (WKWebView *) webView decidePolicyForNavigationAction: (WKNavigationAction*) navigationAction decisionHandler: (void (^)(WKNavigationActionPolicy)) decisionHandler
{
    if ([Utils connectedToNetwork] ){
        self.onlineMode = YES;
    }
    else{
        self.onlineMode = NO;
    }
    self.currentUrl = [navigationAction.request URL];
    NSLog(@"url for saving inside decidePolicyForNavigationAction : %@", self.currentUrl);
    NSURL* url = [navigationAction.request URL];
    CDVViewController* vc = (CDVViewController*)self.viewController;

    /*
     * Give plugins the chance to handle the url
     */
    BOOL anyPluginsResponded = NO;
    BOOL shouldAllowRequest = NO;

    for (NSString* pluginName in vc.pluginObjects) {
        CDVPlugin* plugin = [vc.pluginObjects objectForKey:pluginName];
        SEL selector = NSSelectorFromString(@"shouldOverrideLoadWithRequest:navigationType:");
        if ([plugin respondsToSelector:selector]) {
            anyPluginsResponded = YES;
            // https://issues.apache.org/jira/browse/CB-12497
            int navType = (int)navigationAction.navigationType;
            if (WKNavigationTypeOther == navigationAction.navigationType) {
                navType = (int)UIWebViewNavigationTypeOther;
            }
            shouldAllowRequest = (((BOOL (*)(id, SEL, id, int))objc_msgSend)(plugin, selector, navigationAction.request, navType));
            if (!shouldAllowRequest) {
                break;
            }
        }
    }

    if (anyPluginsResponded) {
        return decisionHandler(shouldAllowRequest);
    }

    /*
     * Handle all other types of urls (tel:, sms:), and requests to load a url in the main webview.
     */
    BOOL shouldAllowNavigation = [self defaultResourcePolicyForURL:url];
    if (shouldAllowNavigation) {
        return decisionHandler(YES);
    } else {
        [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:CDVPluginHandleOpenURLNotification object:url]];
    }

    return decisionHandler(NO);
}

#pragma mark - Plugin interface

- (void)allowsBackForwardNavigationGestures:(CDVInvokedUrlCommand*)command;
{
    id value = [command argumentAtIndex:0];
    if (!([value isKindOfClass:[NSNumber class]])) {
        value = [NSNumber numberWithBool:NO];
    }

    WKWebView* wkWebView = (WKWebView*)_engineWebView;
    wkWebView.allowsBackForwardNavigationGestures = [value boolValue];
}

@end

#pragma mark - CDVWKWeakScriptMessageHandler

@implementation CDVWKWeakScriptMessageHandler

- (instancetype)initWithScriptMessageHandler:(id<WKScriptMessageHandler>)scriptMessageHandler
{
    self = [super init];
    if (self) {
        _scriptMessageHandler = scriptMessageHandler;
    }
    return self;
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    [self.scriptMessageHandler userContentController:userContentController didReceiveScriptMessage:message];
}

@end
