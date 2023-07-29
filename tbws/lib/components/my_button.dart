import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String btnText;
  final IconData? icon;
  final Color? backgroudColor;
  final Color? foregroudColor;

  const MyButton(
      {super.key,
      required this.btnText,
      required this.onTap,
      this.icon,
      this.backgroudColor,
      this.foregroudColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: (backgroudColor == null) ? Colors.black : backgroudColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: (icon == null)
            ? Center(
                child: Text(
                  btnText,
                  style: TextStyle(
                    color: (foregroudColor == null)
                        ? Colors.white
                        : foregroudColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, color: foregroudColor),
                  const SizedBox(width: 10),
                  Text(
                    btnText,
                    style: TextStyle(
                      color: (foregroudColor == null)
                          ? Colors.white
                          : foregroudColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
