import 'package:faker/faker.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:meta/meta.dart';

class HttpAdapter {
  final Client client;

  HttpAdapter(this.client);

  Future<void> request({
    @required String url,
    @required String method,
  }) async {
    final headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    await client.post(url, headers: headers);
  }
}

class ClientSpy extends Mock implements Client {}

HttpAdapter sut;
ClientSpy client;
String url;

void main() {
  setUp(() {
    client = ClientSpy();
    sut = HttpAdapter(client);
    url = faker.internet.httpUrl();
  });

  group('post', () {
    test('Should call post with corret values', () async {
      await sut.request(url: url, method: 'post');

      verify(
        client.post(
          url,
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
    });
  });
}