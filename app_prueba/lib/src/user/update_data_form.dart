import 'package:app_prueba/src/firebase/firebase_bridge.dart';
import 'package:app_prueba/src/modules/models/user_model.dart';
import 'package:flutter/material.dart';

class UpdateUserDataForm extends StatefulWidget {
  final UserModel user;

  const UpdateUserDataForm({@required this.user});

  @override
  _UpdateUserDataFormState createState() => _UpdateUserDataFormState();
}

class _UpdateUserDataFormState extends State<UpdateUserDataForm> {
  String name;
  String age;
  String rfc;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _rfcController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      name = widget.user.fullName;
      age = widget.user.age;
      rfc = widget.user.rfc.toUpperCase();

      _nameController.text = name;
      _ageController.text = age;
      _rfcController.text = rfc.toUpperCase();
    });
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Actualizar datos'),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            CustomField(
              placeholder: 'Nombre', 
              controller: _nameController, 
              textInputType: TextInputType.text, 
              error: validateName(name),
              onChanged: (value){
                setState(() {
                  name = value;
                });
              },
            ),
            CustomField(
              placeholder: 'Edad', 
              controller: _ageController, 
              textInputType: TextInputType.number, 
              error: validateAge(age),
              onChanged: (value){
                setState(() {
                  age = value;
                });
              },
            ),
            CustomField(
              placeholder: 'RFC', 
              controller: _rfcController, 
              textInputType: TextInputType.text, 
              error: validateRFC(rfc),
              textCapitalization: TextCapitalization.words,
              onChanged: (value){
                setState(() {
                  rfc = value.toString().toUpperCase();
                });
              },
            ),

            SizedBox(height: 20,),


            ElevatedButton(onPressed: name.isNotEmpty && age.isNotEmpty && rfc.length == 13
            ? () async => FirebaseBridge().updateUserData(
              context,
              UserModel(fullName: name, age: age, rfc: rfc)
              ) : null, child: Text('Actualizar'))
          ],
        ),
      ),
    );
  }

  String validateName(String value) {
    if (value.isEmpty)  {
      return "Campo requerido";
    }
    return null;
  }

  String validateAge(String value) {
    if (value.isEmpty) {
      return "Campo requerido";
    }
    return null;
  }

  String validateRFC(String value) {
    if (value.isEmpty || value.length != 13) {
      return "Campo requerido - 13 dígitos";
    }
    return null;
  }

  
}

class CustomField extends StatefulWidget {
  final String placeholder;
  final TextEditingController controller;
  final TextInputType textInputType;
  final Function onChanged;
  final bool obscureText;
  final String error;
  final TextCapitalization textCapitalization;

  const CustomField(
      {@required this.placeholder,
      @required this.controller,
      @required this.textInputType,
      @required this.onChanged,
      this.obscureText = false, this.error, this.textCapitalization,});

  @override
  _CustomFieldState createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {

  @override
  Widget build(BuildContext context) {

    return Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onPrimary.withOpacity(.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                textCapitalization: widget.textCapitalization,
                controller: widget.controller,
                keyboardType: widget.textInputType,
                obscureText: widget.obscureText,
                style: Theme.of(context).textTheme.bodyText2,
                decoration: inputWidget(context),
                onChanged: widget.onChanged,
              ));
  }

  InputDecoration inputWidget(BuildContext context) {
    return InputDecoration(
      hintText: widget.placeholder,
      errorText: widget.error ,
      hintStyle: TextStyle(color: Theme.of(context).disabledColor),
      labelText: widget.placeholder,
      labelStyle: TextStyle(color: Theme.of(context).disabledColor),
      border: InputBorder.none,
      contentPadding: EdgeInsets.symmetric(vertical: 10),
      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 1)),
      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey[50], width: 1)),
    );
  }
}
