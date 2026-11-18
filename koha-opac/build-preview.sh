#!/bin/sh
# Rebuilds preview.html from the Koha snippet files (run from this folder).
{
cat <<'EOF'
<!doctype html>
<html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1">
<title>NVC OPAC Preview</title>
<link rel="stylesheet" href="https://nvc-opac.kohacloud.in/opac-tmpl/bootstrap/css/opac_25.1107000.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
<link rel="stylesheet" href="OPACUserCSS.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body id="opac-main" class="branch-default">
<div id="wrapper">
<header id="header-region" class="noprint">
  <nav class="navbar navbar-expand">
    <div id="logo"><a class="navbar-brand" href="#">NVC Central Library</a></div>
    <ul id="members" class="navbar-nav ms-auto"><li class="nav-item"><a href="#" class="nav-link"><i class="fa fa-user fa-fw fa-icon-black"></i> Log in to your account</a></li></ul>
  </nav>
  <div class="container-fluid"><div class="row"><div class="col"><div id="opacheader">
EOF
sed '1d' opacheader.html
cat <<'EOF'
  </div></div></div></div>
</header>
<main class="main"><nav id="breadcrumbs" aria-label="Breadcrumb" class="breadcrumbs"><ol class="breadcrumb"><li class="breadcrumb-item">Home</li></ol></nav><div id="notloggedin" class="container-fluid"><div class="row"><div class="col-12 col-lg-9 order-md-1 maincontent"><h1 class="sr-only">Koha home</h1><div id="OpacMainUserBlock"><div class="en_item"><div class="en_body">
EOF
sed '1,2d' OpacMainUserBlock.html
cat <<'EOF'
</div></div></div></div><div class="col-12 col-lg-3 order-md-2"><div id="login">[Koha login box: hidden by OPACUserCSS on the home page]</div></div></div></div></main>
<div class="container-fluid"><div class="row"><div class="col"><div id="opaccredits">
EOF
sed '1d' opaccredits.html
echo '</div></div></div></div></div>'
echo '<script>'; cat OPACUserJS.js; echo '</script>'
echo '</body></html>'
} > preview.html

# ---- Login page preview (markup copied from the live Koha 25.11 login page) ----
{
sed -n '1,/<body /p' preview.html | sed 's/<body id="opac-main"/<body id="opac-login-page"/; s/<title>NVC OPAC Preview<\/title>/<title>NVC OPAC Login Preview<\/title>/'
sed -n '/<div id="wrapper">/,/<\/header>/p' preview.html
cat <<'EOF'
<main class="main">
  <nav id="breadcrumbs" aria-label="Breadcrumb" class="breadcrumbs"><ol class="breadcrumb"><li class="breadcrumb-item">Home</li><li class="breadcrumb-item active">Log in to your account</li></ol></nav>
  <div class="container-fluid"><div class="row justify-content-center"><div class="col-md-10 col-lg-6">
    <div id="opac-auth" class="maincontent">
      <h1>Log in to your account</h1>
      <form action="#" name="auth" id="auth" method="post" autocomplete="off" onsubmit="return false">
        <div class="local-login"><fieldset class="brief">
          <div class="form-group"><label for="userid">Card number or username:</label>
            <input class="form-control" type="text" size="25" id="userid" name="login_userid" autocomplete="off"></div>
          <div class="form-group"><label for="password">Password:</label>
            <input class="form-control" type="password" size="25" id="password" name="login_password" autocomplete="off"><div class="show-password-toggle"><input type="checkbox" class="show-password-toggle-checkbox" id="show-password-toggle-checkbox-1"><label class="show-password-toggle-label" for="show-password-toggle-checkbox-1"> Show password</label></div></div>
          <fieldset class="action"><input type="submit" value="Log in" class="btn btn-primary"></fieldset>
        </fieldset></div>
        <div id="nologininstructions"><div id="OpacLoginInstructions"><div class="default_item"><div class="default_body">
EOF
sed '1,3d' OpacLoginInstructions.html
cat <<'EOF'
        </div></div></div></div>
      </form>
    </div>
  </div></div></div>
</main>
<div class="container-fluid"><div class="row"><div class="col"><div id="opaccredits">
EOF
sed '1d' opaccredits.html
echo '</div></div></div></div></div>'
echo '<script>'; cat OPACUserJS.js; echo '</script>'
echo '</body></html>'
} > login-preview.html
