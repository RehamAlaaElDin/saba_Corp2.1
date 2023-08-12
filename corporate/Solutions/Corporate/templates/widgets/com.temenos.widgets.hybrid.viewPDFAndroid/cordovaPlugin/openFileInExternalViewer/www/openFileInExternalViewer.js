//  openFileInExternalViewerPlugin

var exec = require('cordova/exec');

/*  public API of the plugin    */

var OpenFileInExternalViewer = {
    viewDocument: function (url, contentType, onError)
    {
             
        function _logError(e)
        {
            var errorPrefix = "Error in cordova.plugins.temenos.OpenFileInExternalViewer.viewDocument(): ";
            window.console.error(errorPrefix, e);
        }

        function _onError(e)
        {
            _logError(e);
            if (onError)
                onError(e);
        }

        try
        {
            
            var CDV_HANDLE = "OpenFileInExternalViewer";
            var VIEW_DOCUMENT =  "viewDocument";            
            
             exec(null,
                _onError,
                CDV_HANDLE,
                VIEW_DOCUMENT,
                [
                    {
                        url: url,
                        contentType: contentType,
                    }
                ]
            );            
        }
        catch (e)
        {
            _onError(e);
        }
    }
};

module.exports = OpenFileInExternalViewer;
