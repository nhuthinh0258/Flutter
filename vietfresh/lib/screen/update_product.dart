import 'package:chat_app/screen/auth.dart';
import 'package:chat_app/screen/new_product.dart';
import 'package:chat_app/style.dart';
import 'package:chat_app/widgets/product_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class UpdateProduct extends StatefulWidget {
  const UpdateProduct(
      {super.key, required this.product, required this.currentImageUrl});
  final Map<String, dynamic> product;
  final String currentImageUrl;

  @override
  State<StatefulWidget> createState() {
    return _UpdateProduct();
  }
}

class _UpdateProduct extends State<UpdateProduct> {
  final formKeyUpdateProduct = GlobalKey<FormState>();
  var enteredNameProduct = '';
  var enteredKiloProduct = 100;
  var enteredQuantityProduct = 1;
  String? enteredNoteproduct = '';
  var enteredPriceProduct = 1000;
  var selectedCategoryId = 'category-1703185284175.jpg';
  var selectedOriginId = 'origin-1703218547035';
  File? selectedImage;
  var isSending = false;

  @override
  void initState() {
    super.initState();
    enteredNameProduct = widget.product['name'];
    enteredKiloProduct = widget.product['kilo'];
    enteredQuantityProduct = widget.product['quantity'];
    enteredNoteproduct = widget.product['note'];
    enteredPriceProduct = widget.product['price'];
    selectedCategoryId = widget.product['category'];
    selectedOriginId = widget.product['origin'];
  }

  void updateProduct() async {
    if (formKeyUpdateProduct.currentState!.validate()) {
      formKeyUpdateProduct.currentState!.save();

      setState(() {
        isSending = true;
      });
      //Lưu ảnh hiện tại vào imageUrl
      String imageUrl = widget.currentImageUrl;

      //Nếu việc thay ảnh là đúng
      if (selectedImage != null) {
        //Lưu ảnh cũ vào biến oldImageUrl
        String oldImageUrl = imageUrl;
        //Tạo id ảnh sản phẩm mới
        final productImage =
            'product-${DateTime.now().millisecondsSinceEpoch}.jpg';
        //Lưu ảnh vào product_image trong firestorage
        final storageRef =
            firebaseStorage.ref().child('product_image').child(productImage);
        //Đợi lưu ảnh
        await storageRef.putFile(selectedImage!);
        //Đợi lấy url của ảnh sau khi lưu
        imageUrl = await storageRef.getDownloadURL();
        //Nếu ảnh cũ khác với ảnh mới
        if (oldImageUrl != imageUrl) {
          //Xóa ảnh cũ
          firebaseStorage.refFromURL(oldImageUrl).delete();
        }
      }
      final productId = widget.product['product_id'];
      await firestore.collection('product').doc(productId).update({
        'image': imageUrl,
        'name': enteredNameProduct,
        'kilo': enteredKiloProduct,
        'quantity': enteredQuantityProduct,
        'price': enteredPriceProduct,
        'category': selectedCategoryId,
        'origin': selectedOriginId,
        'note': enteredNoteproduct,
        'update_at': Timestamp.now(),
        'sort_timestamp':Timestamp.now(),
      });
      if (!mounted) return;
      Navigator.of(context).pop();
    }
  }

  void onSelectedProductImage(File image) {
    selectedImage = image;
  }

  String? validatorEnteredNameCategory(String? value) {
    if (value == null || value.isEmpty || value.trim().length < 3) {
      return 'Tên sản phẩm ko hợp lệ';
    }
    return null;
  }

  String? validatorKiloProduct(value) {
    if (value == null || value.isEmpty) {
      return 'Khối lượng sản phẩm rỗng';
    }
    //int.tryParse convert chuyển đổi chuỗi thành 1 số nguyên
    else if (int.tryParse(value) == null || int.tryParse(value)! <= 99) {
      return 'Khối lượng phải lớn hơn 100';
    }
    //trả về null nếu không có lỗi
    return null;
  }

  String? validatorQuantityProduct(value) {
    if (value == null || value.isEmpty) {
      return 'Số lượng sản phẩm rỗng';
    }
    //int.tryParse convert chuyển đổi chuỗi thành 1 số nguyên
    else if (int.tryParse(value) == null || int.tryParse(value)! <= 0) {
      return 'Số lượng phải lớn hơn 0';
    }
    //trả về null nếu không có lỗi
    return null;
  }

  String? validatorPriceProduct(value) {
    if (value == null || value.isEmpty) {
      return 'Đơn giá sản phẩm rỗng';
    }
    //int.tryParse convert chuyển đổi chuỗi thành 1 số nguyên
    else if (int.tryParse(value) == null || int.tryParse(value)! <= 999) {
      return 'Đơn giá phải lớn hơn 1000';
    }
    //trả về null nếu không có lỗi
    return null;
  }

  String? validatorCategoryProduct(value) {
    if (value == null) {
      return 'Loại sản phẩm rỗng';
    }
    //trả về null nếu không có lỗi
    return null;
  }

  String? validatorOriginProduct(value) {
    if (value == null) {
      return 'Xuất xứ rỗng';
    }
    //trả về null nếu không có lỗi
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thêm sản phẩm'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKeyUpdateProduct,
            child: Column(
              children: [
                ProductImage(
                  onSelectedProductImage: onSelectedProductImage,
                  initialImageUrl: widget.product['image'],
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  initialValue: enteredNameProduct,
                  decoration: const InputDecoration(
                    errorStyle: TextStyle(color: Colors.red),
                    border: OutlineInputBorder(),
                    label: Text(
                      'Tên sản phẩm',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  validator: validatorEnteredNameCategory,
                  onSaved: (value) {
                    enteredNameProduct = value!;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  initialValue: enteredKiloProduct.toString(),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    errorStyle: TextStyle(color: Colors.red),
                    border: OutlineInputBorder(),
                    label: Text(
                      'Khối lượng',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  validator: validatorKiloProduct,
                  onSaved: (value) {
                    enteredKiloProduct = int.parse(value!);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextFormField(
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        initialValue: enteredQuantityProduct.toString(),
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          //style lại thông báo lỗi của validator
                          errorStyle: TextStyle(color: Colors.red),
                          //Thêm viền xung quanh
                          border: OutlineInputBorder(),
                          label: Text(
                            'Số lượng',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        validator: validatorQuantityProduct,
                        //lưu giá trị của field
                        onSaved: (value) {
                          enteredQuantityProduct = int.parse(value!);
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Expanded(
                      child: TextFormField(
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        initialValue: enteredPriceProduct.toString(),
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          //style lại thông báo lỗi của validator
                          errorStyle: TextStyle(color: Colors.red),
                          //Thêm viền xung quanh
                          border: OutlineInputBorder(),
                          label: Text(
                            'Đơn giá',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        validator: validatorPriceProduct,
                        //lưu giá trị của field
                        onSaved: (value) {
                          enteredPriceProduct = int.parse(value!);
                        },
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      //thay đổi màu nền của dropdown khi nhấn vào
                      child: Theme(
                        data: Theme.of(context).copyWith(
                            canvasColor:
                                Theme.of(context).scaffoldBackgroundColor),
                        child: FutureBuilder(
                          future: firestore.collection('orgin').get(),
                          builder: (context, oriSnapshot) {
                            if (oriSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(child: CircularProgressIndicator(),);
                            }

                            if (!oriSnapshot.hasData ||
                                oriSnapshot.data!.docs.isEmpty) {
                              return const Text('Không có dữ liệu');
                            }

                            List<DropdownMenuItem<String>> originItems =
                                oriSnapshot.data!.docs.map((doc) {
                              return DropdownMenuItem(
                                value: doc.id,
                                child: Text(
                                  doc['name'],
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              );
                            }).toList();

                            return DropdownButtonFormField(
                              value: selectedOriginId,
                              validator: validatorOriginProduct,
                              decoration: const InputDecoration(
                                errorStyle: TextStyle(color: Colors.red),
                                border: OutlineInputBorder(),
                                label: Text('Xuất xứ',
                                    style: TextStyle(fontSize: 20)),
                              ),
                              items: originItems,
                              onChanged: (value) {
                                setState(() {
                                  selectedOriginId = value!;
                                });
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Expanded(
                      //thay đổi màu nền của dropdown khi nhấn vào

                      child: Theme(
                        data: Theme.of(context).copyWith(
                            canvasColor:
                                Theme.of(context).scaffoldBackgroundColor),
                        child: FutureBuilder(
                          future: firestore.collection('category').get(),
                          builder: (context, cateSnapshot) {
                            // if (cateSnapshot.connectionState ==
                            //     ConnectionState.waiting) {
                            //   return const CircularProgressIndicator();
                            // }

                            if (!cateSnapshot.hasData ||
                                cateSnapshot.data!.docs.isEmpty) {
                              return const Text('Không có dữ liệu');
                            }

                            List<DropdownMenuItem<String>> categoryItems =
                                cateSnapshot.data!.docs.map((doc) {
                              return DropdownMenuItem(
                                value: doc.id,
                                child: Text(
                                  doc['name'],
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              );
                            }).toList();

                            return DropdownButtonFormField(
                              value: selectedCategoryId,
                              validator: validatorCategoryProduct,
                              decoration: const InputDecoration(
                                errorStyle: TextStyle(color: Colors.red),
                                border: OutlineInputBorder(),
                                label: Text('Loại sản phẩm',
                                    style: TextStyle(fontSize: 20)),
                              ),
                              items: categoryItems,
                              onChanged: (value) {
                                setState(() {
                                  selectedCategoryId = value!;
                                });
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  initialValue: enteredNoteproduct,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  decoration: const InputDecoration(
                      label: Text(
                        'Ghi chú',
                        style: TextStyle(fontSize: 20),
                      ),
                      //Thêm viền xung quanh
                      border: OutlineInputBorder()),
                  //Độ dài tối đa ghi chú
                  maxLength: 500,
                  //Số dòng tối đa
                  maxLines: 5,
                  onSaved: (value) {
                    enteredNoteproduct = value;
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: updateProduct,
                      style: ButtonStyle(
                        //Thay đổi màu nền của button theo màu theme đã khai báo
                        backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColorLight,
                        ),
                      ),
                      child: isSending
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: Center(child: CircularProgressIndicator()),
                            )
                          : const Style(
                              outputText: 'Sửa sản phẩm',
                            ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
