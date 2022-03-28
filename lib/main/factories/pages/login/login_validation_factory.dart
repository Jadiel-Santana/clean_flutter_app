import 'package:clean_flutter_app/main/builders/builders.dart';

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
    ...ValidationBuilder.field('email').required().email().build(),
    ...ValidationBuilder.field('password').required().build(),
  ];
}
