package com.example.client.client

import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

private const val PORT = "2325"
private const val BASE_URL = "http://10.0.2.2:$PORT/"

class ClientConfig {

    fun provideApi() : ClientAPI {
        return Retrofit.Builder()
            .baseUrl(BASE_URL)
            .addConverterFactory(GsonConverterFactory.create())
            .build()
            .create(ClientAPI::class.java)
    }
}