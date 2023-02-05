package com.example.client.data.model

import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "item")
data class Item(

    @PrimaryKey
    @ColumnInfo(name = "id")
    val id: Int,

    @ColumnInfo(name = "name")
    val name: String,

    @ColumnInfo(name = "description")
    val description: String,

    @ColumnInfo(name = "image")
    val image: String,

    @ColumnInfo(name = "category")
    val category: String,

    @ColumnInfo(name = "units")
    val units: Int,

    @ColumnInfo(name = "price")
    val price: Double
)
{
    override fun equals(other: Any?): Boolean
    {
        return (other is Item) && id == other.id;
    }

    override fun hashCode(): Int {
        var result = id.hashCode();

        result = 31 * result + name.hashCode();
        result = 31 * result + description.hashCode();
        result = 31 * result + image.hashCode();
        result = 31 * result + category.hashCode();
        result = 31 * result + units;
        result = 31 * result + price.toInt();

        return result;
    }

}
