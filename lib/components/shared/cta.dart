import 'package:flutter/material.dart';
import 'package:fampay/model/cta.dart';

import '../../utils/launchUrl.dart';
import '../../utils/parse_color.dart';
class CtasRow extends StatelessWidget {
  const CtasRow({required this.ctas});
  final List<CtaModel> ctas;
  @override
  Widget build(BuildContext context) {
    if (ctas.isEmpty) return const SizedBox.shrink();
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: ctas.map((c) => CtaButton(cta: c)).toList(),
    );
  }
}

class CtaButton extends StatelessWidget {
  const CtaButton({required this.cta});
  final CtaModel cta;
  @override
  Widget build(BuildContext context) {
    final bg = cta.bgColor != null ? parseColor(cta.bgColor!) : Theme.of(context).primaryColor;
    final fg = cta.textColor != null ? parseColor(cta.textColor!) : Colors.white;
    return SizedBox(
      height: 36,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: bg,
          foregroundColor: fg,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: () => tryLaunch(cta.url),
        child: Text(cta.text, style: const TextStyle(fontWeight: FontWeight.w600)),
      ),
    );
  }
}
