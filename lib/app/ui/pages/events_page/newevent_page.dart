import 'dart:io';

import 'package:cyptarapoto/app/controllers/events_controller.dart';
import 'package:cyptarapoto/app/shared/constants.dart';
import 'package:cyptarapoto/app/ui/pages/events_page/widgets/calendar_selector.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

class NewEventPage extends GetView<EventsController> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? arguments =
        Get.arguments as Map<String, dynamic>?;
    final bool isEdit = arguments?['isEdit'] ?? false;
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        title: Text(
          isEdit ? 'Editar Evento' : 'Nuevo Evento',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          isEdit
              ? IconButton(
                  onPressed: () => controller.deleteEvent(),
                  icon: const Icon(Icons.delete))
              : Container()
        ],
        backgroundColor: primaryColor,
        elevation: 1,
        iconTheme: IconThemeData(
          color: Colors
              .white, // Cambia el color de la flecha de retroceso a blanco
        ),
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
                _buildTitle('Fecha de Evento'),
                const CalendarSelector(),
                _buildTitle('Ubicación'),
                _buildTextField(
                    controller.locationController, 'Ubicación del evento'),
                _buildTitle('Organizador'),
                _buildTextField(
                    controller.organizeController, 'Organizador del evento'),
                _buildTitle('Imagen'),
                _buildImagePicker(context),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (isEdit) {
                        controller.editEvent();
                      } else {
                        controller.addEvent();
                      }
                      Get.back();
                    }
                  },
                  child: Text(
                    isEdit ? 'Editar Evento' : 'Agregar Evento',
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
          text: "<h1>Evento</h1>Redactar Evento",
          hintText: 'Ingresar evento',
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

  Widget _buildImagePicker(BuildContext context) {
    return Obx(() {
      return GestureDetector(
        onTap: () async {
          FilePickerResult? result = await FilePicker.platform.pickFiles();

          if (result != null) {
            controller.imageFile.value = File(result.files.single.path!);
            controller.imageName.value = result.files.single.name;
            print("Imagen seleccionada: ${result.files.single.name}");
          } else {
            // El usuario canceló el selector de archivos
          }
        },
        child: Container(
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey),
            color: Colors.grey[200],
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.upload_file, size: 40, color: Colors.grey[700]),
                SizedBox(height: 8),
                Text(
                  'Arrastra tus archivos aquí para subirlos',
                  style: TextStyle(color: Colors.grey[700]),
                ),
                if (controller.imageName.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Imagen seleccionada: ${controller.imageName.value}',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
