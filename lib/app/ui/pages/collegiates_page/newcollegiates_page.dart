import 'package:cyptarapoto/app/controllers/collegiates_controller.dart';
import 'package:cyptarapoto/app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewCollegiatesPage extends GetView<CollegiatesController> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? arguments =
        Get.arguments as Map<String, dynamic>?;
    final bool isEdit = arguments?['isEdit'] ?? false;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEdit ? 'Editar Colegiado' : 'Nuevo Colegiado',
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
                _buildTitle('Dirección'),
                _buildTextField(controller.addressController,
                    'JR. SAN MARTIN 923-A SAN MARTIN - SAN MARTIN - TARAPOTO'),
                _buildTitle('Fecha de Nacimiento'),
                _buildTextField(controller.birthdateController, '29/12/1979'),
                _buildTitle('Código'),
                _buildTextField(controller.codeController, '114517'),
                _buildTitle('Email'),
                _buildTextField(controller.emailController,
                    'albertopandurogonzalez@gmail.com'),
                _buildTitle('Género'),
                _buildTextField(controller.genderController, 'Masculino'),
                _buildTitle('ID'),
                _buildTextField(controller.idController, '40686843',
                    isNumeric: true),
                _buildTitle('Nombre'),
                _buildTextField(
                    controller.memberController, 'ALBERTO PANDURO GONZALEZ'),
                _buildTitle('Teléfono'),
                _buildTextField(controller.phoneController, '927820308',
                    isNumeric: true),
                _buildTitle('Estado'),
                _buildSwitchField(controller.statusController),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (isEdit) {
                        controller.editCollegiate();
                      } else {
                        controller.addCollegiate();
                      }
                      Get.back();
                    }
                  },
                  child: Text(
                    isEdit ? 'Editar Colegiado' : 'Agregar Colegiado',
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
              return 'Este campo es obligatorio';
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget _buildSwitchField(RxBool controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Estado', style: TextStyle(fontSize: 16)),
          Obx(() => Switch(
                value: controller.value,
                onChanged: (value) => controller.value = value,
                activeColor: primaryColor,
              )),
        ],
      ),
    );
  }
}
