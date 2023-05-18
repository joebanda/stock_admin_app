import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:meta/meta.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../core/model/StoreBranch.dart';
import '../../../core/model/stocktake_count.dart';
Future<Uint8List> generatePdfExpiryReport(PdfPageFormat pageFormat,
    {
      @required String location,
      @required List<StocktakeCount> salesLinesList,
      // @required List<StoreBranch> storeBranchList,
      //Map<StocktakeCount,StoreBranch> countToBranchMap,
      String reportNumber,
      bool isDraft = true,
    }) async {

  List<CountDetail> countDetails = [];
  salesLinesList.forEach((salesLine) {
    //print('Adding ${salesLine.description}: exp: ${salesLine.date_expiry}, qty ${salesLine.qty}, location: $location');
    countDetails.add(CountDetail(
      description: salesLine.description,
      quantity: salesLine.qty,
      expiryDate: salesLine.date_expiry.toString(),
      //location: location != null && location!='' ? location : countToBranchMap[salesLine]?.storeBranchName ==null?'':countToBranchMap[salesLine].storeBranchName,
    ));
  });

  final expiryReport = ExpiryReport(
    reportNumber: reportNumber == null ? '' : reportNumber,
    countDetails: countDetails,
    customerName: location,
    customerAddress: '',
    paymentInfo: '',
    // baseColor: PdfColors.teal,
    baseColor: PdfColors.black,
    // accentColor: PdfColors.blueGrey900,
    accentColor: PdfColors.black,
  );

  return await expiryReport.buildPdf(pageFormat,isDraft: isDraft);
}

class ExpiryReport {
  ExpiryReport({this.countDetails, this.customerName, this.customerAddress, this.reportNumber,
    this.paymentInfo, this.baseColor, this.accentColor,});
  final List<CountDetail> countDetails;
  final String customerName;
  final String customerAddress;
  final String reportNumber;
  // final double tax;
  final String paymentInfo;
  final PdfColor baseColor;
  final PdfColor accentColor;

  static const _darkColor = PdfColors.black;
  static const _lightColor = PdfColors.white;

  PdfColor get _baseTextColor =>
      baseColor.luminance < 0.5 ? _lightColor : _darkColor;

  PdfColor get _accentTextColor =>
      baseColor.luminance < 0.5 ? _lightColor : _darkColor;

  // double get _total => countDetails.map<double>((p) => p.amount).reduce((a, b) => a + b);
  // double get _taxValue => _total * tax;
  // double get _grandTotal => _total * (1 + tax);
  int _qtyTotal =0;
  int get qtyTotal =>  countDetails.map<int>((p) =>int.parse(p.quantity)).reduce((a, b) => a + b);
  // PdfImage _logo;


  Future<Uint8List> buildPdf(PdfPageFormat pageFormat,{ bool isDraft}) async {
    // Create a PDF document.
    final doc = pw.Document();

    final font1 = await rootBundle.load('lib/assets/fonts/Roboto-Regular.ttf');
    final font2 = await rootBundle.load('lib/assets/fonts/Roboto-Medium.ttf');
    final font3 = await rootBundle.load('lib/assets/fonts/Roboto-Bold.ttf');


    // _logo = PdfImage.file(
    //   doc.document,
    //   bytes: (await rootBundle.load('lib/assets/icons/logo.jpg')).buffer.asUint8List(),
    // );

    // Add page to the PDF
    doc.addPage(
      pw.MultiPage(
        pageTheme: _buildTheme(
          pageFormat,
          font1 != null ? pw.Font.ttf(font1) : null,
          font2 != null ? pw.Font.ttf(font2) : null,
          font3 != null ? pw.Font.ttf(font3) : null,
        ),
        header: (context)=>_buildHeader(context,isDraft: isDraft),
        footer: _buildFooter,
        build: (context) => [
          _contentHeader(context),
          _contentTable(context),
          pw.SizedBox(height: 20),
          _contentFooter(context),
          // pw.SizedBox(height: 20),
          // _termsAndConditions(context),
        ],
      ),
    );

    // Return the PDF file content
    return doc.save();
  }

  pw.Widget _buildHeader(pw.Context context,{bool isDraft}) {
    return pw.Column(
      children: [
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Expanded(
              child: pw.Column(
                children: [
                  pw.Container(
                    height: 50,
                    padding: pw.EdgeInsets.only(left: 20),
                    alignment: pw.Alignment.centerLeft,
                    child: pw.Text(
                      // isDraft ? 'Draft Invoice' :  'Tax Invoice',
                      isDraft ? 'Draft Report' :  'REPORT',
                      style: pw.TextStyle(
                        color: baseColor,
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 34,
                      ),
                    ),
                  ),
                  pw.Container(
                    decoration: pw.BoxDecoration(
                      // borderRadius: 5,
                      color: PdfColors.white,
                    ),
                    padding: pw.EdgeInsets.only(
                        left: 40, top: 10, bottom: 10, right: 20),
                    alignment: pw.Alignment.centerLeft,
                    height: 50,
                    child: pw.DefaultTextStyle(
                      style: pw.TextStyle(
                        color: _darkColor,
                        fontSize: 14,
                      ),
                      child: pw.GridView(
                        crossAxisCount: 2,
                        children: [
                          // pw.Text('Invoice #'),
                          // pw.Text(invoiceNumber),
                          pw.Text('Date: '),
                          pw.Text(_formatDate(DateTime.now())),
                          //pw.Text('Invoice Date:'),
                          // pw.Text(_formatDate(invoiceDate)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            pw.Expanded(
              child: pw.Column(
                mainAxisSize: pw.MainAxisSize.min,
                children: [
                  pw.Container(
                      alignment: pw.Alignment.topRight,
                      padding: const pw.EdgeInsets.only(bottom: 8, left: 30),
                      height: 72,
                      child:pw.Container()
                    // _logo != null ? pw.Image(_logo) :
                    // pw.PdfLogo(),
                  ),
                  // pw.Container(
                  //   color: baseColor,
                  //   padding: pw.EdgeInsets.only(top: 3),
                  // ),
                ],
              ),
            ),
          ],
        ),
        if (context.pageNumber > 1) pw.SizedBox(height: 20)
      ],
    );
  }

  pw.Widget _buildFooter(pw.Context context) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        pw.Container(
          height: 20,
          // width: 100,
          child: pw.Text('@LogistixPro',style:pw.TextStyle(fontSize: 8)),
          // pw.BarcodeWidget(
          //   barcode: pw.Barcode.pdf417(),
          //   data: 'Invoice# $invoiceNumber',
          // ),
        ),
        pw.Text(
          'Page ${context.pageNumber}/${context.pagesCount}',
          style: const pw.TextStyle(
            fontSize: 14,
            color: PdfColors.grey,
          ),
        ),
      ],
    );
  }

  pw.PageTheme _buildTheme(PdfPageFormat pageFormat, pw.Font base, pw.Font bold, pw.Font italic) {
    return pw.PageTheme(
      pageFormat: pageFormat,
      theme: pw.ThemeData.withFont(
        base: base,
        bold: bold,
        italic: italic,
      ),
      buildBackground: (context) => pw.FullPage(
        ignoreMargins: true,
        child: pw.Stack(
          children: [
            pw.Positioned(
              bottom: 0,
              left: 0,
              child: pw.Container(
                height: 20,
                width: pageFormat.width / 2,
                decoration: pw.BoxDecoration(
                  gradient: pw.LinearGradient(
                    colors: [baseColor, PdfColors.white],
                  ),
                ),
              ),
            ),
            pw.Positioned(
              bottom: 20,
              left: 0,
              child: pw.Container(
                height: 20,
                width: pageFormat.width / 4,
                decoration: pw.BoxDecoration(
                  gradient: pw.LinearGradient(
                    colors: [accentColor, PdfColors.white],
                  ),
                ),
              ),
            ),
            pw.Positioned(
              top: pageFormat.marginTop + 72,
              left: 0,
              right: 0,
              child: pw.Container(
                height: 3,
                color: baseColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  pw.Widget _contentHeader(pw.Context context) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          child: pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Container(
                margin: pw.EdgeInsets.only(left: 10, right: 10,top: 10,bottom: 10),
                height: 116,
                child: pw.Text(
                  'To:',
                  style: pw.TextStyle(
                    color: _darkColor,
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              pw.Expanded(
                child: pw.Container(
                  height: 116,
                  margin: pw.EdgeInsets.only(left: 10, right: 10,top: 10,bottom: 10),
                  child: pw.RichText(
                      text: pw.TextSpan(
                          text: '$customerName\n',
                          style: pw.TextStyle(
                            color: _darkColor,
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 18,
                          ),
                          children: [
                            pw.TextSpan(
                              text: '\n',
                              style: pw.TextStyle(
                                fontSize: 5,
                              ),
                            ),
                            pw.TextSpan(
                              text: customerAddress,
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.normal,
                                fontSize: 18,
                              ),
                            ),
                          ])),
                ),
              ),
            ],
          ),
        ),
        pw.Expanded(
          child: pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              /*    pw.Container(
                margin: pw.EdgeInsets.only(left: 10, right: 10,top: 10,bottom: 10),
                height: 110,
                child: pw.Text(
                  'From:',
                  style: pw.TextStyle(
                    color: _darkColor,
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),*/
              /*         pw.Expanded(
                child: pw.Container(
                  margin: pw.EdgeInsets.only(left: 10, right: 10,top: 10,bottom: 10),
                  height: 110,

                  child: pw.RichText(
                      text: pw.TextSpan(
                          text: 'L&A LOGISTICS\nTPIN# 1004117420\nPLOT 92070 KAFUE RD\nLUSAKA\nTEL: 211238 04/1/2\nsales@la-zambia.com',
                          style: pw.TextStyle(
                            color: _darkColor,
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 18,
                          ),
                          children: [
                            pw.TextSpan(
                              text: '',
                              style: pw.TextStyle(
                                fontSize: 5,
                              ),
                            ),
                            pw.TextSpan(
                              text:'',
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.normal,
                                fontSize: 10,
                              ),
                            ),
                          ])),
                ),
              ),*/
            ],
          ),
        ),
      ],
    );
  }

  pw.Widget _contentFooter(pw.Context context) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          flex: 2,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // pw.Text(
              //   'Thank you for your business',
              //   style: pw.TextStyle(
              //     color: _darkColor,
              //     fontWeight: pw.FontWeight.bold,
              //   ),
              // ),
              // pw.Container(
              //   margin: const pw.EdgeInsets.only(top: 20, bottom: 8),
              //   child: pw.Text(
              //     'Payment Type:',
              //     style: pw.TextStyle(
              //       color: baseColor,
              //       fontWeight: pw.FontWeight.bold,
              //     ),
              //   ),
              // ),

              // pw.Text(
              //   paymentInfo,
              //   style: const pw.TextStyle(
              //     fontSize: 16,
              //     lineSpacing: 5,
              //     color: _darkColor,
              //   ),
              // ),

            ],
          ),
        ),
        pw.Expanded(
          flex: 1,
          child: pw.DefaultTextStyle(
            style: const pw.TextStyle(
              fontSize: 18,
              color: _darkColor,
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    // pw.Text('Sub Total:'),
                    // pw.Text(_formatCurrency(_total.toString())),
                  ],
                ),
                pw.SizedBox(height: 5),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    // pw.Text(tax<1? 'VAT ${(tax * 100).toStringAsFixed(0)}:' : 'VAT ${tax.toStringAsFixed(0)}:'),
                    // pw.Text(tax<1 ? '${(tax * 100).toStringAsFixed(1)}%' : '${tax.toStringAsFixed(1)}%'),
                    // pw.Text(_taxValue.toStringAsFixed(2)),
                  ],
                ),
                pw.Divider(color: accentColor),
                pw.DefaultTextStyle(
                  style: pw.TextStyle(
                    color: baseColor,
                    fontSize: 20,
                    // fontWeight: pw.FontWeight.bold,
                  ),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('Total:'),
                      pw.Text('$qtyTotal'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  pw.Widget _termsAndConditions(pw.Context context) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Container(
                decoration: pw.BoxDecoration(
                  /*  border: pw.BoxBorder(
                    top: true,
                    color: accentColor,
                  ),*/
                ),
                padding: const pw.EdgeInsets.only(top: 10, bottom: 4),
                child: pw.Text(
                  'Terms & Conditions',
                  style: pw.TextStyle(
                    fontSize: 18,
                    color: baseColor,
                    // fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.Text(
                pw.LoremText().paragraph(40),
                textAlign: pw.TextAlign.justify,
                style: const pw.TextStyle(
                  fontSize: 14,
                  lineSpacing: 2,
                  color: _darkColor,
                ),
              ),
            ],
          ),
        ),
        pw.Expanded(
          child: pw.SizedBox(),
        ),
      ],
    );
  }

  pw.Widget _contentTable(pw.Context context) {
    const tableHeaders = [
      'DESCRIPTION',
      'EXPIRY DATE',
      //'LOCATION',
      'QTY',
    ];

    //TODO: CHANGE SPACE DESCRIPTION TAKES UP
    return pw.Table.fromTextArray(
        border: null,
        cellAlignment: pw.Alignment.centerLeft,
        cellPadding: pw.EdgeInsets.symmetric(horizontal: 0),
        headerDecoration: pw.BoxDecoration(
          color: PdfColors.white,
          /*  border: pw.BoxBorder(
          bottom: true,
          color: accentColor,
          width: .5,
        ),*/
        ),
        headerHeight: 25,
        cellHeight: 40,
        cellAlignments: {
          0: pw.Alignment.centerLeft,
          1: pw.Alignment.centerLeft,
          //2: pw.Alignment.centerLeft,
          2: pw.Alignment.center,
          3: pw.Alignment.center,
          4: pw.Alignment.centerRight
        },
        headerStyle: pw.TextStyle(
          // color: _baseTextColor,
          color: _darkColor,
          fontSize: 15,
          // fontWeight: pw.FontWeight.bold,
        ),
        cellStyle: pw.TextStyle(
          color: _darkColor,
          fontSize: 16,

          // letterSpacing: 0.05
        ),
        // rowDecoration: pw.BoxDecoration(
        //   border: pw.BoxBorder(
        //     bottom: true,
        //     color: accentColor,
        //     width: .5,
        //   ),
        // ),
        headers: List<String>.generate(
          tableHeaders.length,
              (col) => tableHeaders[col],
        ),
        data: List<List<String>>.generate(
          countDetails.length,
              (row) => List<String>.generate(
            tableHeaders.length,
                (col) => countDetails[row].getIndex(col),
          ),
        ),
        columnWidths: {
          0:pw.FlexColumnWidth(3),
          1:pw.FlexColumnWidth(3),
          //2:pw.FlexColumnWidth(2),
          2:pw.FlexColumnWidth(1),
          3:pw.FlexColumnWidth(2),
          4:pw.FlexColumnWidth(2)
        }
    );
  }
}

// String _formatCurrency(double amount) {
//   return '${amount.toStringAsFixed(2)}';
// }

String _formatDate(DateTime date) {
  final format = DateFormat.yMMMd('en_US');
  return format.format(date);
}
NumberFormat _currencyFormat = NumberFormat("#,##0.00", "en_US");
String _formatCurrency(String amount){
  var amountToStringAsFixed = double.parse(amount).toStringAsFixed(2);
  return _currencyFormat.format(double.parse(amountToStringAsFixed));
}

class CountDetail {
  const CountDetail({
    this.expiryDate,
    this.description,
    this.quantity,
    // this.location
  });

  final String description;
  final String quantity;
  final String expiryDate;
  //final String location;
  // double get total => amount;

  String getIndex(int index) {
    switch (index) {
      case 0:
        return description;
      case 1:
        return expiryDate;
    //case 2:
    // return location;
      case 2:
        return quantity;
    }
    return '';
  }
}
