import 'dart:async';

import 'package:meta/meta.dart';

import '../protocols/protocols.dart';

class LoginState {
  String emailerror;
}

class StreamLoginPresenter {
  final Validation validation;
  final _controller = StreamController<LoginState>.broadcast();
  var _state = LoginState();

  Stream<String> get emailErrorStream =>
      _controller.stream.map((state) => state.emailerror);

  StreamLoginPresenter({@required this.validation});

  void validadeEmail(String email) {
    _state.emailerror = validation.validate(field: 'email', value: email);
    _controller.add(_state);
  }
}
