import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';

class PDFPreviewScreen extends StatelessWidget {
  final String path;

  PDFPreviewScreen(this.path);
  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(path: path);
  }
}
