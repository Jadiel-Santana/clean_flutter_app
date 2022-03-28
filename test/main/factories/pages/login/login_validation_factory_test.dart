import 'package:flutter_test/flutter_test.dart';
import 'package:clean_flutter_app/main/factories/factories.dart';
import 'package:clean_flutter_app/validation/validators/validators.dart';

void main() {

  test('Should return the correct validations', () {
    final validations = makeLoginValidations();
    expect(validations, [
      RequiredFieldValidation(field: 'email'),
      EmailValidation(field: 'email'),
      RequiredFieldValidation(field: 'password'),
    ]);
  });
}