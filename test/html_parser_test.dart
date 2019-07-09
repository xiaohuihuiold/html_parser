import 'package:flutter_test/flutter_test.dart';
import 'package:html_parser/html/document.dart';
import 'package:html_parser/html/element.dart';

import 'package:html_parser/html_parser.dart';

String testHtml = '''

<!DOCTYPE html>
<html lang="en-us">
<head>
  <script async="async" src="https://www.googletagmanager.com/gtag/js?id=UA-26406144-13"></script>
  <script src="/static/js/gtag.js?hash=kjb50t624ecqkbe6v0qfurhg4hl8j76c"></script>
  <meta charset="utf-8" />
  <meta http-equiv="x-ua-compatible" content="ie=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <meta name="twitter:card" content="summary" />
  <meta name="twitter:site" content="@dart_lang" />
  <meta property="og:site_name" content="Dart packages" />
  <title>Dart packages</title>
  <meta property="og:title" content="Dart packages" />
  <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700" rel="stylesheet" />
  <meta itemprop="image" content="/static/img/dart-logo-400x400.png?hash=i18bc8g4aa2r6vf85lpgro6ml5ltd13g" />
  <meta property="og:image" content="/static/img/dart-logo-400x400.png?hash=i18bc8g4aa2r6vf85lpgro6ml5ltd13g" />
  <link rel="shortcut icon" href="/favicon.ico?hash=nk4nss8c7444fg0chird9erqef2vkhb8" />
  <link rel="search" type="application/opensearchdescription+xml" title="Dart packages" href="/static/osd.xml?hash=uhkvaq6tn5ujmk0so48em6cukeb08c2d" />
  <meta name="description" content="Pub is the package manager for the Dart programming language, containing reusable libraries &amp; packages for Flutter, AngularDart, and general Dart programs." />
  <meta property="og:description" content="Pub is the package manager for the Dart programming language, containing reusable libraries &amp; packages for Flutter, AngularDart, and general Dart programs." />
  <link rel="alternate" type="application/atom+xml" title="Updated Packages Feed for Pub" href="/feed.atom" />
  <link href="/static/highlight/github.css?hash=ddjqjhh3o6fcmi9g9no3i3id8s23itod" rel="stylesheet" />
  <link href="/static/css/github-markdown.css?hash=t2ti0tfkd3q7dsh5njovil42c3bnhf5s" rel="stylesheet" type="text/css" />
  <link href="/static/css/style.css?hash=jlrdl9admki9cpdsq00r3tid09gnfl56" rel="stylesheet" type="text/css" />
  <script src="/static/js/script.dart.js?hash=i6c8g00cmau93tqdc4m98doaq193f9rj" defer="defer"></script>
  <script async="async" defer="defer" src="//www.google.cn/insights/consumersurveys/async_survey?site=5wdvu4vc5lhop3xbatxof6lzcm"></script>
</head>
<body class="">
<header class="site-header-row">
  <div class="site-header">
    <h1 class="_visuallyhidden">Dart pub</h1>
    <button class="hamburger"></button>
    <div class="mask"></div>
    <div class="nav-wrap">
      <div class="nav-header"><a class="logo" href="/"><img src="/static/img/pub-dev-logo-2x.png?hash=umitaheu8hl7gd3mineshk2koqfngugi" alt="dart pub logo" /></a>
        <div class="_flex-space"></div>
        <button class="close"></button>
      </div>
      <nav class="site-nav">
        <span>Getting Started:</span>
        <div class="sub-wrap hoverable">
          <button class="button">Flutter</button>
          <div class="sub-nav">
            <a class="link" target="_blank" rel="noopener" href="https://flutter.io/using-packages/">Using packages</a>
            <a class="link" target="_blank" rel="noopener" href="https://flutter.io/developing-packages/">Developing packages and plugins</a>
            <a class="link" target="_blank" rel="noopener" href="https://dart.dev/tools/pub/publishing">Publishing a package</a>
            <a class="link" target="_blank" rel="noopener" href="https://dart.dev/tools/pub">Pub tool</a>
          </div>
        </div>
        <div class="sub-wrap hoverable">
          <button class="button">Web &amp; Server</button>
          <div class="sub-nav">
            <a class="link" target="_blank" rel="noopener" href="https://dart.dev/tools/pub/get-started">Using packages</a>
            <a class="link" target="_blank" rel="noopener" href="https://dart.dev/tools/pub/publishing">Publishing a package</a>
            <a class="link" target="_blank" rel="noopener" href="https://dart.dev/tools/pub">Pub tool</a>
          </div>
        </div>
      </nav>
    </div>
  </div>
</header>



  <div class="_banner-bg">
    <main class="home-banner">
      <h2 class="_visuallyhidden">Dart package manager</h2>
      <img class="logo" src="/static/img/dart-packages-white.png?hash=5u981pocjq58i91k5lk41unu5gmcsdop" alt="Dart packages" />
      <form class="search-bar" action="/packages">
        <input class="input" name="q" placeholder="Search Dart packages" autocomplete="on" autofocus="autofocus" />
        <button class="icon"></button>
      </form>
      <没闭合>
      <div class="list-filters">
        <a class="filter " href="/flutter">Flutter</a>
        <a class="filter " href="/web">Web</a>
        <a class="filter -active" href="/">All</a>
      </div>
      <p class="text">Find and use packages to build <a href="/flutter">Flutter</a> and <a href="/web">web</a> apps with <a target="_blank" rel="noopener" href="https://dart.dev">Dart</a>.</p>
    </main>
  </div>

<main>
  
<div class="home-lists-container">
  <div class="landing-page-title-block">
    <div class="tooltip-base hoverable">
      <h2 class="center landing-page-title tooltip-dotted">Top Dart packages</h2>
      <div class="tooltip-content">
        Packages are sorted by the overall score. More information on <a href="/help#ranking">ranking</a>.
      </div>
    </div>
  </div>
  
<ul class="package-list">
    <li class="list-item -simple">
      <h3 class="title"><a href="/packages/http">http</a></h3>
      <p class="metadata">
            <a class="package-tag" href="/flutter/packages" title="Compatible with the Flutter platform.">Flutter</a>
    <a class="package-tag" href="/web/packages" title="Compatible with the web platform.">web</a>
    <span class="package-tag" title="Compatible with other platforms (terminal, server, etc.).">other</span>

      </p>
      <p class="description">A composable, cross-platform, Future-based API for making HTTP requests.</p>
    </li>
    <li class="list-item -simple">
      <h3 class="title"><a href="/packages/path_provider">path_provider</a></h3>
      <p class="metadata">
            <a class="package-tag" href="/flutter/packages" title="Compatible with the Flutter platform.">Flutter</a>

      </p>
      <p class="description">Flutter plugin for getting commonly used locations on the Android &amp; iOS file systems, such as the temp and app data directories.</p>
    </li>
    <li class="list-item -simple">
      <h3 class="title"><a href="/packages/url_launcher">url_launcher</a></h3>
      <p class="metadata">
            <a class="package-tag" href="/flutter/packages" title="Compatible with the Flutter platform.">Flutter</a>

      </p>
      <p class="description">Flutter plugin for launching a URL on Android and iOS. Supports web, phone, SMS, and email schemes.</p>
    </li>
    <li class="list-item -simple">
      <h3 class="title"><a href="/packages/image_picker">image_picker</a></h3>
      <p class="metadata">
            <a class="package-tag" href="/flutter/packages" title="Compatible with the Flutter platform.">Flutter</a>

      </p>
      <p class="description">Flutter plugin for selecting images from the Android and iOS image library, and taking new pictures with the camera.</p>
    </li>
    <li class="list-item -simple">
      <h3 class="title"><a href="/packages/sqflite">sqflite</a></h3>
      <p class="metadata">
            <a class="package-tag" href="/flutter/packages" title="Compatible with the Flutter platform.">Flutter</a>

      </p>
      <p class="description">Flutter plugin for SQLite, a self-contained, high-reliability, embedded, SQL database engine.</p>
    </li>
    <li class="list-item -simple">
      <h3 class="title"><a href="/packages/cached_network_image">cached_network_image</a></h3>
      <p class="metadata">
            <a class="package-tag" href="/flutter/packages" title="Compatible with the Flutter platform.">Flutter</a>

      </p>
      <p class="description">Flutter library to load and cache network images. Can also be used with placeholder and error widgets.</p>
    </li>
    <li class="list-item -simple">
      <h3 class="title"><a href="/packages/dio">dio</a></h3>
      <p class="metadata">
            <a class="package-tag" href="/flutter/packages" title="Compatible with the Flutter platform.">Flutter</a>
    <span class="package-tag" title="Compatible with other platforms (terminal, server, etc.).">other</span>

      </p>
      <p class="description">A powerful Http client for Dart, which supports Interceptors, FormData, Request Cancellation, File Downloading, Timeout etc.</p>
    </li>
    <li class="list-item -simple">
      <h3 class="title"><a href="/packages/google_maps_flutter">google_maps_flutter</a></h3>
      <p class="metadata">
            <a class="package-tag" href="/flutter/packages" title="Compatible with the Flutter platform.">Flutter</a>

      </p>
      <p class="description">A Flutter plugin for integrating Google Maps in iOS and Android applications.</p>
    </li>
    <li class="list-item -simple">
      <h3 class="title"><a href="/packages/provider">provider</a></h3>
      <p class="metadata">
            <a class="package-tag" href="/flutter/packages" title="Compatible with the Flutter platform.">Flutter</a>

      </p>
      <p class="description">A dependency injection system built with widgets for widgets. provider is mostly syntax sugar for InheritedWidget, to make common use-cases straightforward.</p>
    </li>
    <li class="list-item -simple">
      <h3 class="title"><a href="/packages/scoped_model">scoped_model</a></h3>
      <p class="metadata">
            <a class="package-tag" href="/flutter/packages" title="Compatible with the Flutter platform.">Flutter</a>

      </p>
      <p class="description">A Widget that passes a Reactive Model to all of it&#x27;s children</p>
    </li>
    <li class="list-item -simple">
      <h3 class="title"><a href="/packages/firebase_storage">firebase_storage</a></h3>
      <p class="metadata">
            <a class="package-tag" href="/flutter/packages" title="Compatible with the Flutter platform.">Flutter</a>

      </p>
      <p class="description">Flutter plugin for Firebase Cloud Storage, a powerful, simple, and cost-effective object storage service for Android and iOS.</p>
    </li>
    <li class="list-item -simple">
      <h3 class="title"><a href="/packages/package_info">package_info</a></h3>
      <p class="metadata">
            <a class="package-tag" href="/flutter/packages" title="Compatible with the Flutter platform.">Flutter</a>

      </p>
      <p class="description">Flutter plugin for querying information about the application package, such as CFBundleVersion on iOS or versionCode on Android.</p>
    </li>
    <li class="list-item -simple">
      <h3 class="title"><a href="/packages/flutter_webview_plugin">flutter_webview_plugin</a></h3>
      <p class="metadata">
            <a class="package-tag" href="/flutter/packages" title="Compatible with the Flutter platform.">Flutter</a>

      </p>
      <p class="description">Plugin that allow Flutter to communicate with a native Webview.</p>
    </li>
    <li class="list-item -simple">
      <h3 class="title"><a href="/packages/device_info">device_info</a></h3>
      <p class="metadata">
            <a class="package-tag" href="/flutter/packages" title="Compatible with the Flutter platform.">Flutter</a>

      </p>
      <p class="description">Flutter plugin providing detailed information about the device (make, model, etc.), and Android or iOS version the app is running on.</p>
    </li>
    <li class="list-item -simple">
      <h3 class="title"><a href="/packages/webview_flutter">webview_flutter</a></h3>
      <p class="metadata">
            <a class="package-tag" href="/flutter/packages" title="Compatible with the Flutter platform.">Flutter</a>

      </p>
      <p class="description">A Flutter plugin that provides a WebView widget on Android and iOS.</p>
    </li>
</ul>

  <div class="more">
    <a href="/packages">More Dart packages...</a>
  </div>
</div>

</main>

<footer class="site-footer">
  <a class="link" href="https://dart.dev/">Dart language</a>
  <a class="link" href="https://www.google.cn/intl/en/policies/terms/">Terms</a>
  <a class="link" href="https://www.google.cn/intl/en/policies/privacy/">Privacy</a>
  <a class="link" href="/help">Help</a>
  <a class="link" href="/feed.atom"><img src="/static/img/atom-feed-icon-32x32.png?hash=6pve899f2ui9t0d7lnd9ljnh498u13b4" class="inline-icon" /></a>
  <a class="link github_issue" href="https://github.com/dart-lang/pub-dev/issues/new">Report an issue with this site</a>
</footer>
<script type="application/ld+json">
{"@context":"http://schema.org","@type":"WebSite","url":"https://pub.flutter-io.cn/","potentialAction":{"@type":"SearchAction","target":"https://pub.flutter-io.cn/packages?q={search_term_string}","query-input":"required name=search_term_string"}}
</script>

</body>
</html>

''';

void main() {
  test('html parser', () {
    Element root = Element();
    root.tag = 'root';
    testParser(root, 0);
    root?.printAll();
  });
  test('dom test', () {
    XmlParser xmlParser = XmlParser.html(testHtml);
    Document document = Document();
    Element root = Element();
    root.tag = 'html';
    document.root = root;

    Element head = Element();
    head.tag = 'head';
    root.addElement(head);

    Element title = Element();
    title.tag = 'title';
    head.addElement(title);

    for (int i = 0; i < 7; i++) {
      Element p = Element();
      p.tag = 'p';
      title.addElement(p);
      p.id = '$i';
    }

    Element body = Element();
    body.tag = 'body';
    root.addElement(body);

    for (int i = 0; i < 5; i++) {
      Element p = Element();
      p.tag = 'p';
      body.addElement(p);
    }

    document.printAll();

    Element id = root.getElementById('5');
    print(id);
  });
}

List<int> testParser(Element parent, int index) {
  int i = index;
  for (; i < testHtml.length; i++) {
    String char = testHtml[i];
    if (char == '/' && testHtml[i + 1] == '>') {
      return [i + 2, 0];
    } else if (char == '<') {
      if (testHtml[i + 1] == '/') {
        i += 2;
        String tag = '';
        while (i < testHtml.length && testHtml[i] != '>') {
          tag += testHtml[i];
          i++;
        }
        if (parent.tag != tag) {
          return [i++, 1];
        }
        break;
      }
      Element element = Element();
      String tag = '';
      i++;
      while (
          i < testHtml.length && (testHtml[i] != ' ' && testHtml[i] != '>')) {
        tag += testHtml[i];
        i++;
      }
      element.tag = tag;
      parent.addElement(element);
      List<int> nums = testParser(element, ++i);
      i = nums[0];
      if (nums[1] > 0) {
        nums[1] = nums[1] - 1;
        return nums;
      }
    }
  }
  return [i + 2, 0];
}
