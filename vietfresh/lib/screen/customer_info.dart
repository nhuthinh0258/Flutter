import 'package:chat_app/style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'auth.dart';

final formatDate = DateFormat('dd-MM-yyyy');

class CustomerInfor extends StatefulWidget {
  const CustomerInfor({super.key, required this.userData});

  final Map<String, dynamic>? userData;
  @override
  State<CustomerInfor> createState() {
    return _CustomerInforState();
  }
}

class _CustomerInforState extends State<CustomerInfor> {
  final customerInforKeyForm = GlobalKey<FormState>();
  var enteredCustomerName = '';
  var enteredCustomerAdress = '';
  var enteredCustomerPhone = 0;
  var selectedOriginId = 'origin-1703218547035';
  DateTime? selectedCustomerDate;
  var isUpdating = false;

  @override
  void initState() {
    super.initState();
    enteredCustomerName = widget.userData?['user_name'] ?? enteredCustomerName;
    enteredCustomerAdress =
        widget.userData?['user_address'] ?? enteredCustomerAdress;
    enteredCustomerPhone =
        (widget.userData?['user_phone'] ?? enteredCustomerPhone);
    selectedOriginId = widget.userData?['user_origin'] ?? selectedOriginId;
    if (widget.userData?['user_date'] != null) {
      selectedCustomerDate = formatDate.parse(widget.userData?['user_date']);
    }
  }

  String? validatCustomerName(String? value) {
    if (value == null || value.isEmpty || value.trim().length < 4) {
      return 'Tên cửa hàng không hợp lệ';
    }
    return null;
  }

  String? validateCustomerAdress(String? value) {
    if (value == null || value.isEmpty || value.trim().length < 6) {
      return 'Địa chỉ không hợp lệ';
    }
    return null;
  }

  String? validateCustomerPhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Số điện thoại trống';
    } else if (value.trim().length > 10 || value.trim().length < 10) {
      return 'số điện thoại không hợp lệ';
    }
    return null;
  }

  String? validateCustomerDate(String? value) {
    // Thêm logic validation của bạn ở đây
    if (value == null || value.isEmpty) {
      return 'Vui lòng chọn ngày sinh';
    }
    return null;
  }

  void submitCustomInfor() async {
    if (customerInforKeyForm.currentState!.validate()) {
      customerInforKeyForm.currentState!.save();
      setState(() {
        isUpdating = true;
      });
      final user = firebase.currentUser!;
      final userData = firestore.collection('users').doc(user.uid);
      await userData.update({
        'user_name': enteredCustomerName,
        'user_address': enteredCustomerAdress,
        'user_origin': selectedOriginId,
        'user_phone': enteredCustomerPhone,
        'user_date': formatDate.format(selectedCustomerDate!),
      });
      if (!mounted) return;
      Navigator.of(context).pop();
    }
  }

  void birthDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 70, now.month, now.day);
    final datePicked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color.fromARGB(255, 1, 94, 15),
              // Thiết lập màu nền mới sử dụng colorScheme.background
              background: Colors.white,
              // Màu của text và các icon trên nền
              onBackground: Colors.black,
            ),
            //Tạo viền cong cho datetimepicker
            dialogTheme: const DialogTheme(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
            ),
            //Màu body datetimepicker
            dialogBackgroundColor: const Color.fromARGB(255, 252, 244, 253),
          ),
          child: child!,
        );
      },
    );
    setState(() {
      selectedCustomerDate = datePicked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin tài khoản'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: customerInforKeyForm,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    initialValue: enteredCustomerName,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person),
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
                    validator: validatCustomerName,
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
                        flex: 1,
                        child: TextFormField(
                          initialValue: enteredCustomerAdress,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.pin_drop),
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
                          validator: validateCustomerAdress,
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
                                      prefixIcon: Icon(Icons.location_city),
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
                    initialValue: enteredCustomerPhone.toString(),
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.phone),
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
                    validator: validateCustomerPhone,
                    onSaved: (value) {
                      enteredCustomerPhone = int.parse(value!);
                    },
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  TextFormField(
                    controller: TextEditingController(
                        text: selectedCustomerDate != null
                            ? formatDate.format(selectedCustomerDate!)
                            : ''),
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.calendar_month),
                      errorStyle: TextStyle(color: Colors.red),
                      border: OutlineInputBorder(),
                      label: Text(
                        'Ngày sinh',
                        style: TextStyle(fontSize: 20),
                      ),
                      helperText: '',
                    ),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    readOnly: true, // Để ngăn nhập liệu trực tiếp
                    onTap: birthDatePicker, // Mở DatePicker khi nhấn vào
                    validator: validateCustomerDate,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: submitCustomInfor,
                        style: ButtonStyle(
                          //Thay đổi màu nền của button theo màu theme đã khai báo
                          backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).primaryColorLight,
                          ),
                        ),
                        child: isUpdating
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child:
                                    Center(child: CircularProgressIndicator()),
                              )
                            : const Style(
                                outputText: 'Cập nhật thông tin',
                              ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
