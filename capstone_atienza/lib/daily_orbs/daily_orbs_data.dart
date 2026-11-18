import 'package:flutter/material.dart';

/// One thing to sort, and the option it belongs to.
class OrbItem {
  final String label;
  final String answer;
  const OrbItem(this.label, this.answer);
}

class OrbPuzzle {
  final String title;
  final String instruction;
  final Color color;
  final List<String> options;
  final List<OrbItem> items;

  const OrbPuzzle({
    required this.title,
    required this.instruction,
    required this.color,
    required this.options,
    required this.items,
  });
}

/// Today's four puzzles (one day only). Edit these to change the content.
const todaysPuzzles = <OrbPuzzle>[
  OrbPuzzle(
    title: 'Cebu Sort',
    instruction: 'Sort each Cebu name into what it is.',
    color: Color(0xFFF08A24),
    options: ['Food', 'Festival', 'Landmark'],
    items: [
      OrbItem('Lechon', 'Food'),
      OrbItem('Sinulog', 'Festival'),
      OrbItem('Magellan\'s Cross', 'Landmark'),
      OrbItem('Puso', 'Food'),
      OrbItem('Kadaugan sa Mactan', 'Festival'),
      OrbItem('Fort San Pedro', 'Landmark'),
    ],
  ),
  OrbPuzzle(
    title: 'Subject Sort',
    instruction: 'Which subject does each topic belong to?',
    color: Color(0xFF3DA35D),
    options: ['Math', 'Science', 'Programming'],
    items: [
      OrbItem('Integral', 'Math'),
      OrbItem('Mitosis', 'Science'),
      OrbItem('Array', 'Programming'),
      OrbItem('Quadratic equation', 'Math'),
      OrbItem('Newton\'s laws', 'Science'),
      OrbItem('Compiler', 'Programming'),
    ],
  ),
  OrbPuzzle(
    title: 'Campus Spots',
    instruction: 'Where on campus would you go?',
    color: Color(0xFF3B8FE0),
    options: ['Library', 'Registrar', 'Canteen', 'Gym'],
    items: [
      OrbItem('Borrow a book', 'Library'),
      OrbItem('Request a transcript', 'Registrar'),
      OrbItem('Eat lunch', 'Canteen'),
      OrbItem('Shoot hoops', 'Gym'),
      OrbItem('Quiet study time', 'Library'),
      OrbItem('Get an enrollment form', 'Registrar'),
    ],
  ),
  OrbPuzzle(
    title: 'Tech Sort',
    instruction: 'Is it hardware, software, or network?',
    color: Color(0xFFA044C4),
    options: ['Hardware', 'Software', 'Network'],
    items: [
      OrbItem('Keyboard', 'Hardware'),
      OrbItem('Android', 'Software'),
      OrbItem('Router', 'Network'),
      OrbItem('Processor', 'Hardware'),
      OrbItem('Wi-Fi', 'Network'),
      OrbItem('Web browser', 'Software'),
    ],
  ),
];
