import 'package:clean_flutter_app/domain/entities/account_entity.dart';
import 'package:faker/faker.dart';
import 'package:get/get.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:meta/meta.dart';

import 'package:clean_flutter_app/domain/usecases/usecases.dart';
import 'package:clean_flutter_app/ui/pages/pages.dart';

class GetxSplashPresenter implements SplashPresenter {
  final LoadCurrentAccount loadCurrentAccount;
  GetxSplashPresenter({@required this.loadCurrentAccount});
  
  RxString _navigateTo = RxString();
  
  @override
  Stream<String> get navigateToStream => _navigateTo.stream;
  
  @override
  Future<void> checkAccount() async {
    final account = await loadCurrentAccount.load();
    _navigateTo.value = (account.isNull) ? '/login' : '/surveys';
  }
}

class LoadCurrentAccountSpy extends Mock implements LoadCurrentAccount {}

void main() {
  LoadCurrentAccountSpy loadCurrentAccount;
  GetxSplashPresenter sut;

  void mockLoadCurrentAccount({AccountEntity account}) {
    when(loadCurrentAccount.load())
      .thenAnswer((_) async => account);
  }

  setUp(() {
    loadCurrentAccount = LoadCurrentAccountSpy();
    sut = GetxSplashPresenter(loadCurrentAccount: loadCurrentAccount);
    mockLoadCurrentAccount(account: AccountEntity(token: faker.guid.guid()));
  });

  test('Should call LoadCurrentAccount', () async {
    await sut.checkAccount();

    verify(loadCurrentAccount.load()).called(1);
  });
  
  test('Should got to surveys page on success', () async {
    sut.navigateToStream.listen(expectAsync1((page) => expect(page, '/surveys')));
    
    await sut.checkAccount();
  });

  test('Should got to login page on null result', () async {
    mockLoadCurrentAccount(account: null);
    sut.navigateToStream.listen(expectAsync1((page) => expect(page, '/login')));
    
    await sut.checkAccount();
  });
}
