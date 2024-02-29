// ==UserScript==
// @name         Jira sort oldest comments first
// @namespace    https://nirantak.com
// @version      1.0
// @description  Ensures that oldest comments are always first! (Tested on Jira v9.4.8)
// @author       Nirantak Raghav
// @match        https://jira.example.com/browse/**
// @grant        none
// ==/UserScript==

function waitForElm(selector) {
    return new Promise((resolve) => {
      if (document.querySelector(selector)) {
        return resolve(document.querySelector(selector));
      }
  
      const observer = new MutationObserver((mutations) => {
        if (document.querySelector(selector)) {
          observer.disconnect();
          resolve(document.querySelector(selector));
        }
      });
  
      observer.observe(document.body, {
        childList: true,
        subtree: true,
      });
    });
  }
  
  (function () {
    "use strict";
    waitForElm(".activity-tab-sort-label").then((elm) => {
      if (elm.getInnerHTML() != "Oldest first") {
        elm.click();
      }
    });
  })();
  