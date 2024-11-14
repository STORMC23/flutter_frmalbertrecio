import 'package:flutter/material.dart'; // Paquet principal de Flutter per a la interfície d'usuari.
import 'package:flutter_form_builder/flutter_form_builder.dart'; // Paquet per construir formularis fàcilment.
import 'package:form_builder_validators/form_builder_validators.dart'; // Paquet per validar els camps del formulari.
import 'package:flutter_frmalbertrecio/main.dart'; // Importació del fitxer principal de l'aplicació.

class FrmSimpledialogBuilder extends StatelessWidget {
  const FrmSimpledialogBuilder({super.key});

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
  final _formKey = GlobalKey<FormBuilderState>(); // Clau per identificar el formulari i accedir al seu estat.

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
        child: FormBuilder(
          key: _formKey, // Assigna la clau al formulari.
          child: FormBuilderTextField(
            name: 'textField', // Nom del camp de text.
            decoration: const InputDecoration(
              labelText: 'Introdueix un valor', // Etiqueta del camp de text.
            ),
            validator: FormBuilderValidators.required(errorText: 'Aquest camp és obligatori.'), // Validació per requerir el camp.
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final textFieldValue = _formKey.currentState?.fields['textField']?.value; // Recupera el valor del camp de text.
          showDialog(
            context: context,
            builder: (context) {
              return SimpleDialog(
                title: Text(textFieldValue == null || textFieldValue.isEmpty ? "Advertència" : "SimpleDialog"), // Títol del diàleg.
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0), // Màrgenes de 16 píxels al voltant del text.
                    child: Text(textFieldValue == null || textFieldValue.isEmpty ? "No s'ha introduït res." : textFieldValue), // Mostra el text introduït o un missatge si està buit.
                  ),
                  if (textFieldValue == null || textFieldValue.isEmpty)
                    TextButton(
                      child: const Text("D'acord"), // Botó per tancar el diàleg.
                      onPressed: () {
                        Navigator.of(context).pop(); // Tanca el diàleg.
                      },
                    ),
                ],
              );
            },
          );
        },
        tooltip: 'Mostrar el valor!', // Text que es mostra quan es manté premut el botó.
        child: const Icon(Icons.text_fields), // Icona del botó flotant.
      ),
    );
  }
}