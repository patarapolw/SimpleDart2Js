import 'dart:html';
import 'package:over_react/react_dom.dart' as react_dom;
import 'package:over_react/over_react.dart';

import 'game/game.dart';

main() {
  // Initialize React within our Dart app
  setClientConfiguration();

  // Mount / render your component.
  react_dom.render(Game()(), querySelector('#overreact'));
}