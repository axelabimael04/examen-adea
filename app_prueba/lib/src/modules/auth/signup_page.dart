import 'package:app_prueba/src/modules/auth/bloc/global_bloc.dart';
import 'package:app_prueba/src/modules/auth/login_page.dart';
import 'package:app_prueba/src/modules/auth/services/email_and_password_services.dart';
import 'package:app_prueba/src/widgets/custom_filed_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
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
                'Registrate',
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(
                height: 20,
              ),
              FieldAuthForm(
                blocStream: _bloc.userNameStream,
                onChanged: _bloc.changeUserName,
                textInputType: TextInputType.text,
                icon: Icons.person_rounded,
                placeholder: 'Nombre',
                showError: true,
              ),
              FieldAuthForm(
                blocStream: _bloc.emailStream,
                onChanged: _bloc.changeEmail,
                textInputType: TextInputType.emailAddress,
                icon: Icons.person_rounded,
                placeholder: 'Correo',
                showError: true,
              ),
              FieldAuthForm(
                blocStream: _bloc.passwordStream,
                onChanged: _bloc.changePassword,
                textInputType: TextInputType.text,
                icon: Icons.lock_rounded,
                placeholder: 'Contraseña',
                obscureText: true,
                showError: true,
              ),
              FieldAuthForm(
                blocStream: _bloc.passwordConfirmStream,
                onChanged: _bloc.changeConfirmPassword,
                textInputType: TextInputType.text,
                icon: Icons.lock_rounded,
                placeholder: 'Confirmar contraseña',
                obscureText: true,
                showError: true,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: StreamBuilder(
                        stream: _bloc.formValidStreamSignUp.asBroadcastStream(),
                        builder: (context, snapshot) {
                          return ElevatedButton(
                              onPressed: snapshot.hasData
                                  ? () => EmailAndPasswordAuth(context: context)
                                      .createUserWithEmailAndPassword(
                                          context: context,
                                          email: _bloc.email,
                                          password: _bloc.password,
                                          fullName: _bloc.userName)
                                  : null,
                              child: Text('Regístrate'));
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
                            MaterialPageRoute(builder: (_) => LoginPage()));
                      },
                      child: RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: '¿Ya tienes una cuenta? ',
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
                child: SvgPicture.asset('assets/img_3.svg'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
