import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class ContactPageView extends StatefulWidget {
  const ContactPageView({super.key});

  @override
  State<ContactPageView> createState() => _ContactPageViewState();
}

class _ContactPageViewState extends State<ContactPageView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * .4),
              FadeIn(
                duration: Duration(seconds: 3),
                child: Text.rich(
                  TextSpan(
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 10,
                    ),
                    children: [
                      TextSpan(text: 'SAVE'),
                      TextSpan(text: 'i', style: TextStyle(color: Colors.red)),
                      TextSpan(text: 'T'),
                    ],
                  ),
                ),
              ),
              FadeIn(
                delay: Duration(seconds: 1),
                duration: Duration(seconds: 3),
                child: Text('Developed By Monirul Islam (MTechBD)'),
              ),
              Spacer(),
              FadeInUp(
                delay: Duration(seconds: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CupertinoButton(
                      onPressed: () {},
                      child: Image.asset('assets/icons/facebook.png', height: 40),
                    ),
                    CupertinoButton(
                      onPressed: () {},
                      child: Image.asset('assets/icons/instagram.png', height: 40),
                    ),
                    CupertinoButton(
                      onPressed: () {},
                      child: Image.asset('assets/icons/email.png', height: 40),
                    ),
                    CupertinoButton(
                      onPressed: () {},
                      child: Image.asset('assets/icons/playstore.png', height: 40),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
