import 'package:flutter/material.dart';

class BaseLevelScreen extends StatefulWidget {

  final String title;

  final List<Map<String, dynamic>> arabicItems;

  final List<Map<String, dynamic>> mathItems;

  const BaseLevelScreen({
    super.key,
    required this.title,
    required this.arabicItems,
    required this.mathItems,
  });

  @override
  State<BaseLevelScreen> createState() => _BaseLevelScreenState();
}

class _BaseLevelScreenState extends State<BaseLevelScreen> {

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {

    List<Map<String, dynamic>> currentItems;

    if (selectedIndex == 0) {
      currentItems = widget.arabicItems;
    } else {
      currentItems = widget.mathItems;
    }

    return Scaffold(

      body: Container(

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
            children: [

              const SizedBox(height: 25),

              Text(
                widget.title,

                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 25),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [

                  buildButton(
                    "اللغة العربية",
                    0,
                    Icons.menu_book,
                  ),

                  const SizedBox(width: 12),

                  buildButton(
                    "رياضيات",
                    1,
                    Icons.calculate,
                  ),
                ],
              ),

              const SizedBox(height: 30),

              Expanded(

                child: Padding(

                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                  ),

                  child: GridView.builder(

                    itemCount: currentItems.length,

                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(

                      crossAxisCount: 2,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                      childAspectRatio: 0.59,
                    ),

                    itemBuilder: (context, index) {

                      return buildCard(
                        context,
                        currentItems[index],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================== الكارت ==================

  Widget buildCard(
      BuildContext context,
      Map<String, dynamic> item,
      ) {

    return GestureDetector(

      onTap: () {

        Navigator.push(

          context,

          MaterialPageRoute(
            builder: (context) => item["page"],
          ),
        );
      },

      child: Container(

        margin: const EdgeInsets.all(5),

        padding: const EdgeInsets.all(15),

        decoration: BoxDecoration(

          color: item["color"],

          borderRadius: BorderRadius.circular(30),

          boxShadow: const [

            BoxShadow(
              color: Colors.black38,
              blurRadius: 12,
              offset: Offset(0, 6),
            ),
          ],
        ),

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            Container(

              width: 105,
              height: 105,

              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),

              child: ClipOval(

                child: Padding(

                  padding: const EdgeInsets.all(10),

                  child: Image.asset(
                    item["image"],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            Text(

              item["title"],

              textAlign: TextAlign.center,

              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================== زر التبديل ==================

  Widget buildButton(
      String text,
      int index,
      IconData icon,
      ) {

    bool isSelected = selectedIndex == index;

    return GestureDetector(

      onTap: () {

        setState(() {
          selectedIndex = index;
        });
      },

      child: AnimatedContainer(

        duration: const Duration(milliseconds: 250),

        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 12,
        ),

        decoration: BoxDecoration(

          color: isSelected
              ? Colors.white
              : Colors.white.withOpacity(0.25),

          borderRadius: BorderRadius.circular(25),

          boxShadow: isSelected
              ? [
            const BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ]
              : [],
        ),

        child: Row(
          children: [

            Icon(
              icon,
              size: 20,

              color: isSelected
                  ? Colors.black
                  : Colors.white,
            ),

            const SizedBox(width: 6),

            Text(

              text,

              style: TextStyle(
                fontWeight: FontWeight.bold,

                color: isSelected
                    ? Colors.black
                    : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}