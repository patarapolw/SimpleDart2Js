import 'package:over_react/over_react.dart';

import 'board.dart';

@Factory()
UiFactory<GameProps> Game;

@Props()
class GameProps extends UiProps {}

@State()
class GameState extends UiState {
  List<Map<String, List<String>>> history;
  int stepNumber;
  bool xIsNext;
}

@Component()
class GameComponent extends UiStatefulComponent<GameProps, GameState> {
  @override
  getInitialState() => (newState()
    ..history = [{
      "squares": new List(9)
    }]
    ..stepNumber = 0
    ..xIsNext = true
  );

  @override
  render() {
    var history = state.history;
    var current = history[state.stepNumber];
    var squares = current["squares"];
    var winner = calculateWinner(squares);
    var moves = new List.generate(history.length, (move) {
      var desc = move > 0 ? 'Go to move #$move' : 'Go to game start';
      return (Dom.li()..key = move)(
        (Dom.button()..onClick = (e) => jumpTo(move))(
          desc
        )
      );
    });
    var status;
    if(winner != null) {
      status = "Winner: " + winner;
    } else {
      status = "Next player: " + (state.xIsNext ? "X" : "O");
    }

    return (Dom.div()..className = "game")(
      (Dom.div()..className = "gameBoard")(
        (Board()
          ..squares = squares
          ..passClick = (i) => handleClick(i)
        )()
      ),
      (Dom.div()..className = "gameInfo")(
        Dom.div()(status),
        Dom.ol()(moves) 
      )
    );
  }

  handleClick(i) {
    var history = state.history;
    var current = history[history.length - 1];
    var squares = new List.from(current["squares"]);
    if(calculateWinner(squares) != null || squares[i] != null) {
      return;
    }

    squares[i] = state.xIsNext ? "X" : "O";
    history.add({
      "squares": squares
    });
    setState(newState()
      ..history = history
      ..stepNumber = history.length - 1
      ..xIsNext = !state.xIsNext
    );
  }

  calculateWinner(squares) {
    for(var ls in [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ]) {
      if ((squares[ls[0]] != null) && squares[ls[0]] == squares[ls[1]] && squares[ls[0]] == squares[ls[2]]) {
        return squares[ls[0]];
      }
    }

    return null;
  }

  jumpTo(step) {
    setState(newState()
      ..stepNumber = step
      ..xIsNext = (step % 2) == 0
    );
  }
}