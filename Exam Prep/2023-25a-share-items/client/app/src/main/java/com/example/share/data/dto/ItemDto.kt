package com.example.share.data.dto

data class ItemDto(
    val name: String,
    val description: String,
    val image: String,
    val category: String,
    val units: Int,
    val price: Double
) {
}