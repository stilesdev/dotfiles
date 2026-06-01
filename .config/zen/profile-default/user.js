// From prefs.js:
// To change a preference value, you can either:
// - modify it via the UI (e.g. via about:config in the browser); or
// - set it within a user.js file in your profile.

// required for userChrome.css to work:
user_pref("devtools.chrome.enabled", true);
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

// don't show the Clear Tabs button below pinned tabs that can accidentally delete all tabs with a single click...
user_pref("zen.view.show-clear-tabs-button", false);

// each workspace has its own essentials section
user_pref("zen.workspaces.separate-essentials", true);

// don't show warning when opening about:config
user_pref("browser.aboutConfig.showWarning", false);

// always show full URLs in URL bar
user_pref("browser.urlbar.trimURLs", false);

// move extensions from url bar back to actual toolbar (https://github.com/zen-browser/desktop/issues/13831)
user_pref("zen.view.overflow-webext-toolbar", false);
