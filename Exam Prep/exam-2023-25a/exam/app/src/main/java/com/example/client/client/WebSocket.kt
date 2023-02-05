package com.example.client.client

import android.util.Log
import com.example.client.viewModel.MyViewModel
import okhttp3.Response
import okhttp3.WebSocket
import okhttp3.WebSocketListener

private const val DOT = "."
private const val SUCCESS = "success"
private const val FAILED = "Failed"
private const val WEBSOCKET = "webSocket"

class WebSocket(
    private val myViewModel: MyViewModel
): WebSocketListener(
) {

    override fun onOpen(webSocket: WebSocket, response: Response) {
        super.onOpen(webSocket, response)
        Log.i(WEBSOCKET + DOT + SUCCESS, "Successfully connected to the server websocket")
    }

    override fun onMessage(webSocket: WebSocket, text: String) {
        Log.i(
            WEBSOCKET + DOT + SUCCESS,
            "Successfully received a message from the server websocket"
        )
        myViewModel.setServerMessage(
            String.format(
                "Message from server received.",
            )
        )
    }

    override fun onFailure(webSocket: WebSocket, t: Throwable, response: Response?) {
        Log.e(WEBSOCKET + DOT + FAILED, "Failed to connect to the server websocket", t)
    }

}