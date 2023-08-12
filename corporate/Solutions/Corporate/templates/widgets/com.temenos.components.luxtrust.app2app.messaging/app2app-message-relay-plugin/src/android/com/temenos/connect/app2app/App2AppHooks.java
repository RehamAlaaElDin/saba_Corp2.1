package com.temenos.connect.app2app;

import android.content.Intent;
import android.net.Uri;
import android.util.Log;
import android.webkit.JavascriptInterface;
import android.widget.Toast;
import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CordovaWebView;
import org.apache.cordova.engine.SystemWebViewEngine;

/**
 * Allows the interaction between this Cordova app using this plugin and the LuxTrust Android app along with an iFrame which loads content form the LuxTrust Orely server.
 * <br><br>
 * On initialisation, a javascript interface is added to the webView to allow the Orely-provided content loaded within the iFrame to launch an external app with a generated URL <br>
 * Launches the LuxTrust native app using a provided URL<br>
 * Allows for the LuxTrust native app to send a message to this Cordova app and provides a way to pass it to the Orely iFrame 
 * 
 * @author hpopescu 
 */
public class App2AppHooks extends CordovaPlugin {

    @Override
    public void onNewIntent(Intent intent) {
        super.onNewIntent(intent);

        if(intent == null || !Intent.ACTION_VIEW.equals(intent.getAction())) {
            return;
        }

        String scheme = intent.getScheme();
        Uri uri = intent.getData();
        if(uri == null) {
            if (scheme != null && !scheme.isEmpty()){
                uri = new Uri.Builder().scheme(scheme).path("x-cancel").build();
            }
            else {
                return;
            }
        }

        String iFrameName = preferences.getString("iframeName", "none");
        String window = useIframe(iFrameName) ? "document.getElementById('"+ iFrameName + "').contentWindow" : "window";
        String target = preferences.getString("orelyUrl", "https://orely.luxtrust.com");

        Log.d("App2AppHooks", "Scheme:" + scheme);
        Log.d("App2AppHooks", "Got Intent with URI: " + uri.toString());
        Log.d("App2AppHooks", "orelyUrl=" + target);
        Log.d("App2AppHooks", "iframeName=" + iFrameName);

        String javascript = String.format("javascript:%s.postMessage('%s','%s')",
                window,
                uri.toString(),
                target);

        webView.loadUrl(javascript);
    }

    @JavascriptInterface
    public void launchApp2App(String app2AppUri)
    {
        Log.d("App2AppHooks", "launching app for URI:" + app2AppUri);
        Intent intent = new Intent (
                Intent.ACTION_VIEW,
                Uri.parse(app2AppUri));
        intent.addCategory(Intent.CATEGORY_BROWSABLE);

        cordova.getActivity().startActivity(intent);
    }

    @Override
    public void initialize(CordovaInterface cordova, CordovaWebView webView) {
        super.initialize(cordova, webView);

        String iFrameName = preferences.getString("iframeName", "none");
        Log.d("App2AppHooks", "Initialize. iFrame name: " + iFrameName);
        if (useIframe(iFrameName)){
            ((SystemWebViewEngine) webView.getEngine()).getWebView().addJavascriptInterface(this, "ltwebview");
        }
    }

    private boolean useIframe(String iFrameName)
    {
        return iFrameName != null && !iFrameName.isEmpty() && !"none".equalsIgnoreCase(iFrameName);
    }
}
