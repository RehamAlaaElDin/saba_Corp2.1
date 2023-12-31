
(function() {
    // special patch to correctly work on Ripple emulator (CB-9760)
    if (window.parent && !!window.parent.ripple) { 
        module.exports = window.open.bind(window); 
        return;
    }

               
var exec = require('cordova/exec');
var channel = require('cordova/channel');
var modulemapper = require('cordova/modulemapper');
var urlutil = require('cordova/urlutil');

function InAppBrowserWKWebView() {
   this.channels = {
        'loadstart': channel.create('loadstart'),
        'loadstop' : channel.create('loadstop'),
        'loaderror' : channel.create('loaderror'),
        'exit' : channel.create('exit')
   };
}

InAppBrowserWKWebView.prototype = {
    _eventHandler: function (event) {
        if (event && (event.type in this.channels)) {
            this.channels[event.type].fire(event);
        }
    },
    close: function (eventname) {
        exec(null, null, "InAppBrowserWKWebView", "close", []);
    },
    show: function (eventname) {
      exec(null, null, "InAppBrowserWKWebView", "show", []);
    },
    addEventListener: function (eventname,f) {
        if (eventname in this.channels) {
            this.channels[eventname].subscribe(f);
        }
    },
    removeEventListener: function(eventname, f) {
        if (eventname in this.channels) {
            this.channels[eventname].unsubscribe(f);
        }
    },

    executeScript: function(injectDetails, cb) {
        if (injectDetails.code) {
            exec(cb, null, "InAppBrowserWKWebView", "injectScriptCode", [injectDetails.code, !!cb]);
        } else if (injectDetails.file) {
            exec(cb, null, "InAppBrowserWKWebView", "injectScriptFile", [injectDetails.file, !!cb]);
        } else {
            throw new Error('executeScript requires exactly one of code or file to be specified');
        }
    },

    insertCSS: function(injectDetails, cb) {
        if (injectDetails.code) {
            exec(cb, null, "InAppBrowserWKWebView", "injectStyleCode", [injectDetails.code, !!cb]);
        } else if (injectDetails.file) {
            exec(cb, null, "InAppBrowserWKWebView", "injectStyleFile", [injectDetails.file, !!cb]);
        } else {
            throw new Error('insertCSS requires exactly one of code or file to be specified');
        }
    }
};

module.exports = function(strUrl, strWindowName, strWindowFeatures, fileExtensions, callbacks) {
    // Don't catch calls that write to existing frames (e.g. named iframes).
    if (window.frames && window.frames[strWindowName]) {
        var origOpenFunc = modulemapper.getOriginalSymbol(window, 'open');
        return origOpenFunc.apply(window, arguments);
    }

    strUrl = urlutil.makeAbsolute(strUrl);
    var iab = new InAppBrowserWKWebView();

    callbacks = callbacks || {};
    for (var callbackName in callbacks) {
        iab.addEventListener(callbackName, callbacks[callbackName]);
    }

    var cb = function(eventname) {
       iab._eventHandler(eventname);
    };

    strWindowFeatures = strWindowFeatures || "";
    fileExtensions = fileExtensions || "";

    exec(cb, cb, "InAppBrowserWKWebView", "open", [strUrl, strWindowName, strWindowFeatures,fileExtensions]);
    return iab;
};


})();
