import 'package:blood_donnation/page/Learningpage/LearningPage1.dart';
import 'package:blood_donnation/page/Learningpage/LearningPage2.dart';
import 'package:blood_donnation/page/Learningpage/LearningPage3.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (int index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: [
              Learningpage1(),
              Learningpage2(),
              Learningpage3(),
            ],
          ),
          // Centrer l'indicateur de page
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.5,
            left: 0,
            right: 0,
            child: _buildPageIndicator(),
          ),
          // Afficher le bouton "Next" uniquement sur la troisième page
          
        ],
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) => _indicator(index == _currentPage)),
    );
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 12.0,
      width: isActive ? 24.0 : 12.0,
      decoration: BoxDecoration(
        color: isActive ? Color.fromARGB(255, 218, 56, 27) : Colors.grey,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
