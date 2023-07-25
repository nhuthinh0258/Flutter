import 'package:flutter/material.dart';

enum Filter {
  //enum là một kiểu dữ liệu đặc biệt dùng để định nghĩa một tập hợp các hằng số (constants) có tên
  GlutenFree,
  LactoseFree, //Hằng số
  Vegan,
  Vegetarian,
}

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key,required this.currentFilter});

  final Map<Filter,bool> currentFilter;
  @override
  State<FilterScreen> createState() {
    return _FilterScreenState();
  }
}

class _FilterScreenState extends State<FilterScreen> {
  var glutenFreeFilterSet = false;
  var lactoseFreeFilterSet = false;
  var veganFilterSet = false;
  var vegetarianFilterSet = false;


  void checkFilter1(bool isChecked) {
    // cập nhật trạng thái của biến glutenFreeFilterSet dựa vào giá trị của isChecked, và sau đó gọi hàm setState để thông báo cho Flutter biết rằng có sự thay đổi trong trạng thái và cần cập nhật lại giao diện.
    setState(() {
      glutenFreeFilterSet = isChecked;
    });
  }

  void checkFilter2(bool isChecked) {
    setState(() {
      lactoseFreeFilterSet = isChecked;
    });
  }

  void checkFilter3(bool isChecked) {
    setState(() {
      veganFilterSet = isChecked;
    });
  }

  void checkFilter4(bool isChecked) {
    setState(() {
      vegetarianFilterSet = isChecked;
    });
  }

  // thiết lập giá trị ban đầu cho các biến glutenFreeFilterSet, lactoseFreeFilterSet, veganFilterSet, và vegetarianFilterSet
  // dựa trên giá trị hiện tại của widget.currentFilter (currentFilter: selectedFilter),Biến widget trong phương thức 
  //initState đại diện cho widget hiện tại mà state đang được kết nối và quản lý
  //Bằng cách thiết lập giá trị ban đầu cho các biến từ widget.currentFilter, bạn đảm bảo rằng các giá trị bộ lọc hiển thị 
  //trong màn hình hiện tại sẽ phù hợp với các giá trị đã chọn trước đó. Việc này giúp người dùng nhận ra trạng thái hiện 
  //tại của các bộ lọc khi chuyển màn hình và không mất đi các lựa chọn đã thực hiện.
  @override
  void initState() {
    super.initState();
    glutenFreeFilterSet = widget.currentFilter[Filter.GlutenFree]!;
    lactoseFreeFilterSet = widget.currentFilter[Filter.LactoseFree]!;
    veganFilterSet = widget.currentFilter[Filter.Vegan]!;
    vegetarianFilterSet = widget.currentFilter[Filter.Vegetarian]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Filter"),
      ),
      body: WillPopScope(
        //widget trong Flutter cho phép bạn chặn việc quay lại trên màn hình điều hướng (back navigation) khi người dùng nhấn nút back trên thiết bị di động hoặc cử chỉ tương tự trên các nền tảng khác

        onWillPop: () async {
          //async là kiểu future
          // Xử lý logic khi người dùng cố gắng thoát khỏi màn hình điều hướng
          Navigator.pop(context, {
            Filter.GlutenFree:
                glutenFreeFilterSet, //Key:value, gán giá trị glutenFreeFilterSet
            Filter.LactoseFree:
                lactoseFreeFilterSet, //Key:value, gán giá trị lactoseFreeFilterSet
            Filter.Vegan:
                veganFilterSet, //Key:value, gán giá trị veganFilterSet
            Filter.Vegetarian:
                vegetarianFilterSet, //Key:value, gán giá trị vegetarianFilterSet
          });
          return false; // return true nếu muốn cho phép thoát khỏi màn hình, return false nếu muốn chặn thoát khỏi màn hình
        },
        child: Column(
          children: [
            SwitchListTile(
              value: glutenFreeFilterSet,
              onChanged: checkFilter1,
              title: Text(
                "Gluten-free",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground), //onBackground thường dùng cho kiểu văn bản và biểu tượng
              ),
              subtitle: Text(
                'Only include Gluten-free',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground), //onBackground thường dùng cho kiểu văn bản
              ),
              activeColor: Theme.of(context)
                  .colorScheme
                  .tertiary, //tertiary thường được sử dụng để làm nền cho các phần tử giao diện bổ sung hoặc để tạo điểm nhấn nhỏ
              contentPadding: const EdgeInsets.only(
                //thuộc tính trong một số widget như TextField, CheckboxListTile, RadioListTile
                left: 34,
                right: 22,
              ),
              //được sử dụng để xác định khoảng cách lề xung quanh nội dung bên trong widget
            ),
            SwitchListTile(
              value: lactoseFreeFilterSet,
              onChanged: checkFilter2,
              title: Text(
                "Lactose-free",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground), //onBackground thường dùng cho kiểu văn bản và biểu tượng
              ),
              subtitle: Text(
                'Only include Lactose-free',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground), //onBackground thường dùng cho kiểu văn bản
              ),
              activeColor: Theme.of(context)
                  .colorScheme
                  .tertiary, //tertiary thường được sử dụng để làm nền cho các phần tử giao diện bổ sung hoặc để tạo điểm nhấn nhỏ
              contentPadding: const EdgeInsets.only(
                //thuộc tính trong một số widget như TextField, CheckboxListTile, RadioListTile
                left: 34,
                right: 22,
              ),
              //được sử dụng để xác định khoảng cách lề xung quanh nội dung bên trong widget
            ),
            SwitchListTile(
              value: veganFilterSet,
              onChanged: checkFilter3,
              title: Text(
                "Vegan",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground), //onBackground thường dùng cho kiểu văn bản và biểu tượng
              ),
              subtitle: Text(
                'Only include Vegan',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground), //onBackground thường dùng cho kiểu văn bản
              ),
              activeColor: Theme.of(context)
                  .colorScheme
                  .tertiary, //tertiary thường được sử dụng để làm nền cho các phần tử giao diện bổ sung hoặc để tạo điểm nhấn nhỏ
              contentPadding: const EdgeInsets.only(
                //thuộc tính trong một số widget như TextField, CheckboxListTile, RadioListTile
                left: 34,
                right: 22,
              ),
              //được sử dụng để xác định khoảng cách lề xung quanh nội dung bên trong widget
            ),
            SwitchListTile(
              value: vegetarianFilterSet,
              onChanged: checkFilter4,
              title: Text(
                "Vegetarian",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground), //onBackground thường dùng cho kiểu văn bản và biểu tượng
              ),
              subtitle: Text(
                'Only include Vegetarian',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground), //onBackground thường dùng cho kiểu văn bản
              ),
              activeColor: Theme.of(context)
                  .colorScheme
                  .tertiary, //tertiary thường được sử dụng để làm nền cho các phần tử giao diện bổ sung hoặc để tạo điểm nhấn nhỏ
              contentPadding: const EdgeInsets.only(
                //thuộc tính trong một số widget như TextField, CheckboxListTile, RadioListTile
                left: 34,
                right: 22,
              ),
              //được sử dụng để xác định khoảng cách lề xung quanh nội dung bên trong widget
            ),
          ],
        ),
      ),
    );
  }
}
