import 'package:flutter/material.dart';
// class ErrorView extends StatelessWidget {
//   const ErrorView({required this.message, required this.onRetry});
//   final String message; final VoidCallback onRetry;
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Icon(Icons.error_outline, size: 38),
//             const SizedBox(height: 8),
//             Text('Something went wrong', style: Theme.of(context).textTheme.titleMedium),
//             const SizedBox(height: 6),
//             Text(message, textAlign: TextAlign.center, style: const TextStyle(color: Colors.black54)),
//             const SizedBox(height: 12),
//             FilledButton(onPressed: onRetry, child: const Text('Retry')),
//           ],
//         ),
//       ),
//     );
//   }
// }
class ErrorView extends StatelessWidget {
  const ErrorView({super.key,required this.message, required this.onRetry});
  final String message; final VoidCallback onRetry;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 38),
            const SizedBox(height: 8),
            Text('Something went wrong', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 6),
            Text(message, textAlign: TextAlign.center, style: const TextStyle(color: Colors.black54)),
            const SizedBox(height: 12),
            FilledButton(onPressed: onRetry, child: const Text('Retry')),
          ],
        ),
      ),
    );
  }
}
