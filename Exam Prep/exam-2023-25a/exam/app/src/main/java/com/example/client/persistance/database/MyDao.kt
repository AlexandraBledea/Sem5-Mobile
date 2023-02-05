package com.example.client.persistance.database

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.Query
import com.example.client.data.model.Category
import com.example.client.data.model.Item
import kotlinx.coroutines.flow.Flow
@Dao
interface MyDao {

    @Query("SELECT * FROM item")
    fun getItems(): Flow<MutableList<Item>>

    @Query("SELECT * FROM category")
    fun getCategories(): Flow<MutableList<Category>>

    @Query("SELECT * from item WHERE category = :c")
    fun getItemsByCategory(c: String): Flow<MutableList<Item>>

    @Query("DELETE FROM item")
    fun nukeItemTable();

    @Query("DELETE FROM category")
    fun nukeCategoryTable();

    @Insert(entity = Category::class)
    fun insertCategory(category: Category)

    @Insert(entity = Item::class)
    suspend fun insertItem(elem: Item)

}
