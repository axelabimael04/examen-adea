import 'package:flutter/material.dart';

void alertWithIcon(BuildContext context,
    {String title, String message, IconData icon}) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          titlePadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          title: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: new BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
              ),
              height: 180,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: Colors.white,
                    size: 80,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ],
              )),
          content: Container(
              padding: EdgeInsets.only(top: 15),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .caption
                    .merge(TextStyle(fontSize: 18)),
              )),
          actions: <Widget>[
            TextButton(
              child: Text('Aceptar'),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        );
      });
}

void informationAlert(BuildContext context, {String message, String title}) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
              ),
              child: Text(
                "Aceptar",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.background,
                ),
              ),
            )
          ],
        );
      });
}

Future<Widget> progressIndicatorForAuth(
    {@required BuildContext context,
    @required String message,
    bool dismissible = false}) {
  return showDialog(
    context: context,
    barrierDismissible: dismissible,
    builder: (BuildContext context) {
      return Dialog(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: new Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              new CircularProgressIndicator(),
              SizedBox(
                width: 10,
              ),
              new Text('   $message'),
            ],
          ),
        ),
      );
    },
  );
}

void confirmSave(BuildContext context, String mensaje, Function doAction, {bool dismissible = true}) {
  showDialog(
    barrierDismissible: dismissible,
      context: context,
      builder: (context) {
        return AlertDialog(
          titleTextStyle: Theme.of(context).textTheme.subtitle1,
          contentTextStyle: Theme.of(context).textTheme.bodyText2,
          title: Text("Información"),
          content: Text(mensaje),
          actions: <Widget>[
            TextButton(
              child: Text("Aceptar"),
              onPressed: doAction,
            )
          ],
        );
      });
}
