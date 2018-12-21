import 'package:react/react.dart';

var Square = registerComponent(() => new _Square());

class _Square extends Component {
  @override
  render() {
    return button({
      "className": "square",
      "onClick": (e) => props["passClick"]()
      },
      props["value"]
    );
  }
}

var Board = registerComponent(() => new _Board());

class _Board extends Component {
  @override
  render() {
    return div({}, [
      div({"className": "board-row"}, [
        renderSquare(0),
        renderSquare(1),
        renderSquare(2)
      ]),
      div({"className": "board-row"}, [
        renderSquare(3),
        renderSquare(4),
        renderSquare(5)
      ]),
      div({"className": "board-row"}, [
        renderSquare(6),
        renderSquare(7),
        renderSquare(8)
      ])
    ]);
  }

  renderSquare(i) {
    return Square({
      "value": props["squares"][i],
      "passClick": () => props["passClick"](i)
      });
  }
}

var Game = registerComponent(() => new _Game());

class _Game extends Component {
  @override
  render() {
    var history = state["history"];
    var current = history[state["stepNumber"]];
    var squares = current["squares"];

    print(squares);

    var moves = new List.generate(history.length, (i){
      var desc = i > 0 ? 
        'Go to move # $i' :
        'Go to game start';
      return li({
        "key": i
      }, [
        button({
          "onClick": (e) => jumpTo(i)
        },
          desc
        )
      ]);
    });

    var winner = calculateWinner(squares);
    var status;

    if(winner != null) {
      status = "Winner: " + winner;
    } else {
      status = 'Next player: ' + (state["xIsNext"] ? "X" : "O");
    }

    return div({"className": "game"}, [
      div({"className": "game-board"}, [
        Board({
          "squares": squares,
          "passClick": (i) => handleClick(i)
        })
      ]),
      div({"className": "game-info"}, [
        div({}, status),
        ol({}, moves)
      ])
    ]);
  }

  @override
  Map getInitialState() => {
    "history": [{
      "squares": new List(9)
    }],
    "stepNumber": 0,
    "xIsNext": true
  };

  handleClick(i) {
    var history = state["history"];
    var current = history[state["stepNumber"]];
    var squares = new List.from(current["squares"]);

    if(squares[i] != null || calculateWinner(squares) != null) {
      return;
    }

    squares[i] = state["xIsNext"] ? "X" : "O";
    history.add({
      "squares": squares
    });

    setState({
      "history": history,
      "xIsNext": !state["xIsNext"],
      "stepNumber": history.length - 1
      });
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
      [2, 4, 6],
    ]) {
      if(squares[ls[0]] != null && squares[ls[0]] == squares[ls[1]] && squares[ls[0]] == squares[ls[2]]) {
        return squares[ls[0]];
      }
    }

    return null;
  }

  jumpTo(step) {
    // print(state["history"].sublist(0, step));

    setState({
      "stepNumber": step,
      "xIsNext": (step % 2 == 0)
    });
  }
}
