import 'package:flutter_test/flutter_test.dart';

import 'package:clean_flutter_app/presentation/protocols/protocols.dart';
import 'package:clean_flutter_app/validation/validators/validators.dart';

void main() {
  RequiredFieldValidation sut;

  setUp(() {
    sut = RequiredFieldValidation(field: 'any_field');
  });

  test('Should return null if is not empty', () {
    expect(sut.validate('any_value'), null);
  });

  test('Should return error if value is empty', () {
    expect(sut.validate(''), ValidationError.requiredField);
  });

  test('Should return error if value is null', () {
    expect(sut.validate(null), ValidationError.requiredField);
  });
}