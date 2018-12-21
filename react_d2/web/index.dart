import 'dart:html';

import 'package:react/react_client.dart';
import 'package:react/react_dom.dart' as react_dom;

import 'game/game.dart';

main() {
  setClientConfiguration();

  react_dom.render(Game({}), querySelector('#overreact'));
}