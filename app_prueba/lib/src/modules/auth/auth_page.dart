import 'package:app_prueba/src/modules/auth/login_page.dart';
import 'package:app_prueba/src/modules/auth/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthPage extends StatefulWidget {

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(30),
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Bienvenido a\nPrueba App', 
                style: Theme.of(context).textTheme.headline5,
                textAlign: TextAlign.center,
              ),
              SvgPicture.asset('assets/img_1.svg'),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_)=> LoginPage()));
                      }, 
                      child: Text('Iniciar sesión')
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_)=> SignupPage()));
                      }, 
                      child: Text('Regístrate')
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}