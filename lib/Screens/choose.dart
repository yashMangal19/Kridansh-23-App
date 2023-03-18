import 'package:flutter/material.dart';

class Choose extends StatefulWidget {
  const Choose({super.key});

  @override
  State<Choose> createState() => _ChooseState();
}

class _ChooseState extends State<Choose> {
  @override
  Widget build(BuildContext context) {
    Size pageSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 201, 139),
        body: Column(
          children: [
            Container(
              height: pageSize.height * .55,
              width: pageSize.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      "assets/images/istockphoto-1141191007-612x612.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const DecoratedBox(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image:
                                AssetImage("assets/images/kridansh_logo.jpeg"),
                          ),
                        ),
                      ),
                      // const Text(
                      //   "Kreedansh",
                      //   style: TextStyle(fontSize: 36),
                      // ),
                      const SizedBox(
                        height: 320,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.pink[800])),
                        child: const Text(
                          "Log In",
                          style: TextStyle(
                              color: Color.fromARGB(255, 218, 150, 6)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: pageSize.height * .40,
              width: pageSize.width,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                image: DecorationImage(
                  image: AssetImage(
                    "assets/images/fire.jpg",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.amber[700])),
                        onPressed: () {},
                        child: const Text(
                          "Sign Up",
                          style:
                              TextStyle(color: Color.fromARGB(255, 171, 3, 42)),
                        ),
                      ),
                      const SizedBox(
                        height: 1000,
                      ),
                    ],
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
