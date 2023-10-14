import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/Providers/AuthProvider.dart';
import 'package:todo/ui/DialogUtils.dart';
import 'package:todo/ui/Login/LoginScreen.dart';
import 'package:todo/ui/home/AddTaskSheet.dart';
import 'package:todo/ui/home/settingsTab/settingsTab.dart';
import 'package:todo/ui/home/tasksList/TasksListTab.dart';

class HomeScreen extends StatefulWidget {
static const String routeName='HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Route Tasks App'),
        leading: IconButton(
          icon: Icon(Icons.logout),
          onPressed: () {
            logout();

        },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child:Icon(Icons.add) ,
        shape: StadiumBorder(
         side:   BorderSide(
              color: Colors.white,
              width: 4
            )
        ),
        onPressed: (){
          showAddTaskBottomSheet();
        },
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 12,
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          backgroundColor: Colors.transparent,
          elevation: 0,
          onTap: (index){
            setState(() {
              selectedIndex=index;
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.list),
                label: '',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.settings),label: ''),
          ],
        ),
      ),
      body: tabs[selectedIndex],
    );
  }

  int selectedIndex = 0;

  var tabs =[SettingsTab(),TasksList()];

  void logout() {
    var authProvider = Provider.of<AuthProvider>(context,listen: false);
    DialogUtils.showMessage(context, 'Are you sure ?' ,

    PosActionTitle:"Yes",
    posAction: (){
      authProvider.logout();
      Navigator.of(context)
          .pushReplacementNamed(LoginScreen.routeName);
    },
      NegActionTitle: "Cancel",
    );

  }

  void showAddTaskBottomSheet() {
    showModalBottomSheet(context: context, builder: (buildContext){
      return AddTaskBottomSheet();
    });
  }
}
