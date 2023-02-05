package com.example.client.client

import com.example.client.data.model.Item
import retrofit2.Response
import retrofit2.http.GET
import retrofit2.http.Path

interface ClientAPI {

    @GET("/categories")
    suspend fun retrieveAllCategories(): Response<List<String>>

    @GET("/items/{category}")
    suspend fun retrieveAllItemsForCategory(@Path("category") category: String): Response<List<Item>>

}