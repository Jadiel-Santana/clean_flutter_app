import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:clean_flutter_app/data/cache/cache.dart';

class LocalStorageAdapter implements SaveSecureCacheStorage {
  final FlutterSecureStorage secureStorage;

  LocalStorageAdapter({@required this.secureStorage});

  @override
  Future<void> saveSecure({@required String key, @required String value}) async {
    await saveSecure(key: key, value: value);
  }
}

class FlutterSecureStorageMockSpy extends Mock implements FlutterSecureStorage {}

void main() {
  FlutterSecureStorageMockSpy secureStorage;
  LocalStorageAdapter sut;
  String key;
  String value;

  setUp(() {
    secureStorage = FlutterSecureStorageMockSpy();
    sut = LocalStorageAdapter(secureStorage: secureStorage);
    key = faker.lorem.word();
    value = faker.guid.guid();
  });

  void mockSaveSecureError() {
    when(secureStorage.write(key: anyNamed('key'), value: anyNamed('value')))
     .thenThrow(Exception());
  }

  test('Should call save secure with correct values', () async {
    await sut.saveSecure(key: key, value: value);

    verify(secureStorage.write(key: key, value: value));
  });

  test('Should throw if save secure throws', () {
    mockSaveSecureError();

    final future = sut.saveSecure(key: key, value: value);

    var typeMatcher = TypeMatcher<Exception>();
    expect(future, throwsA(typeMatcher));
  });
}
