import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/useradd.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<FirebaseApp> _firebaseApp = Firebase.initializeApp();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: _firebaseApp,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print('Error: ${snapshot.error.toString()}');
            return Text('Hay un error');
          } else if (snapshot.hasData) {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 100,
                      child: Column(
                        children: [
                          Text('Firebase'),
                          AddUser('Ernesto', 'Mesoamericana', 29)
                        ],
                      ),
                    ),
                    Container(
                      height: 500,
                      child: UserInformation(),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

class UserInformation extends StatefulWidget {
  @override
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('users').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return ListTile(
              title: Text(data['full_name']),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserDetailPage(
                      usuarios: document,
                    ),
                  ),
                );
              },
            );
          }).toList(),
        );
      },
    );
  }
}

class UserDetailPage extends StatefulWidget {
  final DocumentSnapshot usuarios;
  UserDetailPage({Key? key, required this.usuarios}) : super(key: key);

  @override
  _UserDetailPageState createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> usuario =
        widget.usuarios.data()! as Map<String, dynamic>;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                usuario['image'] == null
                    ? Container()
                    : Image.network(usuario['image'].toString()),
                Text('''Nombre: ${usuario['full_name']}'''),
                Text('''Compañia: ${usuario['company']}'''),
                Text('''Edad: ${usuario['age']}'''),
              ],
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Regresar'),
            ),
          ],
        ),
      ),
    );
  }
}
