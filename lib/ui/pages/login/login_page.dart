import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../components/components.dart';
import '../pages.dart';

class LoginPage extends StatelessWidget {
  final LoginPresenter presenter;

  const LoginPage({Key key, @required this.presenter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        presenter.isLoadingStream.listen((isLoading) {
          if (isLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              child: SimpleDialog(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 10),
                      Text('Aguarde...', textAlign: TextAlign.center),
                    ],
                  ),
                ],
              ),
            );
          } else {
            if(Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          }
        });
        
        presenter.mainErrorStream.listen((error) {
          if(error != null) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(error, textAlign: TextAlign.center,),
                backgroundColor: Colors.red[900],
              ),
            );
          }
        });

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LoginHeader(),
              Headline1(
                title: 'Login',
              ),
              Padding(
                padding: const EdgeInsets.all(32),
                child: Form(
                  child: Column(
                    children: [
                      StreamBuilder<String>(
                          stream: presenter.emailErrorStream,
                          builder: (context, snapshot) {
                            return TextFormField(
                              onChanged: presenter.validateEmail,
                              decoration: InputDecoration(
                                labelText: 'E-mail',
                                icon: Icon(
                                  Icons.email,
                                  color: Theme.of(context).primaryColorLight,
                                ),
                                errorText: snapshot.data?.isEmpty == true
                                    ? null
                                    : snapshot.data,
                              ),
                              keyboardType: TextInputType.emailAddress,
                            );
                          }),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 8,
                          bottom: 32,
                        ),
                        child: StreamBuilder<String>(
                            stream: presenter.passwordErrorStream,
                            builder: (context, snapshot) {
                              return TextFormField(
                                onChanged: presenter.validatePassword,
                                decoration: InputDecoration(
                                  labelText: 'Senha',
                                  icon: Icon(
                                    Icons.lock,
                                    color: Theme.of(context).primaryColorLight,
                                  ),
                                  errorText: snapshot.data?.isEmpty == true
                                      ? null
                                      : snapshot.data,
                                ),
                                obscureText: true,
                              );
                            }),
                      ),
                      StreamBuilder<bool>(
                          stream: presenter.isFormValidStream,
                          builder: (context, snapshot) {
                            return RaisedButton(
                              child: Text('Entrar'.toUpperCase()),
                              onPressed: (snapshot.data == true)
                                  ? presenter.auth
                                  : null,
                            );
                          }),
                      FlatButton.icon(
                        icon: Icon(Icons.person),
                        label: Text('Criar Conta'),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}