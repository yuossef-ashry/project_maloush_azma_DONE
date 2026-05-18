import 'package:flutter/material.dart';
import '../../common/widgets/learning_game_screen.dart';
<<<<<<< HEAD
class LettersGame extends StatelessWidget {
  const LettersGame({super.key});
=======

class LettersGame extends StatelessWidget {
  const LettersGame({super.key});

>>>>>>> 1472ab6b5b00eb0985135fbbc09239836360ebe8
  @override
  Widget build(BuildContext context) {
    return LearningGameScreen(
      title: "تعلم الحروف",
<<<<<<< HEAD
      mainColor: Colors.orange,
      items: const [
        {
          "main": "أ",
          "word": "أسد",
          "emoji": "🦁",
          "sound": "أ",
        },

        {
          "main": "ب",
          "word": "بطة",
          "emoji": "🦆",
          "sound": "ب",
        },

        {
          "main": "ت",
          "word": "تفاحة",
          "emoji": "🍎",
          "sound": "ت",
        },

        {
          "main": "ث",
          "word": "ثعلب",
          "emoji": "🦊",
          "sound": "ث",
        },

        {
          "main": "ج",
          "word": "جمل",
          "emoji": "🐫",
          "sound": "ج",
        },

        {
          "main": "ح",
          "word": "حصان",
          "emoji": "🐎",
          "sound": "ح",
        },

        {
          "main": "خ",
          "word": "خروف",
          "emoji": "🐑",
          "sound": "خ",
        },

        {
          "main": "د",
          "word": "دب",
          "emoji": "🐻",
          "sound": "د",
        },

        {
          "main": "ذ",
          "word": "ذئب",
          "emoji": "🐺",
          "sound": "ذ",
        },

        {
          "main": "ر",
          "word": "رمان",
          "emoji": "🍉",
          "sound": "ر",
        },

        {
          "main": "ز",
          "word": "زهرة",
          "emoji": "🌸",
          "sound": "ز",
        },

        {
          "main": "س",
          "word": "سمكة",
          "emoji": "🐟",
          "sound": "س",
        },

        {
          "main": "ش",
          "word": "شمس",
          "emoji": "☀️",
          "sound": "ش",
        },

        {
=======

      mainColor: Colors.orange,

      items: const [
        {
          "main": "أ",
          "word": "أسد",
          "emoji": "🦁",
          "sound": "أ",
        },

        {
          "main": "ب",
          "word": "بطة",
          "emoji": "🦆",
          "sound": "ب",
        },

        {
          "main": "ت",
          "word": "تفاحة",
          "emoji": "🍎",
          "sound": "ت",
        },

        {
          "main": "ث",
          "word": "ثعلب",
          "emoji": "🦊",
          "sound": "ث",
        },

        {
          "main": "ج",
          "word": "جمل",
          "emoji": "🐫",
          "sound": "ج",
        },

        {
          "main": "ح",
          "word": "حصان",
          "emoji": "🐎",
          "sound": "ح",
        },

        {
          "main": "خ",
          "word": "خروف",
          "emoji": "🐑",
          "sound": "خ",
        },

        {
          "main": "د",
          "word": "دب",
          "emoji": "🐻",
          "sound": "د",
        },

        {
          "main": "ذ",
          "word": "ذئب",
          "emoji": "🐺",
          "sound": "ذ",
        },

        {
          "main": "ر",
          "word": "رمان",
          "emoji": "🍉",
          "sound": "ر",
        },

        {
          "main": "ز",
          "word": "زهرة",
          "emoji": "🌸",
          "sound": "ز",
        },

        {
          "main": "س",
          "word": "سمكة",
          "emoji": "🐟",
          "sound": "س",
        },

        {
          "main": "ش",
          "word": "شمس",
          "emoji": "☀️",
          "sound": "ش",
        },

        {
>>>>>>> 1472ab6b5b00eb0985135fbbc09239836360ebe8
          "main": "ص",
          "word": "صقر",
          "emoji": "🦅",
          "sound": "ص",
        },

        {
          "main": "ض",
          "word": "ضفدع",
          "emoji": "🐸",
          "sound": "ض",
        },

        {
          "main": "ط",
          "word": "طائرة",
          "emoji": "✈️",
          "sound": "ط",
        },

        {
          "main": "ظ",
          "word": "ظرف",
          "emoji": "✉️",
          "sound": "ظ",
        },

        {
          "main": "ع",
          "word": "عصفور",
          "emoji": "🐦",
          "sound": "ع",
        },

        {
          "main": "غ",
          "word": "غزال",
          "emoji": "🦌",
          "sound": "غ",
        },

        {
          "main": "ف",
          "word": "فيل",
          "emoji": "🐘",
          "sound": "ف",
        },

        {
          "main": "ق",
          "word": "قطة",
          "emoji": "🐱",
          "sound": "ق",
        },

        {
          "main": "ك",
          "word": "كرة",
          "emoji": "⚽",
          "sound": "ك",
        },

        {
          "main": "ل",
          "word": "ليمون",
          "emoji": "🍋",
          "sound": "ل",
        },

        {
          "main": "م",
          "word": "موز",
          "emoji": "🍌",
          "sound": "م",
        },

        {
          "main": "ن",
          "word": "نجمة",
          "emoji": "⭐",
          "sound": "ن",
        },

        {
          "main": "ه",
          "word": "هلال",
          "emoji": "🌙",
          "sound": "ه",
        },

        {
          "main": "و",
          "word": "وردة",
          "emoji": "🌹",
          "sound": "و",
        },

        {
          "main": "ي",
          "word": "يد",
          "emoji": "✋",
          "sound": "ي",
        },
      ],
    );
  }
}