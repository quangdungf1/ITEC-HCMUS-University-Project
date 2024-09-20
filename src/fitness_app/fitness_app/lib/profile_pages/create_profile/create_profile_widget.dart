import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/upload_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'create_profile_model.dart';
export 'create_profile_model.dart';

class CreateProfileWidget extends StatefulWidget {
  const CreateProfileWidget({super.key});

  @override
  State<CreateProfileWidget> createState() => _CreateProfileWidgetState();
}

class _CreateProfileWidgetState extends State<CreateProfileWidget> {
  late CreateProfileModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CreateProfileModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await showDialog(
        context: context,
        builder: (alertDialogContext) {
          return AlertDialog(
            title: Text('Welcome to our Fitness App!'),
            content: Text(
                'Please fill in all of the informations for the better service.  Thank you!'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(alertDialogContext),
                child: Text('Ok'),
              ),
            ],
          );
        },
      );
    });

    _model.yourNameTextController ??= TextEditingController(
        text: valueOrDefault(currentUserDocument?.fullName, ''));
    _model.yourNameFocusNode ??= FocusNode();

    _model.ageTextController ??= TextEditingController(
        text: valueOrDefault<String>(
      valueOrDefault(currentUserDocument?.age, 0).toString(),
      '18',
    ));
    _model.ageFocusNode ??= FocusNode();

    _model.emailTextController ??= TextEditingController();
    _model.emailFocusNode ??= FocusNode();

    _model.phoneNumberTextController ??=
        TextEditingController(text: currentPhoneNumber);
    _model.phoneNumberFocusNode ??= FocusNode();

    _model.weightTextController ??= TextEditingController(
        text: valueOrDefault(currentUserDocument?.weight, 0).toString());
    _model.weightFocusNode ??= FocusNode();

    _model.wishweightTextController ??= TextEditingController(
        text: valueOrDefault(currentUserDocument?.wishWeight, 0).toString());
    _model.wishweightFocusNode ??= FocusNode();

    _model.timesToAchieveTextController ??= TextEditingController(
        text:
            valueOrDefault(currentUserDocument?.timesToAchieve, 0).toString());
    _model.timesToAchieveFocusNode ??= FocusNode();

    _model.cityTextController ??= TextEditingController(
        text: valueOrDefault(currentUserDocument?.city, ''));
    _model.cityFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFF090909),
      appBar: AppBar(
        backgroundColor: Color(0xFF030303),
        automaticallyImplyLeading: false,
        actions: [],
        centerTitle: false,
        elevation: 0.0,
      ),
      body: SafeArea(
        top: true,
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: 100.0,
                        height: 100.0,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            final selectedMedia =
                                await selectMediaWithSourceBottomSheet(
                              context: context,
                              maxWidth: 50.00,
                              maxHeight: 50.00,
                              imageQuality: 100,
                              allowPhoto: true,
                              pickerFontFamily: 'Lexend Deca',
                            );
                            if (selectedMedia != null &&
                                selectedMedia.every((m) => validateFileFormat(
                                    m.storagePath, context))) {
                              setState(() => _model.isDataUploading1 = true);
                              var selectedUploadedFiles = <FFUploadedFile>[];

                              var downloadUrls = <String>[];
                              try {
                                selectedUploadedFiles = selectedMedia
                                    .map((m) => FFUploadedFile(
                                          name: m.storagePath.split('/').last,
                                          bytes: m.bytes,
                                          height: m.dimensions?.height,
                                          width: m.dimensions?.width,
                                          blurHash: m.blurHash,
                                        ))
                                    .toList();

                                downloadUrls = (await Future.wait(
                                  selectedMedia.map(
                                    (m) async => await uploadData(
                                        m.storagePath, m.bytes),
                                  ),
                                ))
                                    .where((u) => u != null)
                                    .map((u) => u!)
                                    .toList();
                              } finally {
                                _model.isDataUploading1 = false;
                              }
                              if (selectedUploadedFiles.length ==
                                      selectedMedia.length &&
                                  downloadUrls.length == selectedMedia.length) {
                                setState(() {
                                  _model.uploadedLocalFile1 =
                                      selectedUploadedFiles.first;
                                  _model.uploadedFileUrl1 = downloadUrls.first;
                                });
                              } else {
                                setState(() {});
                                return;
                              }
                            }
                          },
                          child: Container(
                            width: 200.0,
                            height: 200.0,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Image.network(
                              valueOrDefault<String>(
                                _model.uploadedFileUrl1,
                                'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAOEAAADhCAMAAAAJbSJIAAABFFBMVEX///8AAAD81a77+/vO8MD+/v78/PxTR0H9/f1SRkD30avK67yAgID/2rL91q/AwMCzs7OKoYHT9cRbW1vKysqEhIT/3bSpj3UVEg4pKSkLCwvxzKbvto84ODiehW0+Pj4hISF5eXnm5uZGPDfW1taoqKhiYmI6MSg4MCzr6+vOro57aFWenp5RUVG4nH+Nd2FvXk1JSUnkwZ5hUkNvb29URzq62a4uJyQZGRmSkpLHqIkjHhiBbVmsyKBNWkgvLy/auJf/9OfapoI5KyK/kXI3QDORqYexzqV8kXQaHhgpIxx+knUjKSGZso6sg2dBODSUcVm5p5R+YEy7j3FicltTYE1BSzxsf2UvNitZRDVwVUPUoX+NufQgAAAdM0lEQVR4nNWde2PauLLAbQMJgdiklJgUCEl4JAESSEjSPLvlbNt9pNvt3t2e9pyz3/97XM1IsmVZ8pvec/VHQxMZ9NNIM6PRSBgbBpaNUpW+KJUq+LNSKtFfVEtylQ1WJUndUJUKr1Jw3Yhm5gE04uoW0+hqnr5N/2SmTylYKinqVvIAGnF1FYDJpV2QBEsJP6WYRv8fDFGs8l+pZPIBbkiA320Ofq8hGqz73RodLusePKyZa56D9D+TwWAwarUarIxiACsKCWZv5nq7cTLauT8+398zg+U+ZaNzzaT1fAr8YrBz/dZUl/1KSgnmsGaJn0wzRI3qZOdaA4dlO6uSif3ocDMzdE1s3cHZeYCns3f3eHt7e4oFBuxhqZoKMJdHWThgaUfEu7s9HW5tbW16ZQi/bSXQbwWYCYOP+CKH6GDbp3s8HVIqTkhQtzrkD0frAtQ0syhAUqXliW/vdsiltiUAbp7iGN34bwNM9CmG0bjkeCg8BhYARBE24i1UUUOUTsJCACtG64DxUeltqQA3t8jfXxqxb1cooFHEEDWMEZNf53SLzzgFIBIeGfkbnaqZKT5FV7fUuubD01cpKkAkfFtSNzqfoS8EUPMpraNXAflFAG5u3pF6Bzujgj46Ud2cnzLYvePqk/BtxQFufmZm8vysxZ0NTlqoqybUjX4yZg6OXnpuy+2WoDx1gMxcsPL2vuUNpLWYCV43owSrxuDYs+2ft0TlqQckLz53RH/uaFQAYIyqyAhYMcYC3mZiQPJjePooQF42ChyiyrrZZG+UXnqzbzMVIPvP51tvzXgw4i7AOoaoYWQDHFAFcyu1Pgmg/+LzIxuxu6U1Ahq6J6M+xRhRjch9zyyA1Mc5pYz7g6QfncGkZAc83cwLCD+Zcm2tZw7qAaOHKLbp82aOIer/YnOL6p2xkUwzJm4mrxvbNaEnKxuH0KJhMYDw4pQh5pGgvjPinlR8ynHBgNzTaeQAjKybtmt2Chyi/AXGNsxR4VpUAxj95AStRLGAWxTxVam6BkAjrewhEHNXMCB5gQP1On5xnMGkpHxyQCdh0YCbm7fUZhQPaEj/i5P9NY7R4gE3NzGQmrTRqeLTqZ4sQU8XPkSx4FTcWTdgrOzPfBEWDLiF43S/Unj8JuWTB94sDAF6JRvgFgZxIBxecIDKSCV70DN7SsDh6e3hI4TwsbEZALeosjk2NB+dbYiyTeDkXbPDHe4g4Napv0HIF1TpAelMnKSQYPGAqEmHIcBAYIKvOdIDUnXaSA6YUCGlkH21dGmanS0Z8NaUyl1GQHTBd5M0OoUEDXkPIerJjUkHmx8EpIufm/Z0uVzNL/A/e1uZAHGYvi0a0OC/TiB79EkfVRI8mdq24ziWZS+vTFopPSD5CcO98DB/midH1OkWAXFtd+XYFim1Ws1y7L6ptJkJALdwPEyqhQJWAv+Lkz1VpSIgqr8r2+GAluW4C0/dpPMFWH8x37SgIVopSV0T/eQZrgyFFuGwunEEQGC8YlJMK0FK2CgWsGSkkf296NHwBUGnGwQkL05wLmoNo/7FZ+aaFjZEUwL6hFuCiZ7aMqDTPYkyjBEvhjxeU4Ch9+qmeXLXN/jYIlAMM1cGJOPUwoHq77epi3p9MU7Q6DQSNFLIHtf3Q8EX9cZoENDiGhWs/+3nIZTPp7ePWG6J8zpUA5Kf5ImzoiQY3OVOtg6hMvTMOczCha0AJC+c1Y3s6ghlz8tECQIC4X1RdpBXSdE1PiFtERehApAYRvdhGMEIW46hZdgmJSxyiKYCrHiEtO9P2SxUAqJlXC1OglBSjiLOU9GkDHGUFgpYUf9a8yTVpaxFqGemjhYQIZ3ltL+YzWaL9sNqCWW1mrYXV8JiaygOVU+XGoWYCYNb/MRPBiz+JjTQdiIAYaw6jg0uK7qtpDfYL7rLtjdNRe/Ht4cFzUGe12YkfHLsEW7RIO6FGw0YfCFWsd3anM1Twfs59QgLGqIpAY2G2OXQmraTERAtiruaIWJwajeKB0wu+wHtcT+qMrUyA8ILstiCweqttfA9R0Zxc5DucicHrNL1IRtToGi6Vh5A8H5qezRs4CuvSd4Fr1w3RddslA4h1MYmDejDmpMP0LLcJ9P35vE9ix2ivCR8soJxGjZpyMJpz5KXFWkBLXth+t48qOdOvoSF7IC0G2FzdMjGFCF8tpycgBY6sJ8Fl+bcKMhM8LrpumbbG1KYDHvjAVKLx4I1UYBgDUk1rqEsa071s+fS7KaJjcVLMGleG68imnwTwhd0PUhM+Gq+WDwt+g/Lmm1pAKHa8qG/WCz681XXxdBHzZqaNPazxQz+mVEsYDXdky3PIGJ/z2ygcLvtG98NO5k91FwnDOi43fnFs1ft8Wpec0GmK9OPbt2aXhCjwENyqdYhI88gIuGTTRrfncmrhr2LlS0D2tOrjlSts+gSL24pGERmLDIC6qSdpmuqA98gAuHCIRJ8lAFNNJSSBFeqWmSUM0JaYCQEPOW8Q5Ra/BRPVgWDCIR9p+Y4bGy2p2TZ8LBgklpJc9Ce07F50X+YktKm4/WEEHYf6TYAU16XlaAE8wMacU8GP2Xf27igbik1aLNVzaWLB8fuPlwQJStrUQxOzaZEv1i4vHBrU1KtTQghMLfnr52ujdxDNBegATmXn2/5jJpDCMPudh2H+zaoMa2lyl1dWjasn/y1Y7eLj/NIQOeWbczkdNVSAsqyFw79wFgM6MxoQ097Ibh2hJ9OMJ4zLnYOGrq8Nu2T40BzlnKj9YDaKvZV4C1baYJ/SQBLkU+Gu/GMtuPk6uqZEeYErNlgbG6urlhEp5Em+JdQ2mm6hiaWth3bcS8oodBoG7RNLKBNqolV0PVekTes4Y4Os4dFDdG0gFVMxehCcAa2X/a6jtD61WL29ODEAs6fZouVsFllt0FlERfecZcwLo6LBkwUnORaCaIYj12g6PbekaVFV2j9P+CP5k3MmtimuZsLf01iP5D//96DlaaNbsFA1focgGmCk5ioMAdftNYDwhMRkI3gEzsaEGOuxFewPX8cCP/o9aAKjtj7fCv6xGlfynUIiBCd7V6v98gWT9h6a9UasdN5bTsC8H8GDaYzPbfOmVLCHoz4Gnl9UOgQTQVYgaS2Kxca0uv9SN1KrmSePHV/4+q1qOtbhba3xoKh+SchBAtpE416Z3wPQHU3gt/9BFqGEV64vPXuhdf0E1dvJgTCvsP/Aq73v4EQhEz0V6cQT0aT1xbzJITaLshygsuQbx2Sls0EwoiQhUBoe38hPuAJJxyCDIuUIFZJ/iRp2TO2rNf72/R21ixv6UDUxLjviIBBt85hon47Plp59sIla6ZHmIdQm/xxv1jASqon4ag2bGo73d5fTA5MIVrUuzwzDBHQsS3R2a5ZbJU4MP7hG0QXrGCPmguwjdtrB4xQZeCVYuZFrfs7Nxys9WitzR3DDgD2905WYtiGyXoiAFoudE4P9iExPIzZJoVmRaXoGlwAmzOHiAl7+0FwaUj/Dx9PAkPUwUF54fiAsNR6en4crsQwqwuuN0qwdoPGolgJhvLaot10PGtxsyIrWAhzTkXxkN+5bmAOYi+YT7YAiMtH2w3EkdHSLF3XfkDne1Q0oCH9L+bJI2rznvo3SCjpyqAWtWHgXnUdXRX2wgFH5qn/5M3k7wWo+RTxUpapEwXodNF2xAHWnL7wlvcFz0FDt8sd0TXjjkyoWU1geO3JjQOs2T7hYaNwCWp2uSNdhMnZZYBQt1xywMl8rNkxgHSBCOV8XFoDYMnIIvvJYARLhAdN69nsdCDG9LxSLhmFuqhLG63BJNFHp2mmDJhu9rYCFl/pbOOWhHlhRwNaLqhQI2Wjs0gw3ZMY/b5wo1f0aC5mTjSgZZOJ/WqNgKFd7oRPTu5McxgbsphezZYxgKiQrtcIaGQd3BAbVrTeCrywnTgJUkfuLOFHZ1ocZ+0ayI9qR4YsxBf6tBtUNKOUjU5zx2TmJ0eoRXSAmAnlDUTb8Z1TuS7szByuy0wY3CvNIns80S1lJvqA05ObNmyUohva7Z/cLDU5DbjLfVTcij4cpMsKWMWgmR8yk7QorqVu+vOHh3l/aHJxq0zKDS6Y1jUHg5vA6bqmgudlHfUctINZl4xQBQiadN9vfdFDNAfgBl3x9x2lknFWUvbszdJRShuXv+O1AmaXPeqaPWlx5DmlzvTJc9GfFytHDYjBUrO0scYhahiZu4bmD3F1asmtt2y7+zBvt9sPNaZWVdJ+piJM/NGZriJO/aRXF2fi3FYCwqK/xmelWsnU6PL+1UaGj14roB+2QatvLh01oDU7YWWhHqIsLhV/zqkQwEzjpAKJC7ADpQD0Q6ikrCwlIES7afAw8qPzzEG285T9nm28JGOo1DYi4VQPeLDmOYhKLM9F4mzTULGf71hPfJT2lYArTDWarBcwdV6bDMhSF56XtkLbgDeARWUz3WlHmISFu2pilZxXwbPchbkjAwIZFqUddDGWGg+Yd4iKu9zZAEv8ZrqLri0Dhl54gOy08LoBq4Fd7syAbC6ajw+uOhFDAdjGEXo4Wi9gcI80ByCx/PRi8pmlOn0RAnS6VIDnsUomp5nIDLghAxoVln5gPnj5bRGAdAZ6x5v+ayQYeZk/8cJpnsKsqzmO6OlXNgPPB2sGFHRh1q6RUiSr995s1AM6Dp2B5pj379olGJPXFinBSrCuMaKX7c5qupNCjt2l+0sHg3j9VtAcxGbmUjKBHRAqxr0HWxmTcRzmx50ZlTWvJtYDCHVH+8w2uqHVhOOuvBm41hV9uJkFApI/UDF2Fsz+U0DIel4+eSp0nUGnQBXWzCIBDW82mhcPPGZK/qnNWSLw5WS9QScVoFEkINTd8L6X5OapP5/P2/0nL/B2vsbAr76Z2btGXbdk6ktn/YCpJZj+lmbYWLz6M0z3BwzUgf7umWLmoKKZmbtG1xDQNQ9W768/33nRxL13f77v4WYiO6e9fgkG+ytd18TVBYPRdTB98f3730l5//ePkNMl7BN+xzmIdQucgwadhs8uBDG63R4r3RqcpoGsvFcxjS5gRZ8JUKOelOXI9HMWvQAVvsCrh86iny7UDvK6qQAN+IKxlr7s4E3tK+UxDAuXTdcN7cOjwWSDAxYnQSPNd77Ad1novoVLKDNNFLwW2pAKlfP7QVbAiDVB0ierRmM/Hg/OrTlKQLI2lM9YqsrxJI3Xk0BVJH7SKB3HN48Y9batAYTwYui4qarwuVoMYEX9ZNjQGwPqcO4RX0wsbRh63z5+fAHJr/351NED4gpxOockrw8fP378Qn5eBd5rxrzXo9SA0au6RF1TmeCXIZzMl/S4OT2bDpv0QFhuNpsfyM/gwSdlRgaBJBW/kAdem7A3J76day9pjtt1cRLEugkkWK1itt7CkgO/eIz3h2a53PynSRMX4lJOcFP0G3mi/BtssMpCxqtAlHdFZV8TJOkaunyfu6FG47r9FyD8ZurMRDBsgzs2P/E+WcmbOvSiDLOVYlUX51Em6RrMYjPbdrjRDuiON81yvfzCxGTFOEB6TcQbIPzJ5McughurkB1+WSlMgvrbW0RDv2uKSYZio+Gccr1cr5ehvfNwlVAUHNNJgbD8M6gaN1TX6T6bPOCfwG+N9yiTAG6ACJeK2yAsUBtfm/V6vfnGFDIz9IAWSv010TTlJqhfN1wXx/FxNKBQPGnrAw/xst+hIgw32qbTkIiwDKpx5khVQoCO04U8lK8/kPLPX3EiKsQOO4tVPeBkvH38kpbr3UYpG2BQ9hDQnlqKRmOqwRsyC0khr25sua0yYK0vXdk2q4XfF9+1pQMsHQXf4XAcCVhNIEFMnHm0VY22obeRr9w08dxaNGA3fNXgSfi4Ao6Me/jKQUWjB4ehtzg2or41IoEE8RB+21Y0Gg8cfGhSQjLmHt1oQIv53h10UJmX+lxzpLoOnHE7HExKikZPGFUH36XDESMDD7ExmdIdN+ZK2/aREpa/ercoagDpmDb3j494uUZX/sIN1CVWn59POB5PPPGwZuL3gF5ee29xjM7kWCvBjSQWlOoZVaPdGdf8ZCqCn7lUOKUeoIXJFy93d7e9svuSaWlhiC7905qkbE8CUmkhuPAWu7vgbR1GeZ/xFhTP5CmPVuDBOhQgMRffsJoekB6OORD4oIGgxBauw51TvsHvlw67koeWY+yjwFtsgxQbesBQTlkIEPTMiSPPFZxXIJSvTQQsNz+aEGTTA9L7IY6CrdsGxbh35Remik4uFosLNmtfHvsF/i8BbsMvd6O8nhhAX8+EjTd3SsEeohM2t/SAeMLkTibcDqtGIlQ4ykaWGivVevKtTAiddJ0DEGPYXWUSgueUgr1Ap2ah0rhcg4CHdygDbr8KIdwsbabWLHsVjnzshwg78AW1mQGpnnHVUoGPr1NA6tRcRRzkSkoYOJLpOCELqiE0NIAbMYAl6s+or7uga0MGWK7/CrcsqOYrM55awrsxK6AWb4KeHz5FzAYtZzGEmry2qIUWZnM/28pGc6e0zMoPZvA+F2k/P4JwhxZMr1pKMxlXzB1WYxxNGJ/2pVhJwtK3rz6c5VKnlJV6+aPJkveVgJEypO2/Vsxkq4brxd0khHGAyqVyFeKjS/W8gmn462sOWMeJ+KwFtKxuHOE+GwQBQJoLfpmAMD6vTbX5AsbwSpFcwZ3Sr00PsNz8CvbC0QHW4gih+UNbBqQ3MXTiCbXOWfRSGU83qRstOqXUXnyCpjhyIkYgHhBHOFP47i6sKGMJ47Oi1LGAA3HgSAGXJ9NzStkC6gNvozJpKI7w3hQvovBJ8VqRcRxhRkDQpDeuEhDvszDLAmC5DEafXdETBozVNFSphRcnyQi1Wx2RgJg72g59uwP+RKf0Q1MErJfB+zYfVKqXrQ4TEIZ8dzsRoQ6wFAmIxyhXqi8/sGyXT0MfsI6LREBUXC9Mv51FSXi40+DmsK+I1uHlE+NGEkJtXpt22wbaq5xXTn92JTilnjoFxwZibvLtuzynTUnYOcdyYKqjdUh4iVUuowk1gfIIwJap+W4Am63i6kFAgvgaI00300CKomPX2ANxfmlfEa1zA0viCMLUgDSFW6k42FWAX2VAcMA/4J+u8LgTvQ/TXfb55bOxhIponUQYXj11aHhV531G7UvhaWZVvig9QWl+K4cAiVS/0JY8XuD3IUznga+ACK0PA60XL1fyXrjBVeKdTAjO3lGEe72hBdwwYI4olxX0WlbzRVkCrONkfPObqSgfXoOmlUIQu3zb9d2PP8K1RQuVxcez0KPRYDAogWN3Lb0FTM5xVIKHDpB+O/WF8rsBlrRZP6sACWL5xb9kvq+fmrhG7gSEuHvEN74f6eVaj+HLJulNfKydZzjSRcRdvG1lEHF3oB4QFc1CcaCe3pNHWvtaHqKctFx/80UIbv/27U29yXyezvGuX67vvDo/9nr/Jj9OZEC8hhe/UY80cwMjDq+uhbfAaN21/kt/KxGA2GFzKwzIT219qKskyOxGs/z608dv37798uIT7wDc9iUTaf+Aln2fzzT/pveH+V3KSNHed0q8mfRwxyF/i7c0tjyp6nOQIgDxtp2wU2pZ/MKVH5paQM6ExfsN+uZy+URn7e+9Xg+u1zKDgOg64Y0ErJlnircYxdz+qN3VOPfO+UopzS41Fl+akYCKF+WQEvr1TZOaF7hYsPcfk11O7I1V3FC9F+WwI/NdDqIWSFGAJaJKh8qkdJee1P5F9tniAOughD4Ijfvwot7E3W7T/A8Qvjf51VleEAOTNsVmGpMzMa/nZaNSiV4B6velYBPkylUA0slPxlcznQSpoiUTlBf4T7n5C77ZCSb5mWwt432i9UjvGZT26CcDWnC7LSYPUL/NCsZiprrJkl+w/iYDoDhN2aryBb5ZRyQULO8jfpd12KOs8p+xiY7aTAB+jZDiLoupR5hqiKo7A4PlJlwsSAmvAvf6wO0MnQRZn1nSvnBKQ+6BDFiz2pywAMBymSnY9z1qL56CFymDUpuoN0vjAAU+9ZOgl6dWGLDGb+f6OcsQDdWlkQFqLkDT9AM+BsZKBkaw0YnTnw1tXhs+eW8Gvu7IN1Pc2X9dBKBH+AcziMHAF/bmKLsEI/PaIIlmZYUB+VWenddS67MBNn82PXPxu2gPa549bGUA9NcP+iePTFWAFowFdTk79SIk6BE+E8I/TH8zVlhrNxICak40aJ/0nTbZFzY9wvyAHiEoUzinEYwL4R1E43SAUmaC/klC2FF9N4DDjAWM0vyAPiFbXUg3M4Htvc+Tehmxs3isSa7gQRqiaQoApFurzFy8M1kemK/fYMAc5chMjMhrgxjGXleRXAHqrQM7Nq+LAKT28C01F49IGFiKAuFxiiu+wyZF+yQjVMQviSq9uxYsfj5AJLym5gIUTvC2bFRr58m/HS58JiXiSSQMA9ZgL+gtuANvmjFcifxWzNuEqN6/qVtqB3wM3As4iJVg6rw2fJIShg0irEmPx6a0LZMVsI6ed4Os1d/Ri96le0JgxLwqZR6ikXltL8N52Oizof4Gp/VTM5Ir4coDV0+jSwhG4TXo0tW9eBH9JDtgVNrXS/VVXuhHtWDhEdq1yAJYbkJ8dQIT8cf3ZjhiijH9QTYtGpfX9lIIYgiixPMHJVg8fmsWAEi3jtEJ/hsipm0p89uhrneOA3X6Jz1CyWcz4ZY8CAD8s1kAYLkJsVXcQPjLc0vFSdFH1zvzEA3ntfk7i5xQ8tkgVrqLhD80CwDEdO9DTBj4g7ulgUkB034n/kq3sJnQZEUJZyzUFh8XbA2jRGz01yIAy3XyfpcYMvnPn2Y4gRN9RP1RqASrf+2TTJfKBhFveCa6jSi/3+Jbn8DrgTDxtTE5JAaRuqXSmGGOaSygeohqAaFHlBYfI7SwW3ccWiBmA8QF8D322DtwS+VPRMLt5EM0Oq8t2DVKi48X6MCgueaL/HyAdIl/hj2211Hcb4ddep0dMCqvTWXx6ZYzRBW2GWFOwDpG+sf8W5LMYciJguDsedwQjfRbtV2jsPjEKSateFVlt5jJ2/gZAGm4tOEF668kl8bCHM/9alYJRgEqLH6N3rN+DbKHTaCfIgxi0tU/5oeP+Fe6Cd8/xD8SPIxOKZx+l/iEu172IYtfY4HEBgTKoUUfFbvcKQGZ08auCpV3LTCyB3Gv0kYGLRqX1xay+JhxiV/3ulGlff6tnBuw3PyBEpboZmI47QtjlxM5rTBNFFwne9niY8YlKLYDXHNBn39palqfIkAFbikel6Dn4NuhtC8xYprpnhD9k0GLTyPQ3FYYxmSPb5HmAizXiVt6sEGHjKk6pClETDPdMqGVvRG0+DUhLYJWeWWa/8oPWH79K8v3oRcwhU/rMcdU08z48IYeMGDxeao27OaxOvvkz/klWKdOG1EH1FysQmdSHB4xzaBkvE1gtewD9tCPlB6xroE0lvyAeFZ2G8xPixLKgNRAnWUcosHLTeSueRnaxme2glYBty2U15YWsI7x4HuI2uK5uz05Vb9Gr23fzSpBDaBk8f0ToGxdgVXAzfpZsUeaCrDMnDb4RCC8rYWcKB4xzTIHA3ltIdkL9pCPHLAV57wurMo/lXMC0gNhVFNCDt9QcejGxaBCBjOhvr1F2FkEQrxPnZ+d47aC1t1Bt41lzPDMGf9FM+4F+/nN086Q4nbj2uIn0m+PgPOihkZwib+0S5OZ2Om3xXLDQiZYBTTDlxd5y09fTb7HC+bipK0osJkXamZSCeoBN5gJlsqdV3ek+nOm0qHnRMdRdXTNjN9qC+IGukZJeO19b/ZE9edMBZ22UqUVVaekbWYMYGCXW3oylF4FZVQRR3ExZZd+dEl12JKVS3UzY+dgJTrta9AIlYGwC1Rthf+epYz4R5e0b9gqZRyiMqAke0WpSnULKkGtoCyZlEwMYOKN8mR1s8dZwo1O1czvDpj4jklNZ6Ru5nfpxrwSzCXt7I3+fzFEvztgpiGa76O/z6d89yEqNDNroyNvoV93o1P17f8Cclv0QbBLaZMAAAAASUVORK5CYII=',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 20.0),
                        child: Text(
                          'Avatar',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Readex Pro',
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    letterSpacing: 0.0,
                                  ),
                        ),
                      ),
                      Container(
                        width: 300.0,
                        height: 100.0,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            final selectedMedia =
                                await selectMediaWithSourceBottomSheet(
                              context: context,
                              maxWidth: 50.00,
                              maxHeight: 50.00,
                              imageQuality: 100,
                              allowPhoto: true,
                              pickerFontFamily: 'Lexend Deca',
                            );
                            if (selectedMedia != null &&
                                selectedMedia.every((m) => validateFileFormat(
                                    m.storagePath, context))) {
                              setState(() => _model.isDataUploading2 = true);
                              var selectedUploadedFiles = <FFUploadedFile>[];

                              var downloadUrls = <String>[];
                              try {
                                selectedUploadedFiles = selectedMedia
                                    .map((m) => FFUploadedFile(
                                          name: m.storagePath.split('/').last,
                                          bytes: m.bytes,
                                          height: m.dimensions?.height,
                                          width: m.dimensions?.width,
                                          blurHash: m.blurHash,
                                        ))
                                    .toList();

                                downloadUrls = (await Future.wait(
                                  selectedMedia.map(
                                    (m) async => await uploadData(
                                        m.storagePath, m.bytes),
                                  ),
                                ))
                                    .where((u) => u != null)
                                    .map((u) => u!)
                                    .toList();
                              } finally {
                                _model.isDataUploading2 = false;
                              }
                              if (selectedUploadedFiles.length ==
                                      selectedMedia.length &&
                                  downloadUrls.length == selectedMedia.length) {
                                setState(() {
                                  _model.uploadedLocalFile2 =
                                      selectedUploadedFiles.first;
                                  _model.uploadedFileUrl2 = downloadUrls.first;
                                });
                              } else {
                                setState(() {});
                                return;
                              }
                            }
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              valueOrDefault<String>(
                                _model.uploadedFileUrl2,
                                'data:image/jpeg;base64,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',
                              ),
                              width: 300.0,
                              height: 200.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                        child: Text(
                          'Background',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Readex Pro',
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    letterSpacing: 0.0,
                                  ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 30.0, 0.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Create your own profile',
                              textAlign: TextAlign.start,
                              style: FlutterFlowTheme.of(context)
                                  .titleLarge
                                  .override(
                                    fontFamily: 'Roboto',
                                    color: Colors.white,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 16.0),
                  child: AuthUserStreamWidget(
                    builder: (context) => TextFormField(
                      controller: _model.yourNameTextController,
                      focusNode: _model.yourNameFocusNode,
                      textCapitalization: TextCapitalization.words,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Your Name',
                        labelStyle:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Color(0xFFF8F0F0),
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.normal,
                                ),
                        hintStyle:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Color(0xFF57636C),
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.normal,
                                ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFE0E3E7),
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF4B39EF),
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFFF5963),
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFFF5963),
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        filled: true,
                        fillColor: Colors.black,
                        contentPadding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 24.0, 0.0, 24.0),
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Plus Jakarta Sans',
                            color: Color(0xFFFDFDFD),
                            fontSize: 14.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.normal,
                          ),
                      keyboardType: TextInputType.name,
                      validator: _model.yourNameTextControllerValidator
                          .asValidator(context),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 16.0),
                  child: AuthUserStreamWidget(
                    builder: (context) => TextFormField(
                      controller: _model.ageTextController,
                      focusNode: _model.ageFocusNode,
                      textCapitalization: TextCapitalization.words,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Age',
                        labelStyle:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Color(0xFFF7F8F9),
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.normal,
                                ),
                        hintText: 'Age',
                        hintStyle:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Color(0xFF57636C),
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.normal,
                                ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFE0E3E7),
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFFF5963),
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFFF5963),
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        filled: true,
                        fillColor: Colors.black,
                        contentPadding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 24.0, 0.0, 24.0),
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Plus Jakarta Sans',
                            color: Color(0xFFF7F7F7),
                            fontSize: 14.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.normal,
                          ),
                      keyboardType: TextInputType.number,
                      validator: _model.ageTextControllerValidator
                          .asValidator(context),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(35.0, 0.0, 0.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Your Gender',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Readex Pro',
                              color: Color(0xFFF9F3F3),
                              fontSize: 12.0,
                              letterSpacing: 0.0,
                            ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 12.0),
                  child: AuthUserStreamWidget(
                    builder: (context) => FlutterFlowDropDown<String>(
                      controller: _model.genderValueController ??=
                          FormFieldController<String>(
                        _model.genderValue ??=
                            valueOrDefault(currentUserDocument?.gender, ''),
                      ),
                      options: ['Male', 'Female', 'Gender'],
                      onChanged: (val) =>
                          setState(() => _model.genderValue = val),
                      width: double.infinity,
                      height: 56.0,
                      textStyle:
                          FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Plus Jakarta Sans',
                                color: Color(0xFFEDEDF0),
                                fontSize: 14.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.normal,
                              ),
                      icon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Color(0xFF57636C),
                        size: 15.0,
                      ),
                      fillColor: Colors.black,
                      elevation: 2.0,
                      borderColor: Color(0xFFE0E3E7),
                      borderWidth: 2.0,
                      borderRadius: 8.0,
                      margin:
                          EdgeInsetsDirectional.fromSTEB(20.0, 4.0, 12.0, 4.0),
                      hidesUnderline: true,
                      isSearchable: false,
                      isMultiSelect: false,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 16.0),
                  child: TextFormField(
                    controller: _model.emailTextController,
                    focusNode: _model.emailFocusNode,
                    textCapitalization: TextCapitalization.words,
                    readOnly: true,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: currentUserEmail,
                      labelStyle:
                          FlutterFlowTheme.of(context).labelMedium.override(
                                fontFamily: 'Plus Jakarta Sans',
                                color: Color(0xFFCCD0D4),
                                fontSize: 14.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.normal,
                              ),
                      hintStyle:
                          FlutterFlowTheme.of(context).labelMedium.override(
                                fontFamily: 'Plus Jakarta Sans',
                                color: Color(0xFF57636C),
                                fontSize: 14.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.normal,
                              ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFE0E3E7),
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF4B39EF),
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFFF5963),
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFFF5963),
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      filled: true,
                      fillColor: Color(0x4C363131),
                      contentPadding:
                          EdgeInsetsDirectional.fromSTEB(20.0, 24.0, 0.0, 24.0),
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Plus Jakarta Sans',
                          color: Color(0xFF14181B),
                          fontSize: 14.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.normal,
                        ),
                    validator: _model.emailTextControllerValidator
                        .asValidator(context),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 16.0),
                  child: AuthUserStreamWidget(
                    builder: (context) => TextFormField(
                      controller: _model.phoneNumberTextController,
                      focusNode: _model.phoneNumberFocusNode,
                      textCapitalization: TextCapitalization.none,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        labelStyle:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Color(0xFFF9F9F9),
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.normal,
                                ),
                        hintStyle:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Color(0xFFFBFBFB),
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.normal,
                                ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFE0E3E7),
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFFBF8F8),
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFFF5963),
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFFF5963),
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        filled: true,
                        fillColor: Colors.black,
                        contentPadding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 24.0, 0.0, 24.0),
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Plus Jakarta Sans',
                            color: Colors.white,
                            fontSize: 14.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.normal,
                          ),
                      keyboardType: TextInputType.phone,
                      validator: _model.phoneNumberTextControllerValidator
                          .asValidator(context),
                      inputFormatters: [_model.phoneNumberMask],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 16.0),
                  child: AuthUserStreamWidget(
                    builder: (context) => TextFormField(
                      controller: _model.weightTextController,
                      focusNode: _model.weightFocusNode,
                      textCapitalization: TextCapitalization.words,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Weight',
                        labelStyle:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Color(0xFFF7F9F9),
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.normal,
                                ),
                        hintStyle:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Color(0xFF57636C),
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.normal,
                                ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFE0E3E7),
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFF5F5F9),
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFFF5963),
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFFF5963),
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        filled: true,
                        fillColor: Colors.black,
                        contentPadding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 24.0, 0.0, 24.0),
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Plus Jakarta Sans',
                            color: Color(0xFFF4F6F8),
                            fontSize: 14.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.normal,
                          ),
                      keyboardType: TextInputType.number,
                      validator: _model.weightTextControllerValidator
                          .asValidator(context),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 16.0),
                  child: AuthUserStreamWidget(
                    builder: (context) => TextFormField(
                      controller: _model.wishweightTextController,
                      focusNode: _model.wishweightFocusNode,
                      textCapitalization: TextCapitalization.words,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Wish Weight',
                        labelStyle:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Color(0xFFF7F9F9),
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.normal,
                                ),
                        hintStyle:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Color(0xFF57636C),
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.normal,
                                ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFE0E3E7),
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFF5F5F9),
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFFF5963),
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFFF5963),
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        filled: true,
                        fillColor: Colors.black,
                        contentPadding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 24.0, 0.0, 24.0),
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Plus Jakarta Sans',
                            color: Color(0xFFF4F6F8),
                            fontSize: 14.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.normal,
                          ),
                      keyboardType: TextInputType.number,
                      validator: _model.wishweightTextControllerValidator
                          .asValidator(context),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 16.0),
                  child: AuthUserStreamWidget(
                    builder: (context) => TextFormField(
                      controller: _model.timesToAchieveTextController,
                      focusNode: _model.timesToAchieveFocusNode,
                      textCapitalization: TextCapitalization.words,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Time to achieve goal (month)',
                        labelStyle:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Color(0xFFF7F9F9),
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.normal,
                                ),
                        hintStyle:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Color(0xFF57636C),
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.normal,
                                ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFE0E3E7),
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFF5F5F9),
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFFF5963),
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFFF5963),
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        filled: true,
                        fillColor: Colors.black,
                        contentPadding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 24.0, 0.0, 24.0),
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Plus Jakarta Sans',
                            color: Color(0xFFF4F6F8),
                            fontSize: 14.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.normal,
                          ),
                      keyboardType: TextInputType.number,
                      validator: _model.timesToAchieveTextControllerValidator
                          .asValidator(context),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(35.0, 0.0, 0.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                        child: Text(
                          'Your Country',
                          style:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                    fontFamily: 'Readex Pro',
                                    color: Color(0xFFF1F4F6),
                                    fontSize: 12.0,
                                    letterSpacing: 0.0,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 12.0),
                  child: AuthUserStreamWidget(
                    builder: (context) => FlutterFlowDropDown<String>(
                      controller: _model.countryValueController ??=
                          FormFieldController<String>(
                        _model.countryValue ??=
                            valueOrDefault(currentUserDocument?.country, ''),
                      ),
                      options: [
                        'Viet Nam',
                        'Malaysia',
                        'Korean',
                        'Japan',
                        'Campuchia',
                        'Thailand',
                        'Country'
                      ],
                      onChanged: (val) =>
                          setState(() => _model.countryValue = val),
                      width: double.infinity,
                      height: 56.0,
                      textStyle:
                          FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Plus Jakarta Sans',
                                color: Color(0xFFF8F8F8),
                                fontSize: 14.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.normal,
                              ),
                      hintText: 'Your Country',
                      icon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Color(0xFFFFFBFB),
                        size: 15.0,
                      ),
                      fillColor: Colors.black,
                      elevation: 2.0,
                      borderColor: Color(0xFFE0E3E7),
                      borderWidth: 2.0,
                      borderRadius: 8.0,
                      margin:
                          EdgeInsetsDirectional.fromSTEB(20.0, 4.0, 12.0, 4.0),
                      hidesUnderline: true,
                      isSearchable: false,
                      isMultiSelect: false,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 16.0),
                  child: AuthUserStreamWidget(
                    builder: (context) => TextFormField(
                      controller: _model.cityTextController,
                      focusNode: _model.cityFocusNode,
                      textCapitalization: TextCapitalization.words,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'City',
                        labelStyle:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Color(0xFFF3F3F4),
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.normal,
                                ),
                        hintStyle:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Color(0xFF57636C),
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.normal,
                                ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFE0E3E7),
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFEAEAEE),
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFFF5963),
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFFF5963),
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        filled: true,
                        fillColor: Color(0xFF0D0D0D),
                        contentPadding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 24.0, 0.0, 24.0),
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Plus Jakarta Sans',
                            color: Color(0xFFF9F9F9),
                            fontSize: 14.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.normal,
                          ),
                      validator: _model.cityTextControllerValidator
                          .asValidator(context),
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0.0, 0.05),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                    child: FFButtonWidget(
                      onPressed: () async {
                        await currentUserReference!
                            .update(createUsersRecordData(
                          phoneNumber: valueOrDefault<String>(
                            _model.phoneNumberTextController.text,
                            '0123456789',
                          ),
                          weight:
                              int.tryParse(_model.weightTextController.text),
                          fullName: valueOrDefault<String>(
                            _model.yourNameTextController.text,
                            'Name',
                          ),
                          city: valueOrDefault<String>(
                            _model.cityTextController.text,
                            'Ho Chi Minh',
                          ),
                          country: valueOrDefault<String>(
                            _model.countryValue,
                            'Viet Nam',
                          ),
                          age: valueOrDefault<int>(
                            int.tryParse(_model.ageTextController.text),
                            18,
                          ),
                          gender: _model.genderValue,
                          photoUrl: _model.uploadedFileUrl1,
                          wishWeight: int.tryParse(
                              _model.wishweightTextController.text),
                          timesToAchieve: valueOrDefault<int>(
                            int.tryParse(
                                _model.timesToAchieveTextController.text),
                            1,
                          ),
                          backgroundImage: _model.uploadedFileUrl2,
                        ));

                        context.pushNamed('homePage');
                      },
                      text: 'Create',
                      options: FFButtonOptions(
                        width: 270.0,
                        height: 50.0,
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: Color(0xFF31B478),
                        textStyle:
                            FlutterFlowTheme.of(context).titleMedium.override(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.normal,
                                ),
                        elevation: 2.0,
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
