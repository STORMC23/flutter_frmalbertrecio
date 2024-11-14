import 'package:flutter/material.dart'; // Importa el paquet de Flutter per a la interfície d'usuari.
import 'Formularis/FrmA.dart'; // Importa el formulari A.
import 'Formularis/FrmB.dart'; // Importa el formulari B.
import 'Formularis/FrmC.dart'; // Importa el formulari C.
import 'Formularis/FrmD.dart'; // Importa el formulari D.
import 'Missatges/SimpleDialog.dart'; // Importa el diàleg simple.
import 'Missatges/AlertDialog.dart'; // Importa el diàleg d'alerta.
import 'Missatges/ShowModalButtonSheet.dart'; // Importa el full de botons modal.
import 'Missatges/ShowSnackBar.dart'; // Importa la barra de notificacions.
import 'Formularis/FrmBBuilder.dart'; // Importa el constructor del formulari B.
import 'Formularis/FrmDBuilder.dart'; // Importa el constructor del formulari D.
import 'Missatges/AlertDialogBuilder.dart';
import 'Missatges/ShowModalButtonSheetBuilder.dart';
import 'Missatges/ShowSnackBarBuilder.dart';
import 'Missatges/SimpleDialogBuilder.dart';

void main() => runApp(const MyApp()); // Funció principal que inicia l'aplicació.

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Constructor de la classe MyApp.

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'ALBERT RECIO 24/25', // Títol de l'aplicació.
      home: MyCustomForm(), // Widget principal de l'aplicació.
    );
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key}); // Constructor de la classe MyCustomForm.
  @override
  State createState() => _MyCustomFormState(); // Crea l'estat per a MyCustomForm.
}

class _MyCustomFormState extends State<MyCustomForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Form Builder"), // Títol de l'AppBar.
        backgroundColor: Colors.blue, // Color de fons de l'AppBar.
      ),
      body: ListView(
        children: [
          const Divider(), // Divisor visual.
          Container(
            width: 200,
            height: 50, 
            alignment: Alignment.center, 
            decoration: BoxDecoration(
              color: Colors.blue, 
              borderRadius: BorderRadius.circular(8), 
            ),
            child: const Text(
              "FORMULARIS", 
              style: TextStyle(
                color: Colors.white, 
                fontSize: 16, 
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(), // Divisor visual.

          // Llista d'elements amb formularis.
          ListTile(
            title: const Text("FORMULARI A"),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FrmA()), // Navega al formulari A.
              );
            },
          ),

          const Divider(), // Divisor visual.

          ListTile(
            title: const Text("FORMULARI B"),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FrmB()), // Navega al formulari B.
              );
            },
          ),

          const Divider(), // Divisor visual.

          ListTile(
            title: const Text("FORMULARI B BUILDER"),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FrmBBuilder()), // Navega al constructor del formulari B.
              );
            },
          ),
          
          const Divider(), // Divisor visual.

          ListTile(
            title: const Text("FORMULARI C"),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FrmC()), // Navega al formulari C.
              );
            },
          ),

          const Divider(), // Divisor visual.

          ListTile(
            title: const Text("FORMULARI D"),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FrmD()), // Navega al formulari D.
              );
            },
          ),

          const Divider(), // Divisor visual.

          ListTile(
            title: const Text("FORMULARI D BUILDER"),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FrmDBuilder()), // Navega al constructor del formulari D.
              );
            },
          ),

          const Divider(), // Divisor visual.

          Container(
            width: 200,
            height: 50, 
            alignment: Alignment.center, 
            decoration: BoxDecoration(
              color: Colors.blue, 
              borderRadius: BorderRadius.circular(8), 
            ),
            child: const Text(
              "MISSATGES", 
              style: TextStyle(
                color: Colors.white, 
                fontSize: 16, 
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          
          const Divider(), // Divisor visual.

          // Llista d'elements amb missatges.
          ListTile(
            title: const Text("ALERTDIALOG"),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FrmAlertDialog()), // Navega al diàleg d'alerta.
              );
            },
          ),

          const Divider(), // Divisor visual.

          // Llista d'elements amb missatges.
          ListTile(
            title: const Text("ALERTDIALOG BUILDER"),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FrmAlertDialogBuilder()), // Navega al diàleg d'alerta.
              );
            },
          ),

          const Divider(), // Divisor visual.

          ListTile(
            title: const Text("SHOWMODALBUTTONSHEET"),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FrmShowModalButtonSheet()), // Navega al full de botons modal.
              );
            },
          ),

          const Divider(), // Divisor visual.

          ListTile(
            title: const Text("SHOWMODALBUTTONSHEET BUILDER"),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FrmShowModalButtonSheetBuilder()), // Navega al full de botons modal.
              );
            },
          ),
          
          const Divider(), // Divisor visual.

          ListTile(
            title: const Text("SHOWSNACKBAR"),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FrmSnackBar()), // Navega a la barra de notificacions.
              );
            },
          ),

          const Divider(), // Divisor visual.

          ListTile(
            title: const Text("SHOWSNACKBAR BUILDER"),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FrmSnackBarBuilder()), // Navega a la barra de notificacions.
              );
            },
          ),

          const Divider(), // Divisor visual.

          ListTile(
            title: const Text("SIMPLEDIALOG"),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FrmSimpledialog()), // Navega al diàleg simple.
              );
            },
          ),

          const Divider(), // Divisor visual.

          ListTile(
            title: const Text("SIMPLEDIALOG BUILDER"),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FrmSimpledialogBuilder()), // Navega al diàleg simple.
              );
            },
          ),
        ],
      ),
    );
  }
}