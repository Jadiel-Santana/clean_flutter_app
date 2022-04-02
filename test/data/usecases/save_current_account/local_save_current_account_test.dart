import 'package:flutter_test/flutter_test.dart';

import 'package:clean_flutter_app/domain/entities/entities.dart';
import 'package:clean_flutter_app/domain/usecases/usecases.dart';

class LocalSaveCurrentAccount implements SaveCurrentAccount {
  @override
  Future<void> save(AccountEntity account) {
    
  }

}

void main() {

  test('Should call SaveCacheStorage with correct values', () async {
    final sut = LocalSaveCurrentAccount();
  });
}
