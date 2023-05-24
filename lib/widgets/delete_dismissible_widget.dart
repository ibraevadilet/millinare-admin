import 'package:flutter/material.dart';

class DeleteDismissibleWidget extends StatelessWidget {
  const DeleteDismissibleWidget({
    super.key,
    required this.child,
    required this.onDelete,
  });
  final Widget child;
  final Function() onDelete;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async {
        final result = await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => AlertDialog(
            title: const Text(
              'Вы действтельно хотите удалить?',
              textAlign: TextAlign.center,
            ),
            content: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: const Text('Нет'),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: const Text('Да'),
                  ),
                )
              ],
            ),
          ),
        );
        if (result) {
          onDelete();
        }
        return result;
      },
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            Icon(
              Icons.delete,
              color: Colors.white,
              size: 30,
            ),
            SizedBox(width: 20),
          ],
        ),
      ),
      child: child,
    );
  }
}
