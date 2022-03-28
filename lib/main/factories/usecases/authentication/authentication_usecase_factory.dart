import '../../../../data/usecases/usecases.dart';

import '../../../../domain/usecases/usecases.dart';

import '../../factories.dart';

Authentication makeRemoteAuthentication() {
  return RemoteAuthentication(
    url: makeApiUrl(path: 'login'),
    httpClient: makeHttpAdapter(),
  );
}