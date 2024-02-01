import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/app/core/utils/extention.dart';
import 'package:whatsapp_clone/app/core/values/colors.dart';
import 'package:whatsapp_clone/app/data/models/task.dart';
import 'package:whatsapp_clone/app/modules/home/controller.dart';
import 'package:whatsapp_clone/app/modules/home/widgets/add_card.dart';
import 'package:whatsapp_clone/app/modules/home/widgets/task_card.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(4.0.sp),
              child: Text(
                'My List',
                style:
                    TextStyle(fontSize: 24.0.sp, fontWeight: FontWeight.bold),
              ),
            ),
            Obx(
              () => GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                children: [
                  TaskCard(
                      task: Task(
                          title: 'title', icon: 0xe59c, color: '#FF2B60E6')),
                  ...controller.tasks
                      .map((task) => LongPressDraggable(
                          data: task,
                          feedback: Opacity(opacity: 0.8),
                          onDragStarted: () => controller.changeDeleting(true),
                          onDraggableCanceled: (_, __) =>
                              controller.changeDeleting(false),
                          onDragEnd: (_) => controller.changeDeleting(false),
                          child: TaskCard(task: task)))
                      .toList(),
                  AddCard()
                ],
              ),
            )
          ],
        )),
        floatingActionButton: DragTarget<Task>(
          builder: (_, __, ___) => Obx((() => FloatingActionButton(
                backgroundColor: controller.deleting.value ? Colors.red : blue,
                onPressed: () {},
                child:
                    Icon(controller.deleting.value ? Icons.add : Icons.delete),
              ))),
          onAccept: (task) {
            controller.deleteTask(task);
            EasyLoading.showSuccess('Task delected');
          },
        ));
  }
}
