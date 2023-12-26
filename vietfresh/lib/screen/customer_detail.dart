import 'package:chat_app/provider/customer_provider.dart';
import 'package:chat_app/screen/auth.dart';
import 'package:chat_app/screen/products.dart';
import 'package:chat_app/screen/tabs_vendor.dart';
import 'package:chat_app/screen/vendor_information.dart';
import 'package:chat_app/screen/verify_email.dart';
import 'package:chat_app/style.dart';
import 'package:chat_app/widgets/user_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomerDetail extends ConsumerWidget {
  const CustomerDetail({super.key});

  Future<bool> checkVendorInfoEntered() async {
    final user = firebase.currentUser!;

    // Lấy thông tin cửa hàng từ Firestore
    final vendorInfo = await firestore.collection('vendor').where('user_id', isEqualTo: user.uid).get();
    return vendorInfo.docs.isNotEmpty;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userName = ref.watch(userProvider).userName;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 40,
                  horizontal: 30,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const UserImage(),
                    Style(
                      outputText: 'Xin chào: $userName',
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
                          title: const Style(outputText: 'Chi tiết tài khoản'),
                          onTap: () {},
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: ListTile(
                          leading: const Icon(
                            Icons.sell,
                            color: Color.fromARGB(255, 77, 71, 71),
                          ),
                          title: const Style(outputText: 'Đăng ký bán hàng'),
                          onTap: () async {
                            final user = firebase.currentUser!;
                            if (!user.emailVerified) {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (ctx) {
                                return const VerifyEmail();
                              }));
                            } else {
                              bool hasEnteredVendorInfo =
                                  await checkVendorInfoEntered();
                              if (hasEnteredVendorInfo) {
                                // Nếu thông tin cửa hàng đã được nhập, chuyển đến màn hình sản phẩm
                                if (!context.mounted) return;
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (ctx) {
                                  return const TabsVendor();
                                }));
                              } else {
                                // Nếu thông tin cửa hàng chưa được nhập, chuyển đến màn hình nhập thông tin cửa hàng
                                if (!context.mounted) return;
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (ctx) {
                                  return const VendorInfor();
                                }));
                              }
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: ListTile(
                          leading: const Icon(
                            Icons.settings,
                            color: Color.fromARGB(255, 77, 71, 71),
                          ),
                          title: const Style(outputText: 'Cài đặt'),
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
              const SizedBox(
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      firebase.signOut();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        )),
                    child: const Style(outputText: 'Đăng xuất'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
