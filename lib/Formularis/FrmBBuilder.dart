import 'package:flutter/material.dart'; // Paquet principal de Flutter per a la interfície d'usuari.
import 'package:flutter_form_builder/flutter_form_builder.dart'; // Paquet per construir formularis fàcilment.
import 'package:form_builder_validators/form_builder_validators.dart'; // Paquet per validar els camps del formulari.

class FrmBBuilder extends StatefulWidget {
  @override
  _FrmB createState() => _FrmB();
}

class _FrmB extends State<FrmBBuilder> {
  int pasActual = 0; 
  final _clauFormulari = GlobalKey<FormBuilderState>(); 

  // Funció que retorna la llista de passos del Stepper.
  List<Step> llistaPassos() {
    return [
      // Pas 1: Informació Personal
      Step(
        title: const Text('Pers.'),
        content: const Text('Personal'), 
        isActive: pasActual >= 0, // Indica si el pas està actiu.
        state: pasActual > 0 ? StepState.complete : StepState.indexed, // Estat del pas.
      ),
      // Pas 2: Informació de Contacte
      Step(
        title: const Text('Contacte'), 
        content: const Text('Contacte'), 
        isActive: pasActual >= 1, // Indica si el pas està actiu.
        state: pasActual > 1 ? StepState.complete : StepState.indexed, // Estat del pas.
      ),
      // Pas 3: Formulari de Carregar
      Step(
        title: const Text('Carregar'), 
        content: FormBuilder(
          key: _clauFormulari, 
          child: Column(
            children: [
              // Camp de correu electrònic
              FormBuilderTextField(
                name: 'correu', 
                decoration: InputDecoration(
                  labelText: 'Correu electrònic',
                  prefixIcon: Icon(Icons.email),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(), // Validació per requerir el camp.
                  FormBuilderValidators.email(), // Validació per assegurar que és un correu electrònic vàlid.
                ]),
              ),
              SizedBox(height: 8), // Espai vertical entre els camps.
              // Camp d'adreça
              FormBuilderTextField(
                name: 'adreca', 
                decoration: InputDecoration(
                  labelText: 'Adreça',
                  prefixIcon: Icon(Icons.home), // Icona prefixada.
                ),
                validator: FormBuilderValidators.required(), // Validació per requerir el camp.
              ),
              SizedBox(height: 8), // Espai vertical entre els camps.
              // Camp de telèfon mòbil
              FormBuilderTextField(
                name: 'telefon', 
                decoration: InputDecoration(
                  labelText: 'Telèfon mòbil',
                  prefixIcon: Icon(Icons.phone), // Icona prefixada.
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(), // Validació per requerir el camp.
                  FormBuilderValidators.phoneNumber(
                    regex: RegExp(r'^\d{9}$'), // Expressió regular per validar el número de telèfon.
                    errorText: 'Introdueix un número de telèfon vàlid', // Missatge d'error si no és vàlid.
                  ),
                ]),
              ),
            ],
          ),
        ),
        isActive: pasActual >= 2, // Indica si el pas està actiu.
        state: pasActual == 2 ? StepState.indexed : StepState.indexed, // Estat del pas.
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Salesians Sarrià 24/25")), // Barra d'aplicació amb títol.
      body: Stepper(
        type: StepperType.horizontal, // Tipus de Stepper (horizontal).
        currentStep: pasActual, // Pas actual del Stepper.
        onStepTapped: (step) => setState(() => pasActual = step), // Acció quan es toca un pas.
        onStepContinue: () {
          if (pasActual == llistaPassos().length - 1) {
            if (_clauFormulari.currentState?.saveAndValidate() ?? false) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Formulari completat correctament!')), // Missatge de confirmació.
              );
            }
          } else {
            setState(() => pasActual++); // Avança al següent pas.
          }
        },
        onStepCancel: () {
          if (pasActual > 0) setState(() => pasActual--); // Retrocedeix al pas anterior.
        },
        steps: llistaPassos(), // Llista de passos del Stepper.
      ),
    );
  }
}