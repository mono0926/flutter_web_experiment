import 'dart:html' as html;

void replaceUrlPath(String path) {
  html.window.history.replaceState(null, '', path);
}
