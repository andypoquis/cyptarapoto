import 'package:cyptarapoto/app/shared/constants.dart';
import 'package:flutter/material.dart';

class MemberCard extends StatelessWidget {
  final String codigo = '62280';
  final String colegiado = 'ABEL CHONG RENGIFO';
  final String telefono = '942663353';
  final String sexo = 'Masculino';
  final String fechaNac = '10/04/1965';
  final String estado = 'HABIL';
  final String direccion =
      'FONAVI MZ H LOTE 24 SAN MARTIN - SAN MARTIN - TARAPOTO';
  final String email = 'achore40@hotmail.com';
  final String dni = '01060673';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.account_circle, size: 40, color: secondaryColor),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      colegiado,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Código: $codigo',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: estado == 'HABIL' ? Colors.green : Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  estado,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.phone, color: secondaryColor),
              SizedBox(width: 10),
              Text(telefono, style: TextStyle(fontSize: 14)),
              Spacer(),
              Icon(Icons.badge, color: secondaryColor),
              SizedBox(width: 10),
              Text(dni, style: TextStyle(fontSize: 14)),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.email, color: secondaryColor),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  email,
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
