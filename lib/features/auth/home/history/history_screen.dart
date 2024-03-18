import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<ValueNotifier<bool>> select =
      List.generate(4, (index) => ValueNotifier<bool>(false));
  List<String> name = ["Kun", "Hafta", "Oy", "Yil"];
  Map<String, String> map = {
    "Jaloliddin": "Samarqand viloyati, Narpay tumani, Tortuvli 601",
    "Ahmad": "Samarqand viloyati, Narpay tumani, Tortuvli 601",
    "Nurbek": "Samarqand viloyati, Narpay tumani, Tortuvli 601",
    "Alisher": "Samarqand viloyati, Narpay tumani, Tortuvli 601",
    "Samandar": "Samarqand viloyati, Narpay tumani, Tortuvli 601",
    "G'olib": "Samarqand viloyati, Narpay tumani, Tortuvli 601",
    "Said": "Samarqand viloyati, Narpay tumani, Tortuvli 601",
    "Sanjar": "Samarqand viloyati, Narpay tumani, Tortuvli 601",
    "Jasur": "Samarqand viloyati, Narpay tumani, Tortuvli 601",
    "Ulug'bek": "Samarqand viloyati, Narpay tumani, Tortuvli 601",
  };

  void selectValue(int index) {
    if (!select[index].value) {
      for (var item in select) {
        item.value = false;
      }
    }
    select[index].value = !select[index].value;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("History"),
        surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
        bottom: PreferredSize(
          preferredSize: Size(double.infinity, size.height * 0.07),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              4,
              (index) => ValueListenableBuilder(
                valueListenable: select[index],
                builder: (context, value, child) {
                  return FilledButton(
                    onPressed: () => selectValue(index),
                    style: FilledButton.styleFrom(
                      backgroundColor:
                          select[index].value ? Colors.blue : Colors.white,
                      shape: const StadiumBorder(
                        side: BorderSide(color: Colors.blue),
                      ),
                    ),
                    child: Text(
                      name[index],
                      style: const TextStyle(color: Colors.black),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: ListView.separated(
          itemBuilder: (context, index) => ListTile(
            onTap: () {
              map.remove(map.keys.toList()[index]);
              setState(() {});
            },
            tileColor: Colors.redAccent,
            leading: Text("${index + 1}"),
            title: Text(map.keys.toList()[index]),
            subtitle: Text(map.values.toList()[index]),
            trailing: Text("${DateTime.now().hour} : ${DateTime.now().minute}"),
          ),
          separatorBuilder: (context, index) => const Divider(),
          itemCount: map.length,
        ),
      ),
    );
  }
}
