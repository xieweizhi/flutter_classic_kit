import 'dart:async';

import 'package:classic_kit/classic_kit/ck_app_bar.dart';
import 'package:classic_kit/classic_kit/ck_button.dart';
import 'package:classic_kit/classic_kit/ck_status_view.dart';
import 'package:classic_kit/classic_kit/ck_textfield.dart';
import 'package:classic_kit/example/about_page.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BrowseWidget extends StatelessWidget {
  final _homeUrl = 'https://en.m.wikipedia.org';
  final _textController = TextEditingController();
  final _audioCache = AudioCache();

  final Completer<WebViewController> _webViewController =
      Completer<WebViewController>();

  final _pageIsLoading = StreamController<bool>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CKAppBar(),
        backgroundColor: Color(0xffc0c0c0),
        body: Container(
          child: SafeArea(
              child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                child: Stack(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(right: 80),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            _buildTop(context: context),
                            _buildTextFieldRow(context: context)
                          ],
                        )),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Image.asset(
                        "icons/Explorer.gif",
                        height: 73.0,
                        width: 73.0,
                      ),
                    )
                  ],
                ),
              ),
              _buildWebViewRow(),
              _buildBottom(),
            ],
          )),
        ));
  }

  Widget _buildTop({BuildContext context}) {
    return Row(
      children: <Widget>[
        _buildBackAndForwardButtons(),
        SizedBox(
          width: 8,
        ),
        _buildStopAndRefreshButtons(),
        SizedBox(
          width: 8,
        ),
        _buildHomeAndHelpButtons(context: context),
      ],
    );
  }

  Widget _buildTextFieldRow({BuildContext context}) {
    return FutureBuilder<WebViewController>(
      future: _webViewController.future,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> controller) {
        if (controller.hasData) {
          return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                    child: Container(
                        height: 30,
                        child: CKTextField(controller: _textController))),
                SizedBox(
                  width: 4,
                ),
                CKButton(
                    maxWidth: 60,
                    maxHeight: 30,
                    child: Text('Go'),
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      controller.data.loadUrl(_textController.text);
                      _loadAudio();
                    })
              ]);
        }

        return Container();
      },
    );
  }

  Widget _buildBackAndForwardButtons() {
    return _buildButtonPairs(
      firstImage: 'icons/arrow_left.png',
      secondImage: 'icons/arrow_right.png',
      firstOnTap: () {
        _webViewController.future.then((controller) {
          controller.goBack();
        });
        _loadAudio();
      },
      secondOnTap: () {
        _webViewController.future.then((controller) {
          controller.goForward();
        });
        _loadAudio();
      },
    );
  }

  Widget _buildStopAndRefreshButtons() {
    return _buildButtonPairs(
      firstImage: 'icons/media_player_stream_no.png',
      secondImage: 'icons/refresh.png',
      firstOnTap: () {
        _webViewController.future.then((controller) {
          controller.reload();
        });
      },
      secondOnTap: () {
        _loadAudio();
      },
    );
  }

  Widget _buildHomeAndHelpButtons({BuildContext context}) {
    return _buildButtonPairs(
      firstImage: 'icons/homepage.png',
      secondImage: 'icons/help.png',
      firstOnTap: () {
        _webViewController.future.then((controller) {
          controller.loadUrl(_homeUrl);
        });
        _loadAudio();
      },
      secondOnTap: () {
        _showErrorPage(context);
      },
    );
  }

  Widget _getImage(String name) {
    return Image.asset(
      name,
      height: 20,
    );
  }

  Widget _buildButtonPairs(
      {firstImage: String,
      firstEnable = true,
      secondImage: String,
      secondEnable = true,
      firstOnTap: GestureTapCallback,
      secondOnTap: GestureTapCallback}) {
    return FutureBuilder<WebViewController>(
      future: _webViewController.future,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> controller) {
        if (controller.hasData) {
          return Container(
              height: 44,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CKButton(
                    enable: firstEnable,
                    onTap: firstOnTap,
                    child: _getImage(firstImage),
                  ),
                  CKButton(
                    enable: secondEnable,
                    onTap: secondOnTap,
                    child: _getImage(secondImage),
                  ),
                ],
              ));
        }
        return Container();
      },
    );
  }

  Widget _buildWebViewRow() {
    return Expanded(
        child: Row(
      children: <Widget>[
        Expanded(
            child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            CKStatusView(),
            WebView(
              navigationDelegate: (navigation) {
                _textController.text = navigation.url;
                _pageIsLoading.add(true);
                return NavigationDecision.navigate;
              },
              initialUrl: _homeUrl,
              onWebViewCreated: (controller) {
                _webViewController.complete(controller);
              },
              onPageFinished: (_) {
                _pageIsLoading.add(false);
              },
            )
          ],
        )),
        Container(
          width: 35,
          child: CKStatusView(),
        )
      ],
    ));
  }

  Widget _buildBottom() {
    return StreamBuilder<bool>(
      stream: _pageIsLoading.stream,
      builder: (BuildContext context, AsyncSnapshot<bool> status) {
        if (!status.hasData) {
          return Container();
        }
        final statusString = status.data ? "Opening page..." : "Ready";
        final statusView = CKStatusView(
            child: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 8),
          child: Text(
            statusString,
            style: TextStyle(fontSize: 12),
          ),
        ));
        return Container(
          height: 34,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(flex: 5, child: statusView),
              Expanded(flex: 4, child: CKStatusView())
            ],
          ),
        );
      },
    );
  }

  _loadAudio() {
    _audioCache.play('windows_nvigation_start.wav');
  }

  _showErrorPage(BuildContext context) {
    Navigator.push(context, AboutPageOverlay());
  }
}
