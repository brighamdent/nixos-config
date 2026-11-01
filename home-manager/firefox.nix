{
  pkgs,
  inputs,
  config,
  ...
}:

{
  programs.firefox = {
    enable = true;

    policies = {
      SearchEngines = {
        Default = "DuckDuckGo";
        PreventInstalls = true;
      };
    };

    nativeMessagingHosts = [
      pkgs.pywalfox-native
    ];

    profiles.default = {
      isDefault = true;

      settings = {
        # Required for userChrome/userContent
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

        # Extensions
        "extensions.autoDisableScopes" = 0;

        # Telemetry and junk
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "app.shield.optoutstudies.enabled" = false;
        "app.normandy.enabled" = false;
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.ping-centre.telemetry" = false;

        # New tab
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
        "browser.newtabpage.activity-stream.feeds.topsites" = false;
        "extensions.pocket.enabled" = false;

        # URL bar suggestions
        "browser.urlbar.suggest.quicksuggest.sponsored" = false;
        "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
        "browser.urlbar.suggest.trending" = false;

        # UI
        "browser.compactmode.show" = true;
        "browser.uidensity" = 1;
        "browser.toolbars.bookmarks.visibility" = "never";
        "browser.aboutConfig.showWarning" = false;

        # Wayland / performance
        "media.ffmpeg.vaapi.enabled" = true;
        "widget.use-xdg-desktop-portal.file-picker" = 1;
        "general.smoothScroll" = true;

        # Security
        "dom.security.https_only_mode" = true;

        # Bitwarden handles passwords
        "signon.rememberSignons" = false;
        "signon.autofillForms" = false;

        # URL bar
        "browser.urlbar.placeholderName" = "DuckDuckGo";
        "browser.fixup.domainsuffixwhitelist.home" = true;

        "browser.tabs.allow_transparent_browser" = true;
        "userchrome.wallpaper.on" = false;
      };

      userChrome = builtins.readFile ../dotfiles/firefox/chrome/userChrome.css;

      # userContent = builtins.readFile
      #   ../dotfiles/firefox/chrome/userContent.css;

      extensions.packages = with inputs.firefox-addons.packages.${pkgs.system}; [
        ublock-origin
        bitwarden
        pywalfox
      ];
    };
  };
}
