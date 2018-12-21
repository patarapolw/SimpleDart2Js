import 'package:over_react/over_react.dart';

import 'square.dart';

@Factory()
UiFactory<BoardProps> Board;

@Props()
class BoardProps extends UiProps {
  List<String> squares;
  var passClick;
}

@Component()
class BoardComponent extends UiComponent<BoardProps> {
  @override
  render() {
    return Dom.div()(
      renderRow(0, 1, 2),
      renderRow(3, 4, 5),
      renderRow(6, 7, 8)
    );
  }

  renderRow(i1, i2, i3) {
    return (Dom.div()..className = "board-row")(
      renderSquare(i1),
      renderSquare(i2),
      renderSquare(i3)
    );
  }

  renderSquare(i) {
    return (Square()
      ..value = props.squares[i]
      ..passClick = () => props.passClick(i)
    )();
  }
}