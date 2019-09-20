// ==UserScript==
// @name         Injects jQuery 3.4.1 to Chrome DevTools
// @version      0.1
// @match        *://*/*
// @grant        none
// ==/UserScript==

(function() {
    'use strict';
    let jQuerySource = 'https://code.jquery.com/jquery-3.4.1.min.js';
    let importJs=document.createElement('script');
    importJs.setAttribute("type","text/javascript");
    importJs.setAttribute("src", jQuerySource);
    document.getElementsByTagName("head")[0].appendChild(importJs);
})();
