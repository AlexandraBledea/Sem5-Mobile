package com.example.share.persistance.database

import androidx.room.Dao
import androidx.room.Query
import com.example.share.data.model.Item
import kotlinx.coroutines.flow.Flow
@Dao
interface MyDao {

    @Query("SELECT * FROM item")
    fun getItems(): Flow<MutableList<Item>>

    @Query("SELECT category FROM item")
    fun getCategories(): Flow<MutableList<String>>


    @Query("DELETE FROM item")
    fun nukeItemTable();

    @Query("DELETE FROM category")
    fun nukeCategoryTable();


}
