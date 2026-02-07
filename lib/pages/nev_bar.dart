import 'package:flutter/material.dart';

class NevBar extends StatelessWidget {
	final int currentIndex;
	final ValueChanged<int>? onTap;

	const NevBar({Key? key, this.currentIndex = 0, this.onTap}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		final bgColor = const Color(0xFF1F1F1F);
		final accent = const Color(0xFFFFC107);

		return SizedBox(
			height: 92,
			child: Stack(
				alignment: Alignment.topCenter,
				children: [
					Positioned(
						bottom: 12,
						left: 16,
						right: 16,
						child: Container(
							height: 64,
							decoration: BoxDecoration(
								color: bgColor,
								borderRadius: BorderRadius.circular(28),
								boxShadow: [
									BoxShadow(
										color: Colors.black.withOpacity(0.45),
										blurRadius: 12,
										offset: const Offset(0, 6),
									),
								],
							),
							child: Row(
								mainAxisAlignment: MainAxisAlignment.spaceAround,
								children: [
									_NavItem(
										icon: Icons.qr_code,
										label: 'Generate',
										selected: currentIndex == 0,
										onTap: () => onTap?.call(0),
										accent: accent,
									),
									const SizedBox(width: 72),
									_NavItem(
										icon: Icons.history,
										label: 'History',
										selected: currentIndex == 2,
										onTap: () => onTap?.call(2),
										accent: accent,
									),
								],
							),
						),
					),

					Positioned(
						top: 0,
						child: GestureDetector(
							onTap: () => onTap?.call(1),
							child: Container(
								width: 76,
								height: 76,
								decoration: BoxDecoration(
									shape: BoxShape.circle,
									color: accent,
									boxShadow: [
										BoxShadow(
											color: accent.withOpacity(0.35),
											blurRadius: 18,
											spreadRadius: 6,
										),
										BoxShadow(
											color: Colors.black.withOpacity(0.3),
											blurRadius: 6,
											offset: const Offset(0, 4),
										),
									],
								),
								child: Center(
									child: Icon(
										Icons.qr_code_scanner,
										size: 34,
										color: Colors.black87,
									),
								),
							),
						),
					),
				],
			),
		);
	}
}

class _NavItem extends StatelessWidget {
	final IconData icon;
	final String label;
	final bool selected;
	final VoidCallback? onTap;
	final Color accent;

	const _NavItem({
		Key? key,
		required this.icon,
		required this.label,
		this.selected = false,
		this.onTap,
		required this.accent,
	}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		final color = selected ? accent : Colors.white70;
		return GestureDetector(
			onTap: onTap,
			behavior: HitTestBehavior.translucent,
			child: Column(
				mainAxisSize: MainAxisSize.min,
				mainAxisAlignment: MainAxisAlignment.center,
				children: [
					Icon(icon, color: color, size: 22),
					const SizedBox(height: 6),
					Text(
						label,
						style: TextStyle(
							color: color,
							fontSize: 12,
							fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
						),
					),
				],
			),
		);
	}
}

