import 'package:get/get.dart';
import 'package:whatsapp_clone/app/data/providers/task/provider.dart';
import 'package:whatsapp_clone/app/data/services/storage/repository.dart';
import 'package:whatsapp_clone/app/modules/home/controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(
        taskRepository: TaskRepository(taskProvider: TaskProvider())));
  }
}
