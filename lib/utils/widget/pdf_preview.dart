import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:open_file/open_file.dart';

import '../../constant/custom_size.dart';
import '../theme/app_colors.dart';

class PdfPreviewScreen extends StatefulWidget {
  final Uint8List pdfBytesWithHeader;
  final Uint8List pdfBytesWithoutHeader;
  final String fileName;

  const PdfPreviewScreen({
    super.key,
    required this.pdfBytesWithHeader,
    required this.pdfBytesWithoutHeader,
    required this.fileName,
  });

  @override
  State<PdfPreviewScreen> createState() => _PdfPreviewScreenState();
}

class _PdfPreviewScreenState extends State<PdfPreviewScreen>
    with SingleTickerProviderStateMixin {
  bool isWithHeaderSelected = true; // Default pilihan pertama

  late AnimationController _animationController;
  late Animation<double> animation;
  bool _isExpanded = false;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Preview'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () => _downloadPDF(isWithHeader: isWithHeaderSelected),
          )
        ],
      ),
      body: Column(
        children: [
          // Tampilkan PDF berdasarkan pilihan
          Expanded(
            child: SfPdfViewer.memory(
              isWithHeaderSelected
                  ? widget.pdfBytesWithHeader
                  : widget.pdfBytesWithoutHeader,
              canShowPaginationDialog: false,
              enableDoubleTapZooming: false,
            ),
          ),
          const SizedBox(height: 10),
          // Tombol pilihan PDF
          Container(
              padding: _isExpanded
                  ? const EdgeInsets.symmetric(horizontal: 16.0)
                  : EdgeInsets.zero,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        InkWell(
                          onTap: toggleExpansion,
                          child: Icon(
                            _isExpanded ? Icons.expand_more : Icons.expand_less,
                            color: AppColors.black,
                          ),
                        ),
                        if (!_isExpanded)
                          Text('Pilih Format',
                              style: Theme.of(context).textTheme.labelMedium)
                      ],
                    ),
                  ),
                  const SizedBox(height: CustomSize.sm),
                  SizeTransition(
                    sizeFactor: animation,
                    child: Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Tombol untuk PDF dengan kop surat
                          _buildOptionButton(
                            title: "Dengan Kop Surat",
                            isSelected: isWithHeaderSelected,
                            pdfBytes: widget.pdfBytesWithHeader,
                            onTap: () {
                              setState(() {
                                isWithHeaderSelected = true;
                              });
                            },
                          ),
                          // Tombol untuk PDF tanpa kop surat
                          _buildOptionButton(
                            title: "Tanpa Kop Surat",
                            isSelected: !isWithHeaderSelected,
                            pdfBytes: widget.pdfBytesWithoutHeader,
                            onTap: () {
                              setState(() {
                                isWithHeaderSelected = false;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildOptionButton({
    required String title,
    required bool isSelected,
    required Uint8List pdfBytes,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 150,
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(
                color: isSelected ? Colors.blue : Colors.transparent,
                width: 3,
              ),
            ),
            child: SfPdfViewer.memory(
              pdfBytes,
              canShowPaginationDialog: false,
              canShowScrollHead: false,
              enableDoubleTapZooming: false,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.blue : Colors.black,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _downloadPDF({required bool isWithHeader}) async {
    try {
      // Tentukan lokasi folder
      Directory downloadDir =
          Directory('/storage/emulated/0/Download/LaporanPDF');
      if (!await downloadDir.exists()) {
        await downloadDir.create(recursive: true); // Buat folder jika belum ada
      }

      // Pilih file name berdasarkan opsi yang dipilih
      final fileName = isWithHeader
          ? widget.fileName // Nama file default untuk Dengan Kop Surat
          : widget.fileName
              .replaceFirst('.pdf', '_no_kop.pdf'); // Tambahkan _no_kop

      // Simpan PDF ke dalam folder
      final file = File('${downloadDir.path}/$fileName');
      await file.writeAsBytes(
        isWithHeader ? widget.pdfBytesWithHeader : widget.pdfBytesWithoutHeader,
      );

      // Tampilkan notifikasi keberhasilan
      if (mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              content: const Text(
                "File berhasil diunduh. Periksa folder 'LaporanPDF' di folder 'Download'.",
                textAlign: TextAlign.center,
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                      child: const Text("Tutup"),
                    ),
                    TextButton(
                      onPressed: () {
                        // Ganti dengan lokasi file PDF yang sudah diunduh
                        OpenFile.open('${downloadDir.path}/$fileName');
                      },
                      child: const Text("Buka File"),
                    ),
                  ],
                )
              ],
            );
          },
        );
      }
    } catch (e) {
      print('Error saving PDF: $e');
    }
  }
}
