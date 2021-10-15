import 'package:example/utils/database.dart';
import 'package:example/utils/validator.dart';
import 'package:flutter/material.dart';

class EditUserForm extends StatefulWidget {
  final FocusNode nameFocusNode;
  final FocusNode companyFocusNode;
  final FocusNode ageFocusNode;
  final String currentName;
  final String currentCompany;
  final String currentAge;
  final String documentId;

  EditUserForm(
      {required this.nameFocusNode,
      required this.companyFocusNode,
      required this.ageFocusNode,
      required this.currentName,
      required this.currentCompany,
      required this.currentAge,
      required this.documentId,
      Key? key})
      : super(key: key);

  @override
  _EditUserFormState createState() => _EditUserFormState();
}

class _EditUserFormState extends State<EditUserForm> {
  late TextEditingController _nameController = TextEditingController();
  late TextEditingController _companyController = TextEditingController();
  late TextEditingController _ageController = TextEditingController();

  bool _isProcessing = false;

  @override
  void initState() {
    _nameController = TextEditingController(text: widget.currentName);
    _companyController = TextEditingController(text: widget.currentCompany);
    _ageController = TextEditingController(text: widget.currentAge);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Text('ID:'+widget.documentId),
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
                      await Database.updateUser(
                        fullName: _nameController.text,
                        company: _companyController.text,
                        age: _ageController.text,
                        docId: widget.documentId,
                      );
                      setState(() {
                        _isProcessing = false;
                      });
                      Navigator.pop(context);
                    },
                    child: Text('Actualizar'),
                  ),
                ),
        ],
      ),
    );
  }
}
