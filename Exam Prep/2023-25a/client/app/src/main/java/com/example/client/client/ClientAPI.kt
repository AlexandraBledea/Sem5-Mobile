package com.example.share.client

import com.example.share.data.model.Category
import com.example.share.data.model.Item
import retrofit2.Response
import retrofit2.http.GET
import retrofit2.http.Path

interface ClientAPI {

    @GET("/categories")
    suspend fun retrieveAllCategories(): Response<List<Category>>

    @GET("/item/{category}")
    suspend fun retrieveAllItemsForCategory(@Path("Category") category: String): Response<List<Item>>

}