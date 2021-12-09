import 'package:app_prueba/src/modules/auth/bloc/global_bloc.dart';
import 'package:app_prueba/src/modules/auth/services/email_and_password_services.dart';
import 'package:app_prueba/src/modules/auth/signup_page.dart';
import 'package:app_prueba/src/widgets/custom_filed_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final _bloc = GlobalAuth.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme:
            IconThemeData(color: Theme.of(context).colorScheme.onSurface),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(30),
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Iniciar sesión',
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(
                height: 20,
              ),
              FieldAuthForm(
                blocStream: _bloc.emailStream,
                onChanged: _bloc.changeEmail,
                textInputType: TextInputType.emailAddress,
                icon: Icons.person_rounded,
                placeholder: 'Correo',
              ),
              FieldAuthForm(
                blocStream: _bloc.passwordStream,
                onChanged: _bloc.changePassword,
                textInputType: TextInputType.text,
                icon: Icons.lock_rounded,
                placeholder: 'Contraseña',
                obscureText: true,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: StreamBuilder(
                        stream: _bloc.formValidStreamLogin.asBroadcastStream(),
                        builder: (context, snapshot) {
                          return ElevatedButton(
                              onPressed: snapshot.hasData
                                  ? () async => await EmailAndPasswordAuth(
                                          context: context)
                                      .userLoginWithEmailAndPassword(
                                          email: _bloc.email,
                                          password: _bloc.password)
                                  : null,
                              child: Text('Iniciar sesión'));
                        }),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => SignupPage()));
                      },
                      child: RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: '¿No tienes una cuenta? ',
                            style: Theme.of(context).textTheme.bodyText2),
                        TextSpan(
                          text: 'Registrate',
                          style: Theme.of(context).textTheme.bodyText1,
                        )
                      ]))),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              AspectRatio(
                aspectRatio: 2 / 1,
                child: SvgPicture.asset('assets/img_2.svg'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
