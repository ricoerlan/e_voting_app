import 'package:e_voting/view/auth/login/widget/login_form.dart';
import 'package:e_voting/view/auth/login/widget/login_screen_top_image.dart';
import 'package:flutter/material.dart';

class MobileLoginScreen extends StatefulWidget {
  final PageController pageController;
  final int currentIndex;

  const MobileLoginScreen({
    super.key,
    required this.pageController,
    required this.currentIndex,
  });

  @override
  State<MobileLoginScreen> createState() => _MobileLoginScreenState();
}

class _MobileLoginScreenState extends State<MobileLoginScreen> {
  late PageController pageController;
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    pageController = widget.pageController;
    currentIndex = widget.currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const LoginScreenTopImage(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildPageIndicator(0),
                  _buildPageIndicator(1),
                ],
              ),
            ],
          ),
        ),
        Container(
          height: 500,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: PageView(
            controller: pageController,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            children: [
              LoginForm(role: 'voter', currentIndex: currentIndex),
              LoginForm(role: 'committee', currentIndex: currentIndex),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildPageIndicator(int index) {
    return GestureDetector(
      onTap: () {
        if (index == 1) {
          currentIndex = 0;
          setState(() {});
        } else {
          currentIndex = 1;
          setState(() {});
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color:
              currentIndex == index ? Colors.grey.shade300 : Colors.blueAccent,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: currentIndex == index
                  ? Colors.transparent
                  : Colors.blue.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 5,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              index == 0 ? Icons.how_to_vote : Icons.group_add,
              color: currentIndex == index ? Colors.grey : Colors.white,
              size: 18,
            ),
            const SizedBox(width: 8),
            Text(
              index == 0 ? 'Login as Voter' : 'Login as Committee',
              style: TextStyle(
                color:
                    currentIndex == index ? Colors.grey.shade600 : Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
