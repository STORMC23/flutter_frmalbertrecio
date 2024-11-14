import 'package:flutter/material.dart'; // Paquet principal de Flutter per a la interfície d'usuari.
import 'package:flutter_frmalbertrecio/main.dart'; // Importació del fitxer principal de l'aplicació.

class FrmSnackBar extends StatelessWidget {
  const FrmSnackBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo', 
      home: MyCustomForm(), 
    );
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  State createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  final myController = TextEditingController(); // Controlador per gestionar el text introduït al TextField.

  @override
  void dispose() {
    myController.dispose(); // Allibera els recursos del controlador quan el widget es destrueix.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue, // Color de fons de la barra d'aplicació.
        title: const Text("Recuperar el valor d'un camp de text"), // Títol de la barra d'aplicació.
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Icona de la fletxa enrere.
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const MyApp()), // Navega a la pàgina principal.
              (Route route) => false,
            ); 
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16), // Màrgenes de 16 píxels al voltant del cos.
        child: TextField(
          controller: myController, // Assigna el controlador al TextField.
          decoration: const InputDecoration(
            labelText: 'Introdueix un valor', // Etiqueta del camp de text.
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (myController.text.isEmpty) {
            // Mostra un SnackBar si el camp de text està buit.
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("No s'ha introduït res."), // Missatge que es mostra si no s'ha introduït res.
              ),
            );
          } else {
            // Mostra un SnackBar amb el valor introduït si el camp de text no està buit.
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(myController.text), // Mostra el text introduït.
                action: SnackBarAction(
                  label: 'Tornar a introduir', // Etiqueta del botó d'acció.
                  onPressed: () {
                    // Permet tornar a introduir un altre missatge.
                  },
                ),
              ),
            );
          }
        },
        tooltip: 'Mostrar el valor!', // Text que es mostra quan es manté premut el botó.
        child: const Icon(Icons.text_fields), // Icona del botó flotant.
      ),
    );
  }
}