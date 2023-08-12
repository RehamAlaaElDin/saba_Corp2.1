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

#import <WebKit/WebKit.h>
#import <Cordova/CDV.h>
#import "APLProgressAlertViewController.h"

@interface CDVWKWebViewEngine : CDVPlugin <CDVWebViewEngineProtocol, WKScriptMessageHandler, WKNavigationDelegate>
{
    NSURLConnection             *connection;
    //ChallengeHandler            *currentChallenge;
    NSString                    *applicationUrl;
}
@property (nonatomic, strong, readonly) id <WKUIDelegate> uiDelegate;

- (void)allowsBackForwardNavigationGestures:(CDVInvokedUrlCommand*)command;

- (void) goOffline;

@property (strong, nonatomic) UIWindow *alertWindow;
@property (strong, nonatomic) APLProgressAlertViewController *alertViewController;

@property (nonatomic, readwrite, copy) NSString* applicationUrl;
@property (nonatomic, readwrite, copy) NSString* updateUrl;
@property (nonatomic, readwrite, copy) NSString* applicationVersion;
@property (nonatomic, readwrite, copy) NSString* htmlOfflinePage;
@property (nonatomic, readwrite, copy) NSString* sslErrorPage;
@property (nonatomic, readwrite, copy) NSString* jailbreakErrorPage;
@property (nonatomic, readwrite, copy) NSString* forceUpdateErrorPage;
@property (nonatomic, readwrite, copy) NSString* updateStatus;
@property (nonatomic, readwrite) BOOL initCheckedforUpdates;
@property (nonatomic, readwrite) BOOL developmentMode;
@property (nonatomic, readwrite) BOOL jailbreakDetection;
@property (nonatomic, readwrite, copy) NSString *localeAlias;
@property (nonatomic, readwrite, copy) NSString* iTunesLink;
@property (nonatomic, readwrite, copy) NSString* pushNotifications;

@property (nonatomic, readwrite, copy) NSString* dynamicTheme;

// Web form variables
@property (nonatomic, readwrite, copy) NSString *pageKey;
@property (nonatomic, readwrite, copy) NSString *pageVal;

@property (nonatomic, readwrite) BOOL onlineMode;

@property (nonatomic, readwrite, copy) NSURL *currentUrl;
@property (nonatomic, readwrite, copy) NSArray *cookies;


@end
