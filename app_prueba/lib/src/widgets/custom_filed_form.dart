import 'package:flutter/material.dart';

class FieldAuthForm extends StatefulWidget {
  final String placeholder;
  final Stream blocStream;
  final TextInputType textInputType;
  final IconData icon;
  final Function onChanged;
  final bool obscureText;
  final bool showError;

  const FieldAuthForm(
      {@required this.placeholder,
      @required this.blocStream,
      @required this.textInputType,
      @required this.icon,
      @required this.onChanged,
      this.obscureText = false, this.showError = false,});

  @override
  _FieldAuthFormState createState() => _FieldAuthFormState();
}

class _FieldAuthFormState extends State<FieldAuthForm> {

  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
        stream: widget.blocStream,
        builder: (context, snapshot) {
          return Container(
              //padding: EdgeInsets.symmetric(horizontal: 15,),
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onPrimary.withOpacity(.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                keyboardType: widget.textInputType,
                obscureText: widget.obscureText,
                style: Theme.of(context).textTheme.bodyText2,
                decoration: inputWidget(snapshot, context),
                onChanged: widget.onChanged,
              ));
        });
  }

  InputDecoration inputWidget(AsyncSnapshot snapshot, BuildContext context) {
    return InputDecoration(
      hintText: widget.placeholder,
      errorText: widget.showError ? snapshot.error : null,
      hintStyle: TextStyle(color: Theme.of(context).disabledColor),
      labelText: widget.placeholder,
      labelStyle: TextStyle(color: Theme.of(context).disabledColor),
      // focusedBorder: InputBorder.none
      // enabledBorder: InputBorder.none,
      border: InputBorder.none,
      contentPadding: EdgeInsets.symmetric(vertical: 10),
      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 1)),
      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey[50], width: 1)),
      icon: widget.icon != null
          ? Icon(widget.icon, color: Theme.of(context).colorScheme.primary)
          : null,
    );
  }
}
