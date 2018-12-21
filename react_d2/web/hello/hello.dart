import 'package:react/react.dart';

var Hello = registerComponent(() => new _Hello());

class _Hello extends Component {
  @override
  render() {
    return div({}, "Hello World");
  }
}