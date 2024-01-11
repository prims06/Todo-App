import 'package:flutter/material.dart';
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
              style: TextStyle(fontSize: 24.0.sp, fontWeight: FontWeight.bold),
            ),
          ),
          Obx(() => 
             GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                TaskCard(
                    task: Task(title: 'title', icon: 0xe59c, color: '#FF2B60E6')),
                ...controller.tasks.map((task)=>TaskCard(task: task)).toList(),
                AddCard()
              ],
            ),
          )
        ],
      )),
    );
  }
}
