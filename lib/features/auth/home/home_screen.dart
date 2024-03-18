import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/controller/store_provider.dart';
import 'accepted/accepted.dart';
import 'history/history_screen.dart';
import 'profile/profile_screen.dart';
import 'request/request.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void actionHistoryPressed() => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HistoryScreen(),
        ),
      );

  void actionProfilePressed() => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ProfileScreen(),
        ),
      );

  @override
  void initState() {
    context.read<StoreProvider>().getClinic();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: context.watch<StoreProvider>().clinicModel != null?AppBar(
            title: Text(context.watch<StoreProvider>().clinicModel!.name),
            actions: [
              IconButton(
                onPressed: actionHistoryPressed,
                icon: const Icon(Icons.history),
              ),
              IconButton(
                onPressed: actionProfilePressed,
                icon: const Icon(Icons.person),
              ),
            ],
            bottom: const TabBar(
              tabs: [
                Text(
                  "Request",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Accepted",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ):null,
          body: SafeArea(
            child: context.watch<StoreProvider>().clinicModel != null?const TabBarView(
              children:[
                RequestScreen(),
                Accepted(),
              ],
            ):const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      );
  }
}
