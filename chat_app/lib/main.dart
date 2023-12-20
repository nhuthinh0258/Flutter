import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chat_app/screen/user.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: App()));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterChat',
      theme: ThemeData.dark().copyWith(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 147, 229, 250),
            surface: const Color.fromARGB(255, 1, 94, 15),
          ),
          scaffoldBackgroundColor: const Color.fromARGB(255, 240, 235, 235),
          primaryColorLight: const Color.fromARGB(255, 230, 228, 193),
          primaryColorDark: const Color.fromARGB(255, 161, 161, 147)),
      home:const UserScreen(),
    );
  }
}
// StreamBuilder(
//         stream: firebase.authStateChanges(),
//         builder: (ctx, snapshot) {
//           if(snapshot.connectionState == ConnectionState.waiting){
//             return const SlashScreen();
//           }
//           if (snapshot.hasData) {
//             return const ChatScreen();
//           }
//           return const AuthScreen();
//         },
//       ),
