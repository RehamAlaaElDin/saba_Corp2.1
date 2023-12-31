/*
 * Copyright (c) TEMENOS HEADQUARTERS SA, All rights reserved.
 *
 * This source code is protected by copyright laws and international copyright treaties,
 * as well as other intellectual property laws and treaties.
 *  
 * Alteration, duplication or redistribution of this source code in any form 
 * is not permitted without the prior written authorisation of TEMENOS HEADQUARTERS SA.
 * 
 */

/*
 * THIS FILE IS AUTOMATICALLY UPDATED BY THE DEVELOPER IDE
 */

/** Places the device info retrieved from cordova.device on the request.
  * This can only be called on deviceready when the device information is available. */
function fetchDeviceInfo(p_formName)
{
	try {
		var form = document.forms[p_formName];
		if (form != null && form.DEVICE_INFO != null && device != null) {
			var deviceInfo = '{';
			deviceInfo += '"model":"' + device.model + '",';
			deviceInfo += '"platform":"' + device.platform + '",';
			deviceInfo += '"version":"' + device.version + '",';
			deviceInfo += '"cordova":"' + device.cordova + '",';
			deviceInfo += '"uuid":"' + device.uuid + '",';
			deviceInfo += '"manufacturer":"' + device.manufacturer + '",';
			deviceInfo += '"serial":"' + device.serial + '",';
			deviceInfo += '"isVirtual":"' + device.isVirtual + '",';
			deviceInfo += '"isHybrid":"Y",';
			deviceInfo += '"usePushNotifications":"' + localStorage.getItem("USE_PUSH_NOTIFICATIONS") + '"';
			deviceInfo += '}';
			form.DEVICE_INFO.value = deviceInfo;
		} else {
			console.log("Device is null!");
		}
	} catch (err)
	{
		console.log("Error setting device info in form. Error is: " + err.message)
	}
}
//notifies windows universal apps for calculating the device info (no cordova for universal apps)
function notifyUniversalAppsForDeviceInfo() {
	if (isWindowExternalNotifyDefined()) {
		window.external.notify("UNIVERSAL_APPS_DEVICE_INFO_NOTIFY");
	}
}
//Invoked from native for universal apps
function setWindowsUniversalAppsDeviceInfo(deviceInfoJsonString) {
	var deviceInfoObj;
    try {
        //this is for device info on plaftorms that do not support Cordova, such as Windows Universal Apps
         //var nonCordovaDeviceInfo = JSON.parse('{"firstname":"Jesper","surname":"Aaberg","phone":["555-0100","555-0120"]}');
        deviceInfoObj = JSON.parse(deviceInfoJsonString);
        if ((typeof deviceInfoObj.model === 'undefined')) 
        {
            if (!(typeof window.clientInformation.platform  === 'undefined')){
                deviceInfoObj.model = window.clientInformation.platform;    
            }
        }
        if ((typeof deviceInfoObj.platform === 'undefined')) {
            if (!(typeof window.clientInformation.userAgent  === 'undefined')){
                var userAgent = window.clientInformation.userAgent;
                var devicePlatform = userAgent.indexOf("MSAppHost/1.0") == -1 ? "windows" : "windows8";
                deviceInfoObj.platform = devicePlatform;
            }
        }
        window.device = deviceInfoObj;
        setDeviceInfoInForm(JSON.stringify(deviceInfoObj));
    } catch (err3) {
    	console.log("Error setting windows universal apps device info: " + err3.message );
    	setDeviceInfoInForm(deviceInfoObj?JSON.stringify(deviceInfoObj):deviceInfoJsonString);
    }
}

//Hides the splashscreen for the mobile platforms that use the splashscreen plugin
function hideSplashScreen()
{
  //once Cordova finished initialization phase, we can dismiss the splashscreen and submit the form.
  if (isWindowsPhone())
  {
    //No cordova splash screen for windows phone
    return;
  }

  if (navigator && navigator.splashscreen)
  {
    navigator.splashscreen.hide();
  }
  else
  {
    console.log("cordova splashscreen is not supported");
  }
}

//Intercepts the call to ecDoSubmit and passes in a modified "mode" arg 
function wrapCallToEcDoSubmit(overridenMode) 
{
	var originalEcDoSubmit = ecDoSubmit;
	ecDoSubmit = function () 
	{
		arguments[1] = overridenMode;
		originalEcDoSubmit.apply(this, arguments);
	};
}


//Put here any javascript variables that are needed for hybrid. This method is called
//by the hybrid shell after the page is loaded, for each page 
function getVarsForHybrid () {
	var varsForHybrid = {};
	var currentTheme = '';
	if (typeof(window.CURRENT_THEME) !== 'undefined' && window.CURRENT_THEME) {
		currentTheme = window.CURRENT_THEME;
	}
	varsForHybrid.currentTheme = currentTheme;
	return JSON.stringify(varsForHybrid);
}

//Checks if window.external.notify() is defined. This is used by the windows shell
function isWindowExternalNotifyDefined() {
	return (typeof(window.external) !=='undefined') && ('notify' in window.external);
}

//Goes offline - the hybrid app will display the configured offline phase
function hybridGoOffline() {
	if ((typeof(navigator) !=='undefined') && (typeof(navigator.goOffline) !=='undefined')) 
	{            
		navigator.goOffline.goOffline();
	} else 
	{
		if (isWindowExternalNotifyDefined()) {
			window.external.notify("UNIVERSAL_APPS_GO_OFFLINE");
		} else {
			console.log("no navigator.goOffline");
		}
	}
}

// test for the presence of a network connection
function hybridIsOnline()
{
    var isOnline = window.navigator && window.navigator.onLine;
    if (isOnline && navigator && navigator.connection && (typeof navigator.connection.type) !== 'undefined')
    {
        isOnline = navigator.connection.type !== Connection.NONE;
    }
    return isOnline;
}

//adds AJAX offline by wrapping the afterAjaxPOSTRequest hook
(function () {
	var addAJAXOfflineDetection = function() 
    {
        var hookIsDefined = (typeof afterAjaxPOSTRequest == 'function');
		var originalAfterAjaxPOSTRequest =  hookIsDefined ? afterAjaxPOSTRequest : null ; 
        
	    afterAjaxPOSTRequest = function (async, req, ajaxCaller, ns, uid) 
        {
            if (hookIsDefined)
            {
                originalAfterAjaxPOSTRequest.apply(this, arguments);            
            }
            if (async)
            {
                var offline = (req.readyState == 4) && (req.status == 0); 
                if (offline)  
                {
                  hybridGoOffline();
                }
            }
        };
    };
    document.addEventListener("deviceready", addAJAXOfflineDetection, false);
})();

//adds full-submit offline by wrapping the beforeSubmit hook
(function () {
    var addSubmitOfflineDetection = function() 
    {
        var hookIsDefined = (typeof beforeSubmit == 'function');
        var originalBeforeSubmit =  hookIsDefined ? beforeSubmit : null ; 

        // the beforeSubmit hook returns true when the form can be submitted, false otherwise
        beforeSubmit = function (ns, p_mode, p_scrollToButton, p_id) 
        {
            var proceed = true;
            if (hookIsDefined)
            {
                proceed = originalBeforeSubmit.apply(this, arguments);
            }
            // in case a developer redefined beforeSubmit without returning a variable, we assume it is non-blocking
            if (typeof proceed !== 'undefined' && !proceed)
            {
                // the existing hook rejected the form data, no need to test the connectivity
                return false;
            }
            // the original hook allowed the form submit, now test the connectivity
            if (hybridIsOnline())
            {
                return true;
            }

            // no connection, go offline. Alternative implementation: show an alert and return false (no navigation to offline)
            // alert('It looks like you are offline. Please check your internet connection and press the button again');
            hybridGoOffline();

            return false;
        };
    };
    document.addEventListener("deviceready", addSubmitOfflineDetection, false);
})();
