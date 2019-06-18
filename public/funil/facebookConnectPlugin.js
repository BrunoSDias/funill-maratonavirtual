facebookConnectPlugin = {}

facebookConnectPlugin.getLoginStatus = function getLoginStatus (s, f) {
  htmlFacebookConnectPlugin.getLoginStatus(s, f);
}

facebookConnectPlugin.showDialog = function showDialog (options, s, f) {
  htmlFacebookConnectPlugin.showDialog(options, s, f);
}

facebookConnectPlugin.login = function login (permissions, s, f) {
  htmlFacebookConnectPlugin.login(permissions, s, f);
}

facebookConnectPlugin.checkHasCorrectPermissions = function checkHasCorrectPermissions (permissions, s, f) {
  htmlFacebookConnectPlugin.checkHasCorrectPermissions(permissions, s, f);
}

facebookConnectPlugin.logEvent = function logEvent (name, params, valueToSum, s, f) {
  if (!params && !valueToSum) {
    htmlFacebookConnectPlugin.logEvent([name]);
  } else if (params && !valueToSum) {
    htmlFacebookConnectPlugin.logEvent([name, params]);
  } else if (params && valueToSum) {
    htmlFacebookConnectPlugin.logEvent([name, params, valueToSum]);
  } else {
    f('Invalid arguments')
  }
}

facebookConnectPlugin.logPurchase = function logPurchase (value, currency, s, f) {
  htmlFacebookConnectPlugin.logPurchase([value, currency]);
}

facebookConnectPlugin.getAccessToken = function getAccessToken (s, f) {
  htmlFacebookConnectPlugin.getAccessToken([]);
}

facebookConnectPlugin.logout = function logout (s, f) {
  htmlFacebookConnectPlugin.logout([]);
}

facebookConnectPlugin.api = function api (graphPath, permissions, s, f) {
  permissions = permissions || []
  htmlFacebookConnectPlugin.graphApi(graphPath, s, f);
}

facebookConnectPlugin.appInvite = function appLinks (options, s, f) {
  options = options || {}
  htmlFacebookConnectPlugin.appInvite([options]);
}

facebookConnectPlugin.getDeferredApplink = function (s, f) {
  htmlFacebookConnectPlugin.getDeferredApplink([]);
}

facebookConnectPlugin.activateApp = function (s, f) {
  htmlFacebookConnectPlugin.activateApp([]);
}

facebookConnectPlugin.getDeferredApplink = function (s, f) {
    htmlFacebookConnectPlugin.getDeferredApplink([]);
}