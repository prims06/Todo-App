import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/app/core/utils/extention.dart';
import 'package:whatsapp_clone/app/data/models/task.dart';
import 'package:whatsapp_clone/app/modules/home/controller.dart';
import 'package:whatsapp_clone/app/widgets/icons.dart';

class AddCard extends StatelessWidget {
  final homeController = Get.find<HomeController>();
  AddCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final icons = getIcons();
    var squareWidth = Get.width - 12.0.wp;
    return Container(
      width: squareWidth / 2,
      height: squareWidth / 2,
      margin: EdgeInsets.all(3.0.wp),
      child: InkWell(
        onTap: () async {
          await Get.defaultDialog(
              titlePadding: EdgeInsets.symmetric(vertical: 5.0.wp),
              radius: 5,
              title: 'Task Type',
              content: Form(
                key: homeController.formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3.0.wp),
                      child: TextFormField(
                        controller: homeController.editController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Title',
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your task title';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.0.wp),
                      child: Wrap(
                        spacing: 2.0.wp,
                        children: icons
                            .map((e) => Obx(() {
                                  final index = icons.indexOf(e);
                                  return ChoiceChip(
                                      label: e,
                                      pressElevation: 0,
                                      backgroundColor: Colors.white,
                                      onSelected: (bool selected) {
                                        homeController.chipIndex.value =
                                            selected ? index : 0;
                                      },
                                      selected:
                                          homeController.chipIndex.value ==
                                              index);
                                }))
                            .toList(),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (homeController.formKey.currentState!.validate()) {
                            int icon = icons[homeController.chipIndex.value]
                                .icon!
                                .codePoint;
                            String color = icons[homeController.chipIndex.value]
                                .color!
                                .toHex();
                            var task = Task(
                                title: homeController.editController.text,
                                icon: icon,
                                color: color);
                            Get.back();
                            homeController.addTask(task)
                                ? EasyLoading.showSuccess('Created')
                                : EasyLoading.showError('Duplicated Task');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          minimumSize: const Size(150, 40),
                        ),
                        child: const Text('Confirm'))
                  ],
                ),
              ));
          homeController.editController.clear();
          homeController.changeChipIndex(0);
        },
        child: DottedBorder(
          color: Colors.grey[400]!,
          dashPattern: const [8, 4],
          child: Center(
              child: Icon(
            Icons.add,
            size: 10.0.wp,
            color: Colors.grey,
          )),
        ),
      ),
    );
  }
}
