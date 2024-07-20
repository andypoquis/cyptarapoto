import 'package:cyptarapoto/app/controllers/events_controller.dart';
import 'package:cyptarapoto/app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

class NewEventPage extends GetView<EventsController> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nuevo Evento',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: primaryColor,
        elevation: 1,
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                _buildTitle('Título'),
                _buildTextField(
                    controller.titleController, 'Título del evento'),
                _buildTitle('Descripción'),
                ToolBar(
                  toolBarColor: Colors.cyan.shade50,
                  activeIconColor: Colors.green,
                  padding: const EdgeInsets.all(8),
                  iconSize: 20,
                  controller: controller.htmlInputController,
                  customButtons: [
                    InkWell(onTap: () {}, child: const Icon(Icons.favorite)),
                    InkWell(onTap: () {}, child: const Icon(Icons.add_circle)),
                  ],
                ),
                _buildTextFieldHtml(
                    controller.htmlInputController, 'Descripción del evento'),
                _buildTitle('Fecha de Inicio'),
                _buildTextField(controller.startDateController,
                    '14 de junio de 2024, 12:00:00 a.m. UTC-5'),
                _buildTitle('Fecha de Fin'),
                _buildTextField(controller.endDateController,
                    '14 de junio de 2024, 12:00:00 a.m. UTC-5'),
                _buildTitle('Ubicación'),
                _buildTextField(
                    controller.locationController, 'Ubicación del evento'),
                _buildTitle('Organizador'),
                _buildTextField(
                    controller.organizeController, 'Organizador del evento'),
                _buildTitle('Imagen'),
                _buildTextField(
                    controller.imageController, 'URL de la imagen del evento'),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      controller.addEvent();
                      Get.back();
                    }
                  },
                  child: Text(
                    'Agregar Evento',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: secondaryColor,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    minimumSize: Size(double.infinity, 50),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey[700],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String placeholder,
      {bool isNumeric = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Material(
        elevation: 2.0,
        shadowColor: Colors.grey.withOpacity(0.5),
        borderRadius: BorderRadius.circular(6),
        child: TextFormField(
          controller: controller,
          keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
          decoration: InputDecoration(
            hintText: placeholder,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor ingrese $placeholder';
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget _buildTextFieldHtml(
      QuillEditorController controller, String placeholder,
      {bool isNumeric = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Material(
        elevation: 2.0,
        shadowColor: Colors.grey.withOpacity(0.5),
        borderRadius: BorderRadius.circular(6),
        child: QuillHtmlEditor(
          text: "<h1>Hello</h1>This is a quill html editor example 😊",
          hintText: 'Hint text goes here',
          controller: controller,
          isEnabled: true,
          minHeight: 300,
          hintTextAlign: TextAlign.start,
          padding: const EdgeInsets.only(left: 10, top: 5),
          hintTextPadding: EdgeInsets.zero,
          backgroundColor: Colors.white,
          onFocusChanged: (hasFocus) => debugPrint('has focus $hasFocus'),
          onTextChanged: (text) => debugPrint('widget text change $text'),
          onEditorCreated: () => debugPrint('Editor has been loaded'),
          onEditingComplete: (s) => debugPrint('Editing completed $s'),
          onEditorResized: (height) => debugPrint('Editor resized $height'),
          onSelectionChanged: (sel) => debugPrint('${sel.index},${sel.length}'),
          loadingBuilder: (context) {
            return const Center(
                child: CircularProgressIndicator(
              strokeWidth: 0.4,
            ));
          },
        ),
      ),
    );
  }
}
