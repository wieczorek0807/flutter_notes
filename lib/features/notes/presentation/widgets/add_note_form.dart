import 'package:flutter/material.dart';
import 'package:flutter_notes/core/extensions/build_context_ext.dart';

class AddNoteForm extends StatelessWidget {
  const AddNoteForm({super.key, required this.controller, required this.formKey});
  final TextEditingController controller;
  final GlobalKey<FormState> formKey;

  final _minLines = 3;
  final _maxLines = 50;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: TextFormField(
        controller: controller,
        minLines: _minLines,
        maxLines: _maxLines,
        decoration: InputDecoration(
          hintText: context.appLocalizations.addNoteHint,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
