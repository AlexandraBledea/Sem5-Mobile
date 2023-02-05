package com.example.share.persistance.database

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import com.example.share.data.model.Category
import com.example.share.data.model.Item
import kotlinx.coroutines.flow.Flow
@Dao
interface MyDao {

    @Query("SELECT * FROM item")
    fun getItems(): Flow<MutableList<Item>>

    @Query("SELECT category FROM item")
    fun getCategories(): Flow<MutableList<Category>>

    @Query("SELECT * from item WHERE category = :c")
    fun getItemsByCategory(c: String): Flow<MutableList<Item>>

    @Query("DELETE FROM item")
    fun nukeItemTable();

    @Query("DELETE FROM category")
    fun nukeCategoryTable();

    @Insert(entity = Category::class)
    suspend fun insert(category: Category)

}
