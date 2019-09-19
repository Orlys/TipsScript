// ==UserScript==
// @name         DIR-817LW Auto Login
// @match        http://192.168.0.1/
// @match        http://dlinkrouter.local/
// @grant        none
// ==/UserScript==

(function() {
    'use strict';
    OBJ("loginusr").value='admin';
    OBJ("loginpwd").value='password';
    BODY.LoginSubmit();
})();
