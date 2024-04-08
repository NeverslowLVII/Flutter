import 'package:flutter/material.dart';

class CityForm extends StatefulWidget {
  final Function(String) onCitySubmitted;

  const CityForm({super.key, required this.onCitySubmitted});

  @override
  CityFormState createState() => CityFormState();
}

class CityFormState extends State<CityForm> {
  final _formKey = GlobalKey<FormState>();
  final _cityNameController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      widget.onCitySubmitted(_cityNameController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: _cityNameController,
            decoration: const InputDecoration(
              labelText: 'Enter city name',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _cityNameController.dispose();
    super.dispose();
  }
}
