import 'package:flutter/material.dart';

class userscreen extends StatefulWidget {
  const userscreen({super.key});

  @override
  State<userscreen> createState() => _userscreenState();
}

class _userscreenState extends State<userscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                //height: 250,
                //color: Color(0XFFf6d844),
                padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 70.0),
                decoration: BoxDecoration(
                  color: Color(0xFF967bb6),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40.0),
                    bottomRight: Radius.circular(40.0),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                        child: Image.asset('assets/images/avatar.jpg',fit: BoxFit.contain,),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Anna Avetisyan',
                      style:TextStyle(

                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,

                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            buildProfileItem(Icons.person, 'Anna Avetisyan'),
            buildProfileItem(Icons.cake, 'Birthday'),
            buildProfileItem(Icons.phone, '818 123 4567'),
            buildProfileItem(Icons.camera_alt, 'Instagram account'),
            buildProfileItem(Icons.email, 'info@aplusdesign.co'),
            buildProfileItem(Icons.lock, 'Password', trailing: Icons.sync),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: ElevatedButton(
                onPressed: () {
                  // Handle edit profile button press
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.purple,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF7A08FA), Color(0xFFAD3BFC)],
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(
                      'Edit profile',
                      style: TextStyle(
                          color: Colors.white,

                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget buildProfileItem(IconData icon, String text, {IconData? trailing}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          leading: Icon(icon, color: Colors.purple),
          title: Text(text),
          trailing: trailing != null ? Icon(trailing, color: Colors.purple) : null,
        ),
      ),
    );
  }
}
