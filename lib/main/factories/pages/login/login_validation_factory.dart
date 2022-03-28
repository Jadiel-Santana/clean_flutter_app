import '../../../../presentation/protocols/protocols.dart';
import '../../../../validation/validators/validators.dart';
import '../../../../validation/protocols/protocols.dart';

Validation makeLoginValidation() {
  return ValidationComposite(
    validations: makeLoginValidations(),
  );
}

List<FieldValidation> makeLoginValidations() {
  return [
    RequiredFieldValidation(field: 'email'),
    EmailValidation(field: 'email'),
    RequiredFieldValidation(field: 'password'),
  ];
}
