package com.example.share.data.model

import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "category")
data class Category(
    @PrimaryKey
    @ColumnInfo(name = "category")
    val category: String
) {
    override fun equals(other: Any?): Boolean
    {
        return (other is Category) && category == other.category;
    }

    override fun hashCode(): Int {
        return category.hashCode();
    }
}