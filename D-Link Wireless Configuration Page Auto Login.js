// ==UserScript==
// @name         D-Link Wireless Configuration Page Auto Login
// @version      0.1
// @Author       Orlys
// @grant        none
// ==/UserScript==

(function() {
    'use strict';

    const map = [
        'd-link',
        'dlink'
    ];

    const account = '';
    const password = '';

    let flag = false;
    const title = document.title.toLowerCase();
    for(let index = 0; index < map.length; index++){
        if(title.indexOf(map[index]) > -1){
            OBJ("loginusr").value=account;
            OBJ("loginpwd").value=password;
            BODY.LoginSubmit();
            break;
        }
    }
})();