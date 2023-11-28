/// Figma Variables API Client
///
/// Inspired by the original client developed by Arne Molland, this library
/// offers an easy-to-use interface for making requests to the Figma Variables API
/// and parsing responses into Dart objects.
///
/// Original Source:
/// https://github.com/arnemolland/figma

import 'dart:convert';
import 'dart:io';

import 'package:figma_variables_api/src/models/dto/variable_response/variables_response_dto.dart';
import 'package:figma_variables_api/src/query.dart';
import 'package:http/http.dart';
import 'package:http2/http2.dart';

/// Figma API base URL.
const base = 'api.figma.com';

/// A constant that is true if the application was compiled to run on the web.

// This implementation takes advantage of the fact that JavaScript does not support integers.
// In this environment, Dart's doubles and ints are backed by the same kind of object. Thus a
// double 0.0 is identical to an integer 0. This is not true for Dart code running in
// AOT or on the VM.
const bool kIsWeb = identical(0, 0.0);

/// A client for interacting with the Figma API.
class FigmaClient {
  FigmaClient(
    this.accessToken, {
    this.apiVersion = 'v1',
    this.useHttp2 = !kIsWeb,
    this.useOAuth = false,
  });

  /// Use HTTP2 sockets for interacting with API.
  ///
  /// This is the recommended way, but it may not work on certain platforms like web.
  ///
  /// If `false`, then the `http` package is used.
  final bool useHttp2;

  /// The personal access token for the Figma Account to be used
  /// Or the OAuth token, if useOAuth is true.
  final String accessToken;

  /// Specifies the Figma API version to be used. Should only be
  /// specified if package is not updated with a new API release.
  final String apiVersion;

  // If true, then use accessToken as OAuth token when calling figma API.
  final bool useOAuth;

  /// Does an authenticated GET request towards the Figma API.
  Future<Map<String, dynamic>> authenticatedGet(String url) async {
    final uri = Uri.parse(url);
    return await _send('GET', uri, _authHeaders).then((res) {
      if (res.statusCode >= 200 && res.statusCode < 300) {
        return jsonDecode(res.body);
      } else {
        throw FigmaException(code: res.statusCode, message: res.body);
      }
    });
  }

  /// Retrieves the local variables from the Figma file specified by [key].
  Future<VariablesResponseDto> getLocalVariables(String key) async {
    final json = await _getFigma('/files/$key/variables/local');
    return VariablesResponseDto.fromJson(json);
  }

  /// Does a GET request towards the Figma API.
  Future<Map<String, dynamic>> _getFigma(
    String path, [
    FigmaQuery? query,
  ]) async {
    final uri = Uri.https(base, '$apiVersion$path', query?.params);

    return await _send('GET', uri, _authHeaders).then((res) {
      if (res.statusCode >= 200 && res.statusCode < 300) {
        return jsonDecode(res.body);
      } else {
        throw FigmaException(code: res.statusCode, message: res.body);
      }
    });
  }

  Future<_Response> _send(
    String method,
    Uri uri,
    Map<String, String> headers, [
    String? body,
  ]) async {
    // HTTP/2 is not supported on all platforms, so we need to fallback to
    // HTTP/1.1 in that case.
    if (!useHttp2) {
      final client = Client();
      try {
        final request = Request(method, uri);
        request.headers.addAll(headers);
        final response = await client.send(request);
        final body = await response.stream.toBytes();
        return _Response(response.statusCode, utf8.decode(body));
      } finally {
        client.close();
      }
    }

    final transport = ClientTransportConnection.viaSocket(
      await SecureSocket.connect(
        uri.host,
        uri.port,
        supportedProtocols: ['h2'],
      ),
    );

    final stream = transport.makeRequest(
      [
        Header.ascii(':method', method),
        Header.ascii(':path', uri.path + (uri.hasQuery ? '?${uri.query}' : '')),
        Header.ascii(':scheme', uri.scheme),
        Header.ascii(':authority', uri.host),
        ...headers.entries.map(
          (e) => Header.ascii(e.key.toLowerCase(), e.value),
        ),
      ],
      endStream: body == null,
    );
    if (body != null) {
      stream.sendData(utf8.encode(body), endStream: true);
    }
    var status = 200;
    final buffer = <int>[];
    await for (final message in stream.incomingMessages) {
      if (message is HeadersStreamMessage) {
        for (final header in message.headers) {
          final name = utf8.decode(header.name);
          final value = utf8.decode(header.value);
          if (name == ':status') {
            status = int.parse(value);
          }
        }
      } else if (message is DataStreamMessage) {
        buffer.addAll(message.bytes);
      }
    }
    await transport.finish();

    return _Response(status, utf8.decode(buffer));
  }

  Map<String, String> get _authHeaders {
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };
    if (useOAuth) {
      headers['Authorization'] = 'Bearer $accessToken';
    } else {
      headers['X-Figma-Token'] = accessToken;
    }
    return headers;
  }
}

class _Response {
  const _Response(this.statusCode, this.body);

  final int statusCode;
  final String body;
}

/// An error from the [Figma API docs](https://www.figma.com/developers/api#errors).
class FigmaException implements Exception {
  const FigmaException({this.code, this.message});

  /// HTTP status code.
  final int? code;

  /// Error message.
  final String? message;
}
