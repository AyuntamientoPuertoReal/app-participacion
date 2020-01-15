import 'package:flutter/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

Widget createIframe(BuildContext context, String latitud, String longitud){
 // double width=MediaQuery.of(context).size.width;

 return Container(
    height: 305,
    padding: EdgeInsets.all(5),
    child: WebView(
      initialUrl: Uri.dataFromString('<html><body><iframe width="100%" height="100%" id="gmap_canvas" src="https://maps.google.com/maps?q=$latitud,$longitud&t=&z=17&ie=UTF8&iwloc=&output=embed" frameborder="0" scrolling="no" marginheight="0" marginwidth="0"></iframe></body></html>', mimeType: 'text/html').toString(),
      javascriptMode: JavascriptMode.unrestricted,
    ),
  );
}