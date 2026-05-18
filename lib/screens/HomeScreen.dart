import 'package:flutter/material.dart';
import '../screens/LevelOneScreen.dart';
import '../screens/LevelTwoScreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF4FC3F7),
              Color(0xFF81C784),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                " متعلمي الصغير",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),


              const SizedBox(height: 50),


              Container(
                width: 230,
                height: 230,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 30,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),



                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: ClipOval(
                    child: Image.asset(
                      "assets/images/kid.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              LevelCard(
                title: "المستوى الأول",
                subtitle: "الروضة",
                stars: 5,
                color: Colors.orange,
                image: "assets/images/bear.png",

                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const LevelOneScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),

              LevelCard(
                title: "المستوى الثاني",
                subtitle: "المدرسة",
                stars: 8,
                color: Colors.purple,
                image: "assets/images/bag.png",

                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const LevelTwoScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LevelCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final int stars;
  final Color color;
  final String image;
  final VoidCallback onTap;

  const LevelCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.stars,
    required this.color,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        width: 340,
        padding: const EdgeInsets.all(18),

        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),

          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 15,
              offset: Offset(0, 8),
            ),
          ],
        ),

        child: Row(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),

              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(width: 15),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),

                  const SizedBox(height: 10),

          
                  Row(
                    children: List.generate(
                      stars,
                          (index) {
                        return const Padding(
                          padding: EdgeInsets.only(right: 2),
                          child: Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 18,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

         
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}