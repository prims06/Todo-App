import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/app/core/utils/extention.dart';
import 'package:whatsapp_clone/app/core/values/colors.dart';
import 'package:whatsapp_clone/app/data/models/task.dart';
import 'package:whatsapp_clone/app/modules/home/controller.dart';
import 'package:whatsapp_clone/app/modules/home/widgets/add_card.dart';
import 'package:whatsapp_clone/app/modules/home/widgets/add_dialog.dart';
import 'package:whatsapp_clone/app/modules/home/widgets/task_card.dart';
import 'package:whatsapp_clone/app/modules/report/view.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          children: [
            SafeArea(
                child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.all(4.0.sp),
                  child: Text(
                    'My List',
                    style: TextStyle(
                        fontSize: 24.0.sp, fontWeight: FontWeight.bold),
                  ),
                ),
                Obx(
                  () => GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    children: [
                      ...controller.tasks
                          .map((task) => LongPressDraggable(
                              data: task,
                              feedback: Opacity(opacity: 0.8),
                              onDragStarted: () =>
                                  controller.changeDeleting(true),
                              onDraggableCanceled: (_, __) =>
                                  controller.changeDeleting(false),
                              onDragEnd: (_) =>
                                  controller.changeDeleting(false),
                              child: TaskCard(task: task)))
                          .toList(),
                      AddCard()
                    ],
                  ),
                )
              ],
            )),
            ReportPage(),
          ],
        ),
      ),
      floatingActionButton: DragTarget<Task>(
        builder: (_, __, ___) => Obx((() => FloatingActionButton(
              backgroundColor: controller.deleting.value ? Colors.red : blue,
              onPressed: () {
                if (controller.tasks.isNotEmpty) {
                  Get.to(() => AddDialog(), transition: Transition.downToUp);
                } else {
                  EasyLoading.showInfo('Please create your task type first');
                }
              },
              child: Icon(controller.deleting.value ? Icons.delete : Icons.add),
            ))),
        onAccept: (task) {
          controller.deleteTask(task);
          EasyLoading.showSuccess('Task delected');
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Obx(
          () => BottomNavigationBar(
            onTap: (int index) => controller.changeTabIndex(index),
            currentIndex: controller.tabIndex.value,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(right: 15.0.wp),
                    child: const Icon(Icons.apps),
                  ),
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(left: 15.0.wp),
                    child: const Icon(Icons.data_usage),
                  ),
                  label: 'Report'),
            ],
          ),
        ),
      ),
    );
  }
}
