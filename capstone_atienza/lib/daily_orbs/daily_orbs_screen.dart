import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../theme/app_theme.dart';
import 'daily_orbs_data.dart';

const int orbsToWin = 6;
const int startingHearts = 3;

/// Progress for one puzzle: solved items, wrong guesses, hearts left.
class PuzzleProgress {
  PuzzleProgress(this.puzzle);

  final OrbPuzzle puzzle;
  final Set<int> solved = {};
  final Map<int, Set<String>> wrong = {};
  int hearts = startingHearts;

  /// 3 orbs per puzzle, filled as correct answers come in.
  int get orbs => solved.length * 3 ~/ puzzle.items.length;
  bool get locked => hearts <= 0;
  bool get complete => solved.length == puzzle.items.length;
}

/// Game state for today. Kept in memory while the app is open.
class OrbsGame extends ChangeNotifier {
  OrbsGame(List<OrbPuzzle> puzzles)
      : progress = [for (final p in puzzles) PuzzleProgress(p)];

  final List<PuzzleProgress> progress;

  int get totalOrbs => progress.fold(0, (sum, p) => sum + p.orbs);
  bool get won => totalOrbs >= orbsToWin;

  void answer(PuzzleProgress p, int itemIndex, String option) {
    if (p.locked || p.solved.contains(itemIndex)) return;
    final tried = p.wrong.putIfAbsent(itemIndex, () => {});
    if (tried.contains(option)) return;

    if (option == p.puzzle.items[itemIndex].answer) {
      p.solved.add(itemIndex);
    } else {
      tried.add(option);
      p.hearts--; // wrong answer costs a heart
    }
    notifyListeners();
  }
}

final OrbsGame orbsGame = OrbsGame(todaysPuzzles);

// ---------------------------------------------------------------------------
// Small pieces
// ---------------------------------------------------------------------------

class _OrbRow extends StatelessWidget {
  final int filled;
  final int total;
  final Color color;
  final double size;

  const _OrbRow({
    required this.filled,
    required this.color,
    this.total = 3,
    this.size = 18,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < total; i++)
          Container(
            width: size,
            height: size,
            margin: const EdgeInsets.only(right: 6),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: i < filled ? color : Colors.transparent,
              border: Border.all(color: color, width: 2),
            ),
          ),
      ],
    );
  }
}

class _HeartRow extends StatelessWidget {
  final int hearts;
  final Color color;

  const _HeartRow({required this.hearts, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < startingHearts; i++)
          Padding(
            padding: const EdgeInsets.only(right: 4),
            child: Icon(
              i < hearts ? Icons.favorite : Icons.favorite_border,
              size: 18,
              color: color,
            ),
          ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Screen 1: today's four puzzles
// ---------------------------------------------------------------------------

class DailyOrbsScreen extends StatelessWidget {
  const DailyOrbsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Daily Orbs')),
      body: ListenableBuilder(
        listenable: orbsGame,
        builder: (context, _) {
          final total = orbsGame.totalOrbs;
          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
            children: [
              Text(
                DateFormat('EEEE, MMMM d, y').format(DateTime.now()),
                style: textTheme.titleMedium?.copyWith(color: AppColors.muted),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _OrbRow(
                    filled: total.clamp(0, orbsToWin),
                    total: orbsToWin,
                    color: AppColors.navy,
                    size: 16,
                  ),
                  const SizedBox(width: 6),
                  Text('$total / $orbsToWin orbs to win',
                      style: textTheme.bodyMedium
                          ?.copyWith(color: AppColors.muted)),
                ],
              ),
              if (orbsGame.won) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.navy,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.emoji_events_outlined,
                          color: Colors.white),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text('You won today! Come back tomorrow.',
                            style: textTheme.titleSmall
                                ?.copyWith(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 16),
              for (var i = 0; i < orbsGame.progress.length; i++)
                _PuzzleTile(index: i),
            ],
          );
        },
      ),
    );
  }
}

class _PuzzleTile extends StatelessWidget {
  final int index;

  const _PuzzleTile({required this.index});

  @override
  Widget build(BuildContext context) {
    final p = orbsGame.progress[index];
    final color = p.puzzle.color;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => PuzzleScreen(index: index)),
          ),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(width: 6, color: color),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(p.puzzle.title,
                                  style: textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.w700)),
                              const SizedBox(height: 4),
                              Text(p.puzzle.instruction,
                                  style: textTheme.bodySmall
                                      ?.copyWith(color: AppColors.muted)),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            _OrbRow(filled: p.orbs, color: color),
                            const SizedBox(height: 8),
                            _HeartRow(hearts: p.hearts, color: color),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Screen 2: one puzzle
// ---------------------------------------------------------------------------

class PuzzleScreen extends StatelessWidget {
  final int index;

  const PuzzleScreen({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final p = orbsGame.progress[index];
    final puzzle = p.puzzle;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text(puzzle.title)),
      body: ListenableBuilder(
        listenable: orbsGame,
        builder: (context, _) {
          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
            children: [
              Text(puzzle.instruction, style: textTheme.titleMedium),
              const SizedBox(height: 12),
              Row(
                children: [
                  _OrbRow(filled: p.orbs, color: puzzle.color),
                  const Spacer(),
                  _HeartRow(hearts: p.hearts, color: puzzle.color),
                ],
              ),
              if (p.locked) ...[
                const SizedBox(height: 12),
                Text('Out of hearts. You keep the orbs you earned.',
                    style:
                        textTheme.bodyMedium?.copyWith(color: AppColors.urgent)),
              ],
              if (p.complete) ...[
                const SizedBox(height: 12),
                Text('Puzzle complete!',
                    style: textTheme.bodyMedium?.copyWith(
                        color: puzzle.color, fontWeight: FontWeight.w700)),
              ],
              const SizedBox(height: 16),
              for (var i = 0; i < puzzle.items.length; i++)
                _ItemCard(progress: p, itemIndex: i),
            ],
          );
        },
      ),
    );
  }
}

class _ItemCard extends StatelessWidget {
  final PuzzleProgress progress;
  final int itemIndex;

  const _ItemCard({required this.progress, required this.itemIndex});

  @override
  Widget build(BuildContext context) {
    final puzzle = progress.puzzle;
    final item = puzzle.items[itemIndex];
    final solved = progress.solved.contains(itemIndex);
    final tried = progress.wrong[itemIndex] ?? const <String>{};
    final textTheme = Theme.of(context).textTheme;

    Widget body;
    if (solved) {
      body = Row(
        children: [
          Icon(Icons.check_circle, color: puzzle.color, size: 20),
          const SizedBox(width: 6),
          Text(item.answer,
              style: textTheme.bodyLarge?.copyWith(
                  color: puzzle.color, fontWeight: FontWeight.w700)),
        ],
      );
    } else if (progress.locked) {
      body = Text('Answer: ${item.answer}',
          style: textTheme.bodyMedium?.copyWith(color: AppColors.muted));
    } else {
      body = Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          for (final option in puzzle.options)
            ActionChip(
              label: Text(
                option,
                style: tried.contains(option)
                    ? const TextStyle(decoration: TextDecoration.lineThrough)
                    : null,
              ),
              onPressed: tried.contains(option)
                  ? null
                  : () => orbsGame.answer(progress, itemIndex, option),
            ),
        ],
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item.label,
                style: textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            body,
          ],
        ),
      ),
    );
  }
}
