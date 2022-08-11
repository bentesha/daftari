import '../source.dart';

/// Makes sure all relevant data is loaded before showing widgets that uses that data.
class InitFutureBuilder<T> extends StatefulWidget {
  final Widget Function(BuildContext, T) builder;
  final Future<T> Function() callback;
  const InitFutureBuilder(
      {required this.builder, required this.callback, Key? key})
      : super(key: key);

  @override
  State<InitFutureBuilder<T>> createState() => _InitFutureBuilderState();
}

class _InitFutureBuilderState<T> extends State<InitFutureBuilder<T>> {
  Future<T>? initiateData;

  @override
  void initState() {
    super.initState();
    // the widget callback in most cases will be calling a method from a state notifier
    // which will be emitting state during its execution.
    // So the delaying of initializing initialData property is so that to avoid errors
    // like - "setState is called during build"
    /* Future.microtask(() {
      log("started the function");
      initiateData = widget.callback();
      setState(() {});
    }); */
    WidgetsBinding.instance.addPostFrameCallback((_) {
      log("started the function");
      initiateData = widget.callback();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
        future: initiateData,
        builder: (_, snapshot) {
          final isLoading =
              snapshot.connectionState == ConnectionState.waiting ||
                  initiateData == null;
          return isLoading || snapshot.hasError
              ? Center(
                  child: isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : buildErrorWidget())
              : widget.builder(context, snapshot.data!);
        });
  }

  Widget buildErrorWidget() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("An error happened while trying to load data.",
                textAlign: TextAlign.center),
            const SizedBox(height: 20),
            AppTextButton(
                onPressed: () {
                  initiateData = widget.callback();
                  setState(() {});
                },
                text: "Try Again")
          ],
        ),
      ),
    );
  }
}
