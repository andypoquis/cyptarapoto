import 'package:cached_network_image/cached_network_image.dart';
import 'package:cyptarapoto/app/ui/pages/viewevent_page/viewevent_page.dart';
import 'package:cyptarapoto/app/widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../controllers/home_controller.dart';
import '../../../data/models/event_model.dart';
import '../../../shared/constants.dart';

class HomePage extends GetView<HomeController> {
  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final Size sizeScreen = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => controller.navigationToProfile(),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                              'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png', // URL de la imagen de perfil
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Obx(() => Text(
                              'HOLA, ${controller.getFirstName()}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                        Spacer(),
                        Icon(Icons.notifications_outlined),
                      ],
                    ),
                    SizedBox(height: 20),
                    SearchWidget(),
                  ],
                ),
              ),
              Obx(() => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: GestureDetector(
                      onTap: () => Get.bottomSheet(
                          Container(
                            width: sizeScreen.width,
                            height: sizeScreen.height * 0.65,
                            padding: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.redAccent,
                                      borderRadius: BorderRadius.circular(12)),
                                  child: const Text(
                                    'FORMAS DE PAGO',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  'CUENTA A NOMBRE DEL CIP CDSM - TARAPOTO:',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  'CUENTA BBVA: 0011-0310-0100062424',
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                const Text(
                                  'CCI: CCI 011-310-000100062424-05',
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  '- Enviar comprobante del depósito al whatsapp de caja CIP 942 637 236 CON REFERENCIA (NOMBRE).',
                                  style: TextStyle(color: Colors.red[300]),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'TRANSFERENCIA:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Image.network(
                                        'https://seeklogo.com/images/Y/yape-app-logo-1FD46D1120-seeklogo.com.png',
                                        scale: 16,
                                      ),
                                      Image.network(
                                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQN94zsmpdqN7p2ugqBBrPygthpvfIsDB4QJA&sg',
                                        scale: 12,
                                      )
                                    ],
                                  ),
                                ),
                                Center(
                                  child: QrImageView(
                                    data:
                                        '00020101021102164096230055267231041553015000552672309166499890055267230123900111000000040610740883968607005526723726650011FACILITADOR0146IZIPAYVIR;1692196816050;5526723;942690155;;;;252048641530360454030.05802PE5921IZI*CIP CDSM TARAPOTO6008TARAPOTO6103PER82270009FECHAVCTO01102033-08-16630469AE',
                                    version: QrVersions.auto,
                                    size: sizeScreen.height * 0.16,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Center(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(
                                          0xFF25D366), // Color verde de WhatsApp
                                      minimumSize: Size(125,
                                          35), // Ancho y alto predeterminados
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            10), // Bordes redondeados
                                      ),
                                    ),
                                    onPressed: () => controller.openWhatsapp(),
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(FontAwesome.whatsapp_brand,
                                            color: Colors.white),
                                        SizedBox(width: 8),
                                        Text(
                                          'Caja CIP',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          backgroundColor: Colors.white),
                      child: MemberCard(
                        nombre: controller.collegiate.value.member,
                        codigo: controller.collegiate.value.code,
                        estado: controller.collegiate.value.status
                            ? 'HABILITADO'
                            : 'INHABILITADO',
                        imageUrl: 'https://www.cip.org.pe/images/LOGO_CIP.png',
                      ),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Eventos',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Obx(() {
                if (controller.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: controller.events.map((event) {
                      return EventCard(
                        event: event,
                        onViewEvent: () {
                          Get.to(() => VieweventPage(eventId: event.id));
                        },
                      );
                    }).toList(),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final Event event;
  final VoidCallback onViewEvent;

  EventCard({required this.event, required this.onViewEvent});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Color(0xffFFFFFF),
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            child: CachedNetworkImage(
              imageUrl: event.image.isNotEmpty
                  ? event.image
                  : 'https://www.cip.org.pe/wp-content/uploads/2024/05/semana-de-la-ingeniera-nacional-2020-eventos-generales.jpg',
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title.isNotEmpty ? event.title : 'Evento sin título',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  event.endDate,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Ubicación: ${event.location}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: onViewEvent,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      'Ver Evento',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MemberCard extends StatelessWidget {
  final String nombre;
  final String codigo;
  final String estado;
  final String imageUrl;

  MemberCard({
    required this.nombre,
    required this.codigo,
    required this.estado,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final firstName = nombre.split(' ').first;
    final lastName = nombre.split(' ').length > 1 ? nombre.split(' ')[1] : '';

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      padding: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: bgcolor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image.network(
              imageUrl,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$firstName $lastName',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'Código: $codigo',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: estado == 'HABILITADO' ? Colors.green : Colors.red,
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
        ],
      ),
    );
  }
}
