import 'package:flutter_test/flutter_test.dart';

import 'package:clean_flutter_app/presentation/protocols/protocols.dart';
import 'package:clean_flutter_app/validation/validators/validators.dart';

void main() {
  EmailValidation sut;

  setUp(() {
    sut = EmailValidation(field: 'any_field');
  });

  test('Should return null if email is empty', () {
    expect(sut.validate(''), null);
  });

  test('Should return null if email is null', () {
    expect(sut.validate(null), null);
  });

  test('Should return null if email is valid', () {
    expect(sut.validate('jadiel.bsantana@gmail.com'), null);
  });

  test('Should return error if email is invalid', () {
    expect(sut.validate('jadiel.bsantana'), ValidationError.invalidField);
  });
}
