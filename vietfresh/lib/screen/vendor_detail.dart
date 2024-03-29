import 'package:chat_app/screen/auth.dart';

import 'package:chat_app/style.dart';

import 'package:chat_app/widgets/vendor_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VendorDetail extends ConsumerWidget {
  const VendorDetail({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = firebase.currentUser!;
    return Scaffold(
      appBar: AppBar(
        title:const Text('Cửa Hàng'),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: firestore
              .collection('vendor')
              .where('user_id', isEqualTo: user.uid)
              .snapshots(),
          builder: (ctx, venSnapshot) {
            if (venSnapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (!venSnapshot.hasData || venSnapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text('Không tìm thấy dữ liệu'),
              );
            }
            final vendors = venSnapshot.data!.docs;
            final vendor = vendors.first.data();

            return SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                      ),
                      child: Column(
                        children: [
                          VendorImage(
                            vendorId: vendor['user_id'],
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Style(
                            outputText: vendor['vendor_name'],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: const Color.fromARGB(255, 232, 223, 223),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: ListTile(
                                leading: const Icon(
                                  Icons.account_circle,
                                  color: Color.fromARGB(255, 77, 71, 71),
                                ),
                                title: const Style(
                                    outputText: 'Chi tiết tài khoản'),
                                onTap: () {},
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: ListTile(
                                leading: const Icon(
                                  Icons.report,
                                  color: Color.fromARGB(255, 77, 71, 71),
                                ),
                                title: const Style(outputText: 'Báo cáo'),
                                onTap: () {},
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: ListTile(
                                leading: const Icon(
                                  Icons.help,
                                  color: Color.fromARGB(255, 77, 71, 71),
                                ),
                                title: const Style(outputText: 'Trợ giúp'),
                                onTap: () {},
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

