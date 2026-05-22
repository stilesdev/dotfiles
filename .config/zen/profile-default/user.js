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
