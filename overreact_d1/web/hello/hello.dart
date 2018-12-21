import 'package:over_react/over_react.dart';

@Factory()
UiFactory<HelloProps> Hello;

@Props()
class HelloProps extends UiProps {}

@Component()
class HelloComponents extends UiComponent<HelloProps> {
  @override
  render() {
    return Dom.div()("Hello World!");
  }
}