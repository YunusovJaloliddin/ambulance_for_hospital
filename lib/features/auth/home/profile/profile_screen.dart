import 'package:ambulance_for_hospital/common/controller/store_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            SizedBox(
              height: size.height * 0.1,
            ),
            Icon(
              Icons.account_circle_rounded,
              size: size.width * 0.3,
              color: Colors.grey.shade700,
            ),
            SizedBox(
              height: size.height * 0.03
            ),
            SizedBox(
              height: size.height * 0.09,
              width: double.infinity,
              child: DecoratedBox(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Color(0xFFBDBDBD)),
                child: Center(
                  child: Text(
                    context.watch<StoreProvider>().clinicModel?.name??"",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.03
            ),
            SizedBox(
              height: size.height * 0.09,
              width: double.infinity,
              child: DecoratedBox(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Color(0xFFBDBDBD)),
                child: Center(
                  child: Text(
                    context.watch<StoreProvider>().clinicModel?.address??"",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.03
            ),
            SizedBox(
              height: size.height * 0.09,
              width: double.infinity,
              child: DecoratedBox(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Color(0xFFBDBDBD)),
                child: Center(
                  child: Text(
                    "${context.watch<StoreProvider>().clinicModel?.answerTime??""}",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.03
            ),
            SizedBox(
              height: size.height * 0.09,
              width: double.infinity,
              child: DecoratedBox(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Color(0xFFBDBDBD)),
                child: Center(
                  child: Text(
                    "${context.watch<StoreProvider>().clinicModel?.stars??""}",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
