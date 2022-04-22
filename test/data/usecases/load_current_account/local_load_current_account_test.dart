import 'package:clean_flutter_app/domain/helpers/helpers.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meta/meta.dart';
import 'package:mockito/mockito.dart';

import 'package:clean_flutter_app/domain/entities/entities.dart';
import 'package:clean_flutter_app/domain/usecases/usecases.dart';

class LocalLoadCurrentAccount implements LoadCurrentAccount {
  final FetchSecureCacheStorage fetchSecureCacheStorage;
  LocalLoadCurrentAccount({@required this.fetchSecureCacheStorage});

  @override
  Future<AccountEntity> load() async {
    try {
      final token = await fetchSecureCacheStorage.fetchSecure(key: 'token');
      return AccountEntity(token: token);
    } catch(error) {
      throw DomainError.unexpected;
    }
  }
}

abstract class FetchSecureCacheStorage {
  Future<String> fetchSecure({@required String key});
}

class FetchSecureCacheStorageSpy extends Mock implements FetchSecureCacheStorage {}

void main() {
  FetchSecureCacheStorageSpy fetchSecureCacheStorage;
  LocalLoadCurrentAccount sut;
  String token;

  PostExpectation mockFetchSecureCall() =>
    when(fetchSecureCacheStorage.fetchSecure(key: anyNamed('key')));

  void mockFetchSecure() {
    mockFetchSecureCall().thenAnswer((_) async => token);
  }
  
  void mockFetchSecureError() {
    mockFetchSecureCall().thenThrow(Exception());
  }

  setUp(() {
    fetchSecureCacheStorage = FetchSecureCacheStorageSpy();
    sut = LocalLoadCurrentAccount(fetchSecureCacheStorage: fetchSecureCacheStorage);
    token = faker.guid.guid();
    mockFetchSecure();
  });

  test('Should call FetchSecureCacheStorage with correct value', () async {
    await sut.load();
    
    verify(fetchSecureCacheStorage.fetchSecure(key: 'token')).called(1);
  });

  test('Should return an AccountEntity', () async {
    final account = await sut.load();
    
    expect(account, AccountEntity(token: token));
  });

  test('Should throw UnexpectedError if FetchSecureCacheStorage throws', () {
    mockFetchSecureError();

    final future = sut.load();
      
    expect(future, throwsA(DomainError.unexpected));
  });
}
