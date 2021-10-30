import 'package:flutter/material.dart';
import 'package:question/Screens/AdminScreen/choice.dart';
import 'package:question/Screens/AdminScreen/question.dart';
import 'package:question/Screens/AdminScreen/subCatagory.dart';
import 'package:question/Screens/AdminScreen/useranswer.dart';
import 'package:question/models/userModel.dart';
import 'package:question/util/auth.dart';
import 'package:question/util/shared_Refernce.dart';
import 'package:question/constants.dart';
import 'package:question/widgets/CustomDivider.dart';
import 'package:provider/provider.dart';
import 'AdminScreen/UsersList.dart';
import 'AdminScreen/catagory.dart';
import 'Login/login_screen.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  final List<Widget> _widgetOptions = [
    UserListPage(),
    CatagoryPage(),
    SubCatagoryPage(),
    QuestionPage(),
    ChoicePage(),
    UsersAnswerPage()
  ];
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  SharedPreferencesUtil _preferencesUtil = new SharedPreferencesUtil();

  late String _username;
  late String _email;
  late String _userTpe;
  String title = "";

  @override
  Widget build(BuildContext context) {
    _username = _preferencesUtil.getUserName().toUpperCase();
    _email = _preferencesUtil.getEmail().toUpperCase();
    _userTpe = _preferencesUtil.getUserType();

    title = _userTpe == "UserType.admin" ? "Admin Page" : "User Page";
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(title),
        backgroundColor: kPrimaryColor,
      ),
      drawer: Drawer(
          child: ListView(padding: EdgeInsets.zero, children: [
        Container(
          margin: const EdgeInsets.only(bottom: 8.0),
          child: DrawerHeader(
            decoration: BoxDecoration(
              color: kPrimaryColor,
            ),
            child: Column(
              children: [
                SizedBox.fromSize(
                  size: Size.square(72),
                  child: CircleAvatar(
                    child: Text(
                      "${_username[0]}",
                      style: TextStyle(fontSize: 40.0),
                    ),
                  ),

                  //CircleAvatar(child: Text("B", style: TextStyle(fontSize: 40.0),))
                ),
                SizedBox(
                  height: 16,
                ),
                Text(_username,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(color: Colors.white)),
                SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _userTpe == "UserType.user"
                          ? "user".toUpperCase()
                          : "admin".toUpperCase(),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text("|  ", style: TextStyle(color: Colors.white)),
                    Text(_email, style: TextStyle(color: Colors.white)),
                  ],
                )
              ],
            ),
          ),
        ),
        _buildDrawerActionItems(
          context,
          isSelected: _currentIndex == 0,
          onPressed: () => {
            setState(() {
              _currentIndex = 0;
              Navigator.pop(context);
            })
          },
          label: "Users",
          icon: Icons.people_alt_outlined,
        ),
        _buildDrawerActionItems(
          context,
          isSelected: _currentIndex == 1,
          onPressed: () => {
            setState(() {
              _currentIndex = 1;
              Navigator.pop(context);
            })
          },
          label: "Catagory",
          icon: Icons.category_outlined,
        ),
        _buildDrawerActionItems(
          context,
          isSelected: _currentIndex == 2,
          onPressed: () => {
            setState(() {
              _currentIndex = 2;
              Navigator.pop(context);
            })
          }, //
          label: "Sub Catagory",
          icon: Icons.category_outlined,
        ),
        _buildDrawerActionItems(
          context,
          isSelected: _currentIndex == 3,
          onPressed: () => {
            setState(() {
              _currentIndex = 3;
              Navigator.pop(context);
            })
          },
          label: "Question",
          icon: Icons.question_answer_outlined,
        ),
        _buildDrawerActionItems(
          context,
          isSelected: _currentIndex == 4,
          onPressed: () => {
            setState(() {
              _currentIndex = 4;
              Navigator.pop(context);
            })
          },
          label: "Choices",
          icon: Icons.multiple_stop_outlined,
        ),
        _buildDrawerActionItems(
          context,
          isSelected: _currentIndex == 5,
          onPressed: () => {
            setState(() {
              _currentIndex = 5;
              Navigator.pop(context);
            })
          },
          label: "Users Answer",
          icon: Icons.replay_10_outlined,
        ),
          CustomDivider(),
            _buildDrawerActionItems(context,onPressed: (){
             Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
            },
            label: "Sign Out",
            icon: Icons.logout_outlined,),
          
      ])),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        fixedColor: kPrimaryColor,
        items: [
          BottomNavigationBarItem(
              label:"U", icon: Icon(Icons.people_alt_outlined)),
               BottomNavigationBarItem(
              label: "C", icon: Icon(Icons.category_outlined)),
               BottomNavigationBarItem(
              label: "SC", icon: Icon(Icons.category_outlined)),
          BottomNavigationBarItem(
              label: "Q", icon: Icon(Icons.question_answer_outlined)),
                BottomNavigationBarItem(
              label: "Ch", icon: Icon(Icons.multiple_stop_outlined)),
          BottomNavigationBarItem(
              label: "UA", icon: Icon(Icons.replay_10_outlined)),
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            switch (index) {
              case 0:
                title = "Users";
                break;
              case 1:
                title = "Catagory";
                break;
                  case 2:
                title = "Sub Catagory";
                break;
                  case 3:
                title = "Question";
                break;

              case 4:
                title = "Choices";
                break;
                case 5:
                title = "Users Answer";
                break;
           
            }
          });
        },
      ),
      body: widget._widgetOptions.elementAt(_currentIndex),
    );
  }

  Widget _buildDrawerActionItems(
    BuildContext context, {
    isSelected = false,
    required String label,
    required VoidCallback onPressed,
    required IconData icon,
  }) {
    var theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Row(
        children: [
          Icon(
            icon,
            color: isSelected ? theme.primaryColor : null,
          ),
          SizedBox(
            width: 16,
          ),
          GestureDetector(
              onTap: onPressed,
              child: Text(
                label,
                style: isSelected
                    ? theme.textTheme.button!
                        .copyWith(color: theme.primaryColor)
                    : theme.textTheme.button!
                        .copyWith(fontWeight: FontWeight.normal),
              )),
        ],
      ),
    );
  }
}
