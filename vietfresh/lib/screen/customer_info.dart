import 'package:flutter/material.dart';

import 'auth.dart';

class CustomerInfor extends StatefulWidget {
  const CustomerInfor({super.key});
  @override
  State<CustomerInfor> createState() {
    return _CustomerInforState();
  }
}

class _CustomerInforState extends State<CustomerInfor> {
  final customerInforKeyForm = GlobalKey<FormState>();
  var enteredCustomerName = '';
  var enteredCustomerAdress = '';
  var enteredCustomerPhone = 1;
  var selectedOriginId = 'origin-1703218547035';

  String? validateBillingName(String? value) {
    if (value == null || value.isEmpty || value.trim().length < 4) {
      return 'Tên cửa hàng không hợp lệ';
    }
    return null;
  }

  String? validateBillingAdress(String? value) {
    if (value == null || value.isEmpty || value.trim().length < 6) {
      return 'Địa chỉ không hợp lệ';
    }
    return null;
  }

  String? validateBillingPhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Số điện thoại trống';
    } else if (value.trim().length > 11 || value.trim().length < 11) {
      return 'số điện thoại không hợp lệ';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin tài khoản'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: customerInforKeyForm,
          child: Column(
            children: [
              const SizedBox(
                height: 4,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  errorStyle: TextStyle(color: Colors.red),
                  border: OutlineInputBorder(),
                  label: Text(
                    'Họ và Tên',
                    style: TextStyle(fontSize: 20),
                  ),
                  helperText: '',
                ),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
                validator: validateBillingName,
                onSaved: (value) {
                  enteredCustomerName = value!;
                },
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        errorStyle: TextStyle(color: Colors.red),
                        border: OutlineInputBorder(),
                        label: Text(
                          'Địa chỉ',
                          style: TextStyle(fontSize: 20),
                        ),
                        helperText: '',
                      ),
                      keyboardType: TextInputType.streetAddress,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      validator: validateBillingAdress,
                      onSaved: (value) {
                        enteredCustomerAdress = value!;
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Expanded(
                    flex: 1,
                    child: Theme(
                      data: Theme.of(context).copyWith(
                          canvasColor:
                              Theme.of(context).scaffoldBackgroundColor),
                      child: FutureBuilder(
                          future: firestore.collection('orgin').get(),
                          builder: (ctx, oriSnapshot) {
                            if (!oriSnapshot.hasData ||
                                oriSnapshot.data!.docs.isEmpty) {
                              return const Center(
                                child: Text('Không tìm thấy dữ liệu'),
                              );
                            }
                            List<DropdownMenuItem<String>> orginList =
                                oriSnapshot.data!.docs.map(
                              (origin) {
                                return DropdownMenuItem(
                                    value: origin.id,
                                    child: Text(
                                      origin['name'],
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ));
                              },
                            ).toList();

                            return DropdownButtonFormField(
                                value: selectedOriginId,
                                decoration: const InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 18),
                                  errorStyle: TextStyle(color: Colors.red),
                                  border: OutlineInputBorder(),
                                  label: Text('Thành phố',
                                      style: TextStyle(fontSize: 16)),
                                ),
                                items: orginList,
                                onChanged: (value) {
                                  selectedOriginId = value!;
                                });
                          }),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  errorStyle: TextStyle(color: Colors.red),
                  border: OutlineInputBorder(),
                  label: Text(
                    'Số điện thoại',
                    style: TextStyle(fontSize: 20),
                  ),
                  helperText: '',
                ),
                keyboardType: TextInputType.number,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
                validator: validateBillingPhone,
                onSaved: (value) {
                  enteredCustomerPhone = int.parse(value!);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
