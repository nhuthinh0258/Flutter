import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/provider/filter_provider.dart';

class FilterScreen extends ConsumerWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filterNotifier);

  //đặt trạng thái của bộ lọc Gluten Free trong provider filterNotifier dựa trên giá trị isChecked.
    void checkFilter1(bool isChecked) {
      ref.read(filterNotifier.notifier).setFilter(Filter.GlutenFree, isChecked);
    }

  //đặt trạng thái của bộ lọc Lactose Free trong provider filterNotifier dựa trên giá trị isChecked.
    void checkFilter2(bool isChecked) {
      ref.read(filterNotifier.notifier).setFilter(Filter.LactoseFree, isChecked);
    }

  //đặt trạng thái của bộ lọc Vegan trong provider filterNotifier dựa trên giá trị isChecked.
    void checkFilter3(bool isChecked) {
      ref.read(filterNotifier.notifier).setFilter(Filter.Vegan, isChecked);
    }

  //đặt trạng thái của bộ lọc Vegetarian trong provider filterNotifier dựa trên giá trị isChecked.
    void checkFilter4(bool isChecked) {
      ref.read(filterNotifier.notifier).setFilter(Filter.Vegetarian, isChecked);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Filter"),
      ),
      body: Column(
        children: [
          SwitchListTile(
            value: activeFilters[
                Filter.GlutenFree]!, //! thể hiện giá trị sẽ không rỗng
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
            value: activeFilters[
                Filter.LactoseFree]!, //! thể hiện giá trị sẽ không rỗng
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
            value: activeFilters[
                Filter.Vegan]!, //! thể hiện giá trị sẽ không rỗng,
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
            value: activeFilters[
                Filter.Vegetarian]!, //! thể hiện giá trị sẽ không rỗng,
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
    );
  }
}
