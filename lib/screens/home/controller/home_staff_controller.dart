import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dio/dio.dart' as diomultipart;
import 'package:service/routes/app_pages.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../utils/loadings/snackbar.dart';
import '../../../utils/widget/dialogs.dart';
import '../../service berkala/model/mtc_model.dart';

class HomeStaffController extends GetxController {
  final localStorage = GetStorage();
  RxString username = ''.obs;
  String canAdd = '';
  String canEdit = '';
  String canDelete = '';
  RxString typeUser = ''.obs;
  RxBool isLoading = false.obs;
  RxList<MtcModel> mtcModel = <MtcModel>[].obs;

  final diomultipart.Dio _dio = diomultipart.Dio(
    diomultipart.BaseOptions(
      baseUrl: 'http://10.3.80.4:8080',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  @override
  void onInit() {
    super.onInit();
    getData();
    username.value = localStorage.read('username') ?? '';
    canAdd = localStorage.read('add') ?? '';
    canEdit = localStorage.read('edit') ?? '';
    canDelete = localStorage.read('delete') ?? '';
    typeUser.value = localStorage.read('type_user') ?? '';
  }

  getData() async {
    isLoading.value = true;

    try {
      final response = await _dio.get('/service-staff');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        mtcModel.value = data.map((e) => MtcModel.fromJson(e)).toList();
        print('ini response user : ${mtcModel.toList()}');
      }
    } on diomultipart.DioException catch (e) {
      SnackbarLoader.warningSnackBar(
        title: 'Error',
        message: e.response?.data['message'] ?? 'Terjadi kesalahan',
      );

      print(
          'Error getAllUser: ${e.response?.data['message'] ?? 'Terjadi kesalahan'}');
    } finally {
      isLoading.value = false;
    }
  }

  Future<Uint8List> generatePDF(MtcModel selectedData,
      {bool withHeader = true}) async {
    print('Starting PDF generation...');
    CustomDialogs.loadingIndicator();

    final pdf = pw.Document();

    // Load fonts
    final regularFont =
        await rootBundle.load("assets/fonts/Urbanist-Regular.ttf");
    final ttfRegular = pw.Font.ttf(regularFont);
    final boldFont = await rootBundle.load("assets/fonts/Urbanist-Bold.ttf");
    final ttfBold = pw.Font.ttf(boldFont);

    // Load image from assets
    final ByteData imageData = await rootBundle.load('assets/images/lps.png');
    final Uint8List imageBytes = imageData.buffer.asUint8List();
    final image = pw.MemoryImage(imageBytes);

    // Column headers

    if (withHeader) {
      pdf.addPage(pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Image(image, width: 60, height: 60),
                      pw.SizedBox(width: 10),
                      pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.center,
                          children: [
                            pw.Text('Langgeng Pranamas Sentosa',
                                style:
                                    pw.TextStyle(fontSize: 24, font: ttfBold)),
                            pw.SizedBox(width: 16),
                            pw.Text(
                                'Jl. Komp. Babek TN Jl. Rorotan No.3 Blok C, RT.1/RW.10, Rorotan,\nKec. Cakung, Jkt Utara, Daerah Khusus Ibukota Jakarta 14140',
                                textAlign: pw.TextAlign.center,
                                style: pw.TextStyle(
                                    fontSize: 14, font: ttfRegular))
                          ])
                    ]),
                pw.Divider(),
                pw.SizedBox(height: 15),
                pw.Text('CEKLIST SERVICE BERKALA',
                    textAlign: pw.TextAlign.left,
                    style: pw.TextStyle(fontSize: 18, font: ttfBold)),
                pw.SizedBox(height: 10),
                // disini tempat tablenya
                pw.Table(
                  border: pw.TableBorder.all(),
                  columnWidths: {
                    0: const pw.FixedColumnWidth(30),
                    1: const pw.FlexColumnWidth(1),
                    2: const pw.FlexColumnWidth(2),
                  },
                  children: [
                    pw.TableRow(children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text('1',
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(font: ttfRegular)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text('MEKANIK',
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(font: ttfRegular)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text(selectedData.mekanik,
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(font: ttfRegular)),
                      ),
                    ]),
                    pw.TableRow(children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text('2',
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(font: ttfRegular)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text('KEP.POOL',
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(font: ttfRegular)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text(selectedData.kpool,
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(font: ttfRegular)),
                      ),
                    ]),
                  ],
                ),
              ],
            ),
          );
        },
      ));
    } else {
      pdf.addPage(pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('CEKLIST SERVICE BERKALA',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(fontSize: 18, font: ttfBold)),
              pw.SizedBox(height: 10),
              // disini tempat tablenya
              pw.Table(
                border: pw.TableBorder.all(),
                columnWidths: {
                  0: const pw.FixedColumnWidth(30),
                  1: const pw.FlexColumnWidth(1),
                  2: const pw.FlexColumnWidth(2),
                },
                children: [
                  pw.TableRow(children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text('1',
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(font: ttfRegular)),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text('MEKANIK',
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(font: ttfRegular)),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text(selectedData.mekanik,
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(font: ttfRegular)),
                    ),
                  ]),
                  pw.TableRow(children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text('2',
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(font: ttfRegular)),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text('KEP.POOL',
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(font: ttfRegular)),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text(selectedData.kpool,
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(font: ttfRegular)),
                    ),
                  ]),
                ],
              ),
            ],
          );
        },
      ));
    }

    Navigator.of(Get.overlayContext!).pop();

    return pdf.save(); // Return PDF as bytes for preview
  }

  logout() {
    localStorage.remove('username');
    localStorage.remove('add');
    localStorage.remove('edit');
    localStorage.remove('delete');
    localStorage.remove('type_user');
    localStorage.write('isLoggedIn', false);
    Get.offAllNamed(Routes.LOGIN);
  }
}
