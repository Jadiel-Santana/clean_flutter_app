import 'package:flutter_test/flutter_test.dart';
import 'package:meta/meta.dart';
import 'package:mockito/mockito.dart';

import 'package:clean_flutter_app/presentation/protocols/protocols.dart';

import 'package:clean_flutter_app/validation/protocols/protocols.dart';

class ValidationComposite implements Validation {
final List<FieldValidation> validations;

  ValidationComposite({@required this.validations});

  @override
  String validate({@required String field, @required String value}) {
    return null;
  }
}

class FieldValidationSpy extends Mock implements FieldValidation {}

void main() {

  test('Should return null if all validations returns null or empty', () {
    final validation1 = FieldValidationSpy();
    when(validation1.field).thenReturn('any_field');
    when(validation1.validate(any)).thenReturn(null);

    final validation2 = FieldValidationSpy();
    when(validation2.field).thenReturn('any_field');
    when(validation2.validate(any)).thenReturn('');
    final sut = ValidationComposite(validations: [validation1, validation2]);

    final error = sut.validate(field: 'any_field', value: 'any_value');

    expect(error, null);
  });
}
