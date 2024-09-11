import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsup/common/theme.dart';
import 'package:whatsup/common/util/constants.dart';
import 'package:whatsup/features/call/widgets/call_list.dart';
import 'package:whatsup/features/home/widgets/chat_list.dart';
import 'package:whatsup/router.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> with TickerProviderStateMixin {
  late final TabController controller;
  static final kAppBarActionIconColor = Colors.grey.shade100;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
    // update the state of the tab controller when the tab changes
    controller.addListener(() {
      if (controller.indexIsChanging) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeNotifierProvider);
    return DefaultTabController(
      length: controller.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Chat App'),
          bottom: TabBar(
            controller: controller,
            indicatorColor: themeMode == Brightness.light ? Colors.white : kPrimaryColor,
            labelColor: themeMode == Brightness.light ? Colors.white : kPrimaryColor,
            unselectedLabelColor: kUnselectedLabelColor,
            indicatorWeight: 4,
            tabs: const [
              Tab(text: "Chat"),
              Tab(text: "Calls"),
            ],
          ),
          actions: [
            // theme switcher
            

            IconButton(
              splashRadius: kDefaultSplashRadius,
              onPressed: () {},
              color: kAppBarActionIconColor,
              icon: Icon(
                Icons.search,
                color: kAppBarActionIconColor,
              ),
            ),

            // Sign Out Button
            IconButton(
              splashRadius: kDefaultSplashRadius,
              onPressed: () {
                _signOut(context); // Call the sign out function
              },
              icon: Icon(
                Icons.logout,
                color: kAppBarActionIconColor,
              ),
            ),

            PopupMenuButton(
              splashRadius: kDefaultSplashRadius,
              icon: Icon(
                Icons.more_vert,
                color: kAppBarActionIconColor,
              ),
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    child: const Text(
                      "New Group",
                    ),
                    onTap: () {
                      // wait for the menu to close before navigating
                      Future(() => Navigator.pushNamed(context, PageRouter.createGroup));
                    },
                  ),
                ];
              },
            ),
          ],
        ),
        body: TabBarView(
          controller: controller,
          children: const [
            ChatList(),
            CallList(),
          ],
        ),
        floatingActionButton: floatingWidgets,
      ),
    );
  }

  Widget get floatingWidgets {
    return FloatingActionButton(
      backgroundColor: kPrimaryColor,
      heroTag: 'lower',
      onPressed: () {
        if (controller.index == 0) {
          // Show contact list (for chat)
          Navigator.pushNamed(context, PageRouter.selectContact);
        } else if (controller.index == 1) {
          // Start a new call (for calls)
          Navigator.pushNamed(context, PageRouter.selectContact);  // You can replace this with your desired call action.
        }
      },
      child: Icon(
        controller.index == 0 ? Icons.contact_page : Icons.call,  // Show different icons based on the tab
        color: Colors.white,
      ),
    );
  }

  // Sign out function
  void _signOut(BuildContext context) {
    // Add your sign-out logic here (e.g., clearing user session or token)
    
    // Navigate to the welcome page after sign-out
    Navigator.pushReplacementNamed(context, PageRouter.welcome); // Replace with your actual route for the welcome page
  }
}
