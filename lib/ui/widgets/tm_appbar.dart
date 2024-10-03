import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/screens/sign_in_screen.dart';

class TMAppBar extends StatelessWidget implements PreferredSizeWidget{
  const TMAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green[500],
      title: Row(
        children: [
          const CircleAvatar(
            backgroundImage: AssetImage('https://images.csmonitor.com/csmarchives/2011/10/JOBSNECK.JPG?alias=standard_900x600nc'),
            radius: 18,
          ),
          const SizedBox(width: 16),
          const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ice Bear',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.white),
              ),
              Text('icebear@gmail.com',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: Colors.white))
            ],
          )),
          IconButton(onPressed: (){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> const SignInScreen()), (predicate)=> false);
          }, icon: Icon(Icons.logout, color: Colors.grey[800],))
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
