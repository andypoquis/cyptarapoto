import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/collegiates_controller.dart';

class CollegiatesPage extends StatelessWidget {
  final controller = Get.put(CollegiatesController());
  final ScrollController _scrollController = ScrollController();

  CollegiatesPage() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          controller.hasMore.value &&
          !controller.isLoading.value) {
        controller.loadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Colegiados'),
      ),
      body: SafeArea(
        child: Obx(() {
          if (controller.collegiates.isEmpty && controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            controller: _scrollController,
            itemCount: controller.collegiates.length + 1,
            itemBuilder: (context, index) {
              if (index == controller.collegiates.length) {
                if (controller.hasMore.value) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return Center(child: Text('No more data'));
                }
              }
              final collegiate = controller.collegiates[index];
              return Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow('Member', collegiate.member),
                    _buildInfoRow('Email', collegiate.email),
                    _buildInfoRow('Phone', collegiate.phone.toString()),
                    _buildInfoRow('ID', collegiate.id.toString()),
                    _buildInfoRow(
                        'Status', collegiate.status ? 'Active' : 'Inactive'),
                  ],
                ),
              );
            },
          );
        }),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            '$title: ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
