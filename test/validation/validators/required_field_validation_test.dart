import 'package:flutter_test/flutter_test.dart';

abstract class FieldValidation {
  String get field;
  String validate(String value);

}

class RequiredFieldValidation implements FieldValidation{
  final String field;
  
  RequiredFieldValidation({this.field});

  @override
  String validate(String value) {
    return (value.isEmpty) ? 'Campo obrigatório' : null;
  }

}

void main() {
  RequiredFieldValidation sut;

  setUp(() {
    sut = RequiredFieldValidation(field: 'any_field');
  });
  
  test('Should return null if is not empty', () {
    expect(sut.validate('any_value'), null);
  });

  test('Should return error if value is empty', () {
    expect(sut.validate(''), 'Campo obrigatório');
  });
}