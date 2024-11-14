import 'package:flutter/material.dart';

class FrmB extends StatefulWidget {
  @override
  _FrmB createState() => _FrmB();
}

class _FrmB extends State<FrmB> {
  // Variable per controlar el pas actual del Stepper
  int pasActual = 0;

  // Clau global per al formulari, que ens permetrà validar-lo
  final _clauFormulari = GlobalKey<FormState>();

  // Controladors per accedir al valor dels TextFields
  final TextEditingController _correuControlador = TextEditingController();
  final TextEditingController _adrecaControlador = TextEditingController();
  final TextEditingController _telefonControlador = TextEditingController();

  // Funció que retorna la llista de passos per al Stepper
  List<Step> llistaPassos() {
    return [
      Step(
        title: const Text('Pers.'),
        content: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Títol del pas 1
            Text(
              'Personal',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text('Pulsi "Contact" o pulsi el botó de "Continuar".'),
          ],
        ),
        isActive: pasActual >= 0, // Indica si el pas és actiu
        state: pasActual > 0 ? StepState.complete : StepState.indexed, // Indica l'estat del pas
      ),
      Step(
        title: const Text('Contacte'),
        content: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Títol del pas 2
            Text(
              'Contacte',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text('Pulsi "Carregar" o pulsi el botó de "Continuar".'),
          ],
        ),
        isActive: pasActual >= 1, // Indica si el pas és actiu
        state: pasActual > 1 ? StepState.complete : StepState.indexed, // Indica l'estat del pas
      ),
      Step(
        title: const Text('Carregar'),
        content: Form(
          key: _clauFormulari,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Un TextFormField és un camp de text que permet a l'usuari introduir dades. Pot incloure validació per assegurar que les dades introduïdes són correctes.
              // Camp per introduir el correu electrònic
              TextFormField(
                controller: _correuControlador,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Correu electrònic',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                // Els validators s'utilitzen per assegurar que les dades introduïdes per l'usuari compleixen certs criteris. Aquí, el validator comprova que el camp no estigui buit i que el correu electrònic tingui un format vàlid.
                validator: (valor) {
                  if (valor == null || valor.isEmpty) {
                    return 'Introdueix el teu correu electrònic';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(valor)) {
                    return 'Introdueix una adreça de correu vàlida';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8),
              // Camp per introduir l'adreça
              TextFormField(
                controller: _adrecaControlador,
                maxLines: null,
                decoration: InputDecoration(
                  labelText: 'Adreça',
                  prefixIcon: Icon(Icons.home),
                  border: OutlineInputBorder(),
                ),
                // Aquí, el validator comprova que el camp d'adreça no estigui buit.
                validator: (valor) {
                  if (valor == null || valor.isEmpty) {
                    return 'Introdueix la teva adreça';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8),
              // Camp per introduir el número de telèfon mòbil
              TextFormField(
                controller: _telefonControlador,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Telèfon mòbil',
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                ),
                // El validator aquí comprova que el camp no estigui buit i que el número de telèfon tingui un format vàlid (9 dígits).
                validator: (valor) {
                  if (valor == null || valor.isEmpty) {
                    return 'Introdueix el teu número de telèfon mòbil';
                  }
                  if (!RegExp(r'^\d{9}$').hasMatch(valor)) {
                    return 'Introdueix un número de telèfon vàlid';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        isActive: pasActual >= 2, // Indica si el pas és actiu
        state: pasActual == 2 ? StepState.indexed : StepState.indexed, // Indica l'estat del pas
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Salesians Sarrià 24/25"),
        backgroundColor: Colors.blue[300],
      ),
      body: Column(
        children: [
          Expanded(
            child: Stepper(
              type: StepperType.horizontal, // Stepper horitzontal
              currentStep: pasActual, // Pas actual del Stepper
              onStepTapped: (pas) {
                setState(() {
                  pasActual = pas;
                });
              },
              onStepContinue: () {
                if (pasActual == llistaPassos().length - 1) {
                  if (_clauFormulari.currentState?.validate() ?? false) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Formulari completat correctament!')),
                    );
                  }
                } else {
                  setState(() {
                    pasActual++;
                  });
                }
              },
              onStepCancel: () {
                if (pasActual > 0) {
                  setState(() {
                    pasActual--;
                  });
                }
              },
              steps: llistaPassos(), // Llista de passos del Stepper
            ),
          ),
        ],
      ),
    );
  }
}