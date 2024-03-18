import 'package:ambulance_for_hospital/features/auth/home/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../common/util/custom_text_field.dart';

class DateAuth extends StatefulWidget {
  const DateAuth({super.key});

  @override
  State<DateAuth> createState() => _DateAuthState();
}

class _DateAuthState extends State<DateAuth> {
  TextEditingController nameEditingController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameEditingController.dispose();
    super.dispose();
  }

  Duration duration=const Duration(seconds: 0);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Form(
      key: formKey,
      child: Scaffold(
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            children: [
              SizedBox(height: size.height * 0.2),
              CustomTextField(
                hintText: "Doctor name",
                count: false,
                textEditingController: nameEditingController,
              ),
              SizedBox(height: size.height * 0.04),
              DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 2,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                child: CupertinoTimerPicker(
                  onTimerDurationChanged: (value) {
                    duration=value;
                  },
                  mode: CupertinoTimerPickerMode.hm,
                ),
              ),
              SizedBox(height: size.height * 0.2),
              FilledButton(
                  onPressed: () {
                    if(duration.inMinutes!=0 && formKey.currentState!.validate()){
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                        (route) => false,
                      );
                    }
                  },
                  style: FilledButton.styleFrom(
                      fixedSize: Size(size.width, size.height * 0.06)),
                  child: const Text("Contiune")),
            ],
          ),
        ),
      ),
    );
  }
}
