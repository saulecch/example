import 'package:example/utils/database.dart';
import 'package:example/widgets/edit_form.dart';
import 'package:flutter/material.dart';

class EditUserScreen extends StatefulWidget {
  final String currentName;
  final String currentCompany;
  final String currentAge;
  final String documentId;

  EditUserScreen(
      {required this.currentName,
      required this.currentCompany,
      required this.currentAge,
      required this.documentId,
      Key? key})
      : super(key: key);

  @override
  _EditUserScreenState createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _companyFocusNode = FocusNode();
  final FocusNode _ageFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _nameFocusNode.unfocus();
        _companyFocusNode.unfocus();
        _ageFocusNode.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Editar Usuario'),
          actions: [
            IconButton(
                onPressed: () async {
                  await Database.deleteUser(docId: widget.documentId);
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ))
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: EditUserForm(
                nameFocusNode: _nameFocusNode,
                companyFocusNode: _companyFocusNode,
                ageFocusNode: _ageFocusNode,
                currentName: widget.currentName,
                currentCompany: widget.currentCompany,
                currentAge: widget.currentAge,
                documentId: widget.documentId),
          ),
        ),
      ),
    );
  }
}
