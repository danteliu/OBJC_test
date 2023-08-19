function call_ios_function(namespace, functionName, args) {
    if (!window.webkit.messageHandlers[namespace]) return;
    var wrap = { method: functionName, params: args };
    window.webkit.messageHandlers[namespace].postMessage(JSON.stringify(wrap));
}
var wapper = {};
wapper.videoPlay = function (message) {
    call_ios_function("WVJB", "videoPlay", message);
};
wapper.getUserInfo = function (message) {
    call_ios_function("WVJB", "getUserInfo", message);
};
wapper.gotoApp = function (message) {
    call_ios_function("WVJB", "gotoApp", message);
};
wapper.hcy_closeWebViewPopupWindow = function (message) {
    call_ios_function("WVJB", "hcy_closeWebViewPopupWindow", message);
};

window["WVJB"] = wapper;
