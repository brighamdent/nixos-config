// Required for userChrome/userContent to load
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

// Extensions: enable declaratively installed ones
user_pref("extensions.autoDisableScopes", 0);

// Telemetry and junk
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("datareporting.policy.dataSubmissionEnabled", false);
user_pref("toolkit.telemetry.enabled", false);
user_pref("toolkit.telemetry.unified", false);
user_pref("app.shield.optoutstudies.enabled", false);
user_pref("app.normandy.enabled", false);
user_pref("browser.newtabpage.activity-stream.feeds.telemetry", false);
user_pref("browser.ping-centre.telemetry", false);

// New tab: no sponsored content, no pocket
user_pref("browser.newtabpage.activity-stream.showSponsored", false);
user_pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false);
user_pref("browser.newtabpage.activity-stream.feeds.section.topstories", false);
user_pref("browser.newtabpage.activity-stream.feeds.topsites", false);
user_pref("extensions.pocket.enabled", false);

// URL bar suggestions
user_pref("browser.urlbar.suggest.quicksuggest.sponsored", false);
user_pref("browser.urlbar.suggest.quicksuggest.nonsponsored", false);
user_pref("browser.urlbar.suggest.trending", false);

// UI
user_pref("browser.compactmode.show", true);
user_pref("browser.uidensity", 1);                       // compact
user_pref("browser.toolbars.bookmarks.visibility", "never");
user_pref("browser.aboutConfig.showWarning", false);

// Wayland / performance
user_pref("media.ffmpeg.vaapi.enabled", true);
user_pref("widget.use-xdg-desktop-portal.file-picker", 1);
user_pref("general.smoothScroll", true);

// Security
user_pref("dom.security.https_only_mode", true);

// If Bitwarden handles passwords
user_pref("signon.rememberSignons", false);
user_pref("signon.autofillForms", false);


user_pref("browser.urlbar.placeholderName", "DuckDuckGo");
user_pref("browser.fixup.domainsuffixwhitelist.home", true);
