var u = navigator.userAgent;
var isAndroid = u.indexOf("Android") > -1 || u.indexOf("Adr") > -1; //android终端
var isiOS = !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/); //ios终端
// 注册jsbridge
function connectWebViewJavascriptBridge(callback) {
    if (isAndroid) {
        console.log('isAndroid')
        if (window.WebViewJavascriptBridge) {
            console.log('window.WebViewJavascriptBridge')
            callback(WebViewJavascriptBridge);
        } else {
            document.addEventListener(
                "WebViewJavascriptBridgeReady",
                function () {
                    callback(WebViewJavascriptBridge);
                },
                false
            );
        }
        return;
    }
    if (isiOS) {
        if (window.WebViewJavascriptBridge) {
            return callback(WebViewJavascriptBridge);
        }
        console.log('window.WVJBCallbacks1', window.WVJBCallbacks)
        if (window.WVJBCallbacks) {
            return window.WVJBCallbacks.push(callback);
        }
        window.WVJBCallbacks = [callback];
        console.log('window.WVJBCallbacks2', window.WVJBCallbacks)
        var WVJBIframe = document.createElement("iframe");
        WVJBIframe.style.display = "none";
        WVJBIframe.src = "https://__bridge_loaded__";
        document.documentElement.appendChild(WVJBIframe);
        setTimeout(function () {
            document.documentElement.removeChild(WVJBIframe);
        }, 0);
    }
}

let Bridge = {
    callHandler: function (name, data, callback) {
        connectWebViewJavascriptBridge(function (bridge) {
            console.log("--------bridge.callHandler----------:")
            bridge.callHandler(name, data, callback);
        });
    },
    registerhandler: function (name, callback) {
        connectWebViewJavascriptBridge(function (bridge) {
            console.log("------------registerhandler-------------:", bridge)
            bridge.registerHandler(name, function (data, responseCallback) {
                callback(data, responseCallback);
            });
        });
    },
};

// export { Bridge }
