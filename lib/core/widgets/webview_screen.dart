import 'package:webview_flutter/webview_flutter.dart';
import '../../views/payment/controller/payment_controller.dart';
import '../utils/basic_import.dart';
import 'confirmation_widget.dart';
import 'loading_widget.dart';

class WebPaymentScreen extends StatefulWidget {
  const WebPaymentScreen({super.key});

  @override
  State<WebPaymentScreen> createState() => _WebPaymentScreenState();
}
class _WebPaymentScreenState extends State<WebPaymentScreen> {
  final controller = Get.find<PaymentController>();
  late final WebViewController _webViewController;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  void _initializeWebView() {

    final paymentUrl = controller.paymentUrl;

    if (paymentUrl.isEmpty) {
      _handleFailure("Payment URL not found");
      return;
    }

    debugPrint("🔗 Loading Payment URL: $paymentUrl");

    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() => isLoading = true);
          },
          onPageFinished: (String url) {
            setState(() => isLoading = false);
            debugPrint("✅ Current URL: $url");

            // ✅ Success check
            if (url.contains('success')) {
              _handleSuccess();
            }
            // ✅ Cancel/Failed check
            else if (url.contains('cancel') || url.contains('failed')) {
              _handleFailure("Payment failed or was cancelled");
            }
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint("❌ WebView Error: ${error.description}");
            _handleFailure("Failed to load payment page");
          },
        ),
      )
      ..loadRequest(Uri.parse(paymentUrl));

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'Payment',
        isBack: true,
      ),
      body: isLoading
          ? const LoadingWidget()
          : WebViewWidget(controller: _webViewController),
    );
  }

  void _handleSuccess() {
    debugPrint("✅ Payment Successful");

    controller.paymentUrl = '';

    Get.offAll(
      ConfirmationWidget(
        iconPath: Assets.icons.vector,
        title: "payment successful",
        subtitle:
        'About this payment information has been sent your email\n Waiting for doctor Confirmation',
      ),
    );
  }

  void _handleFailure(String message) {
    debugPrint("❌ Payment Failed: $message");

    controller.paymentUrl = '';

    Get.back();
    CustomSnackBar.error(message);
  }
}
