<script type="text/javascript" src="html/js/connect.js"></script>
<script type="text/javascript" src="html/js/cordova/cordova_loader.js"></script>
<script type="text/javascript" src="html/js/connect_hybrid.js"></script>
	
<script type = "text/javascript" charset="utf-8">
	window.addEventListener('load', function() { loadOrelyContent("startLuxTrustAuthBranding.html")});
	
	var ltwebview = null;
	
	function loadOrelyContent(authUrl){
		var cordovaDefined = false;
		var platform = "$$DEVICE_INFO.platform$";
		var isIOS = typeof platform === 'string' && platform.toUpperCase() == "IOS";
		var isAndroid = typeof platform === 'string' && platform.toUpperCase() == "ANDROID";
		try {
			cordovaDefined = !(typeof cordova === 'undefined') ;
		} catch (err) { 
			//Cordova is probably not present, so we're in a desktop browser. No need to do anything here.
		}
		if (cordovaDefined){
			if(isIOS) {
				var refreshInfoJson = JSON.parse(getRefreshInfo());
				var jPageKey = refreshInfoJson["pagekey"];
				var jPageVal = refreshInfoJson["pageval"];
				
				document.addEventListener("deviceready", function(){
						var ref = cordova.InAppBrowserWKWebView.open(authUrl, '_blank', 'location=no');
						ref.addEventListener('exit', function(event) { goToNextPhase(); });
					},false);
				return;
			} else if(isAndroid) {
				//There is nothing to do here.
			}
		}
		document.getElementById('orelyIframe').src = "startLuxtTrustAuth.html";
	}
	
	function goToNextPhase(){
		document.getElementById ("C1__C1__BUT_B9F69A79ABF01F661667").onclick();
	}
	
</script>

<iframe id="orelyIframe" src="about:blank" width="100%" height="380" frameborder="0">
</iframe>
