/* Paste into: Administration > System preferences > OPACUserJS
   (Koha adds the script tag and loads jQuery.)  Do NOT paste this into an HTML customization. */
$(function () {
  // Footer year
  $("#nvc-year").text(new Date().getFullYear());

  // Mark the current menu item
  var here = location.pathname === "/" ? "/cgi-bin/koha/opac-main.pl" : location.pathname;
  $("#nvc-menu a").each(function () {
    var href = $(this).attr("href") || "";
    if (href.indexOf("/cgi-bin/koha/") === 0 && href.split("?")[0] === here) {
      $(this).addClass("is-active").attr("aria-current", "page");
    }
  });

  // Open the My account tab named in the link (e.g. opac-user.pl#opac-user-holds)
  if (/^#opac-user-[a-z-]+$/.test(location.hash)) {
    var tab = document.getElementById(location.hash.slice(1) + "-tab");
    if (tab) tab.click();   // native click, so Bootstrap's tab handler runs
  }

  // Login page: place the welcome panel (from OpacLoginInstructions) beside the form
  var $auth = $("#opac-login-page #opac-auth");
  var $aside = $auth.find(".nvc-login-aside");
  if ($auth.length && $aside.length) {
    $('<div class="nvc-login"></div>').insertBefore($auth).append($aside).append($auth);
  }

  // Mobile menu toggle
  $(".nvc-nav__toggle").on("click", function () {
    var $nav = $("#nvc-nav").toggleClass("is-open");
    var open = $nav.hasClass("is-open");
    $(this).attr("aria-expanded", open)
      .find("i").toggleClass("fa-bars", !open).toggleClass("fa-xmark", open);
  });
});
