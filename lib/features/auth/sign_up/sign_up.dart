import 'package:ambulance_for_hospital/common/util/text_theme.dart';
import 'package:ambulance_for_hospital/features/auth/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/blocs/sign_up/sign_up_bloc.dart';
import '../../../common/controller/store_provider.dart';
import '../../../common/util/custom_text_field.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController addressEditingController = TextEditingController();

  @override
  void dispose() {
    nameEditingController.dispose();
    addressEditingController.dispose();
    super.dispose();
  }

  void signIn() {
    Navigator.pop(context);
  }

  void signUp() {
    context.read<SignUpBloc>().add(
      SignUpRequired(
        nameEditingController.text,
        addressEditingController.text,
      ),
    );
  }

  void listener (BuildContext context, state) {
    if (state is SignUpSuccess) {
      context.read<StoreProvider>().getClinic();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          children: [
            SizedBox(height: size.height * 0.02),
            GestureDetector(
              onTap: signIn,
              child: const Text(
                "Sign in",
                textAlign: TextAlign.right,
                style: TextStyle(color: Colors.blue),
              ),
            ),
            SizedBox(height: size.height * 0.08),
            Text(
              "Sign Up",
              textAlign: TextAlign.center,
              style: context.textTheme.displaySmall!.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.blueGrey,
              ),
            ),
            SizedBox(height: size.height * 0.1),
            CustomTextField(
              hintText: "Family name",
              textEditingController: nameEditingController,
              count: false,
            ),
            SizedBox(height: size.height * 0.05),
            CustomTextField(
              hintText: "Region, district, street",
              textEditingController: addressEditingController,
              count: false,
            ),
            SizedBox(height: size.height * 0.3),
            BlocListener<SignUpBloc, SignUpState>(
              listener: listener,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: Size(size.width, size.height * 0.065),
                ),
                onPressed: signUp,
                child: Text(
                  "Sign up",
                  style: context.textTheme.titleMedium!
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
