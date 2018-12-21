import 'package:over_react/over_react.dart';

@Factory()
UiFactory<SquareProps> Square;

@Props()
class SquareProps extends UiProps {
  String value;
  var passClick;
}

@Component()
class SquareComponent extends UiComponent<SquareProps> {
  @override
  render() {
    return (Dom.button()
      ..className = "square"
      ..onClick = (e) => props.passClick()
    )(
      props.value
    );
  }
}