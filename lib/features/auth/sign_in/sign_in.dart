import 'package:ambulance_for_hospital/common/util/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/blocs/sign_in/sign_in_bloc.dart';
import '../../../common/blocs/sign_up/sign_up_bloc.dart';
import '../../../common/controller/store_provider.dart';
import '../../../common/util/custom_text_field.dart';
import '../home/home_screen.dart';
import '../sign_up/sign_up.dart';
class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController addressEditingController = TextEditingController();

  @override
  void dispose() {
    nameEditingController.dispose();
    addressEditingController.dispose();
    super.dispose();
  }

  void signUp() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => SignUpBloc(),
          child: const SignUp(),
        ),
      ),
    );
  }

  void listener (BuildContext context, state) {
    if (state is SignInSuccess) {
      context.read<StoreProvider>().setClinic(state.clinicModel);
      context.read<StoreProvider>().setName(nameEditingController.text);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
            (route) => false,
      );
    }
  }

  void signIn() {
    context.read<SignInBloc>().add(
      SignInRequired(
        name: nameEditingController.text,
        address: addressEditingController.text,
      ),
    );
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
              onTap: signUp,
              child: const Text(
                "Sign up",
                textAlign: TextAlign.right,
                style: TextStyle(color: Colors.blue),
              ),
            ),
            SizedBox(height: size.height * 0.08),
            Text(
              "Sign In",
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
            BlocListener<SignInBloc, SignInState>(
              listener: listener,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: Size(size.width, size.height * 0.065),
                ),
                onPressed: signIn,
                child: Text(
                  "Sign in",
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
