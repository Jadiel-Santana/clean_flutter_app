import 'package:clean_flutter_app/validation/protocols/field_validation.dart';
import 'package:flutter_test/flutter_test.dart';

class EmailValidation implements FieldValidation {
  final String field;

  EmailValidation({this.field});

  @override
  String validate(String value) {
    return null;
  }

}

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
}
