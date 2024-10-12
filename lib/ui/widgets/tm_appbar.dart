import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/screens/screens%20after%20signing%20in/profile_screen.dart';
import 'package:task_manager_app/ui/screens/sign_in_screen.dart';

class TMAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TMAppBar({
    super.key, this.isProfileScreenOpen = false,
  });

  final bool isProfileScreenOpen;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green[500],
      title: Row(
        children: [
          // the profile picture
          const CircleAvatar(
            backgroundImage: NetworkImage(
                'https://i1.rgstatic.net/ii/profile.image/604752320659456-1521195597297_Q512/Ya-Ran-2.jpg'),
            radius: 18,
          ),

          const SizedBox(width: 16),

           Expanded(
            child: GestureDetector(
              onTap: (){
                if (isProfileScreenOpen){
                  return;
                }
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const ProfileScreen(),),);
              },
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ice Bear',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.white),
                  ),
                  Text('icebear@gmail.com',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: Colors.white))
                ],
              ),
            ),
          ),
          IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignInScreen()),
                    (predicate) => false);
              },
              icon: Icon(
                Icons.logout,
                color: Colors.grey[800],
              ))
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
