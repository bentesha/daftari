import '../source.dart';

class DocumentAlertDialog extends StatelessWidget {
  const DocumentAlertDialog(
      {Key? key,
      required this.editDocumentCallback,
      required this.saveDocumentCallback,
      required this.clearChangesCallback,
      required this.isEditing})
      : super(key: key);

  final VoidCallback editDocumentCallback,
      saveDocumentCallback,
      clearChangesCallback;
  final bool isEditing;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: AppText(
          'You have unsaved changes!\nGoing back will delete all changes you have made.',
          size: 16.dw),
      actions: [
        AppTextButton(
            text: 'Save',
            height: 40.dh,
            onPressed: () {
              pop();
              isEditing ? editDocumentCallback() : saveDocumentCallback();
            },
            margin: EdgeInsets.only(bottom: 10.dh),
            backgroundColor: AppColors.primary,
            textColor: AppColors.onPrimary),
        AppTextButton(
            text: 'Discard Changes',
            onPressed: () {
              pop();
              clearChangesCallback();
            },
            height: 40.dh,
            backgroundColor: AppColors.disabled,
            textColor: AppColors.onBackground)
      ],
    );
  }
}
