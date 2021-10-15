import 'package:example/utils/database.dart';
import 'package:example/utils/validator.dart';
import 'package:flutter/material.dart';

class AddUserForm extends StatefulWidget {
  final FocusNode nameFocusNode;
  final FocusNode companyFocusNode;
  final FocusNode ageFocusNode;
  AddUserForm(
      {required this.nameFocusNode,
      required this.companyFocusNode,
      required this.ageFocusNode,
      Key? key})
      : super(key: key);

  @override
  _AddUserFormState createState() => _AddUserFormState();
}

class _AddUserFormState extends State<AddUserForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            controller: _nameController,
            focusNode: widget.nameFocusNode,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            validator: (value) => Validator.validateField(
              value: value.toString(),
            ),
            decoration: InputDecoration(
              label: Text('Nombre'),
              hintText: 'Ingrese su nombre',
            ),
          ),
          TextFormField(
            controller: _companyController,
            focusNode: widget.companyFocusNode,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            validator: (value) => Validator.validateField(
              value: value.toString(),
            ),
            decoration: InputDecoration(
              label: Text('Empresa'),
              hintText: 'Ingrese su empresa',
            ),
          ),
          TextFormField(
            controller: _ageController,
            focusNode: widget.ageFocusNode,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            validator: (value) => Validator.validateField(
              value: value.toString(),
            ),
            decoration: InputDecoration(
              label: Text('Edad'),
              hintText: 'Ingrese su edad',
            ),
          ),
          _isProcessing
              ? Padding(
                  padding: EdgeInsets.all(16),
                  child: CircularProgressIndicator(),
                )
              : Container(
                  child: ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        _isProcessing = true;
                      });
                      await Database.addUser(
                        fullName: _nameController.text,
                        company: _companyController.text,
                        age: _ageController.text,
                      );
                      setState(() {
                        _isProcessing = false;
                      });
                      Navigator.pop(context);
                    },
                    child: Text('Enviar'),
                  ),
                ),
        ],
      ),
    );
  }
}
