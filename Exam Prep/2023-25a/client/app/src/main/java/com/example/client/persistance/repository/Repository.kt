package com.example.share.persistance.repository

import com.example.share.client.ClientAPI
import com.example.share.data.model.Category
import com.example.share.data.model.Item
import com.example.share.persistance.database.MyDao
import kotlinx.coroutines.flow.Flow

// Declares the DAO as a private property in the constructor. Pass in the DAO
// instead of the whole database, because you only need access to the DAO
class Repository(private val myDao: MyDao, private val api: ClientAPI)
{
    // Room executes all queries on a separate thread.
    // Observed Flow will notify the observer when the data has changed.
    val allItems: Flow<MutableList<Item>> = myDao.getItems();
    val allCategories: Flow<MutableList<Category>> = myDao.getCategories();

    suspend fun getItemsByCategory(c: String): Flow<MutableList<Item>> {
        return  myDao.getItemsByCategory(c)
    }

    suspend fun syncFirst(){
        myDao.nukeCategoryTable();
        api.retrieveAllCategories().body()?.forEach{elem -> myDao.insert(Category(elem))}
    }

    // By default Room runs suspend queries off the main thread, therefore, we don't need to
    // implement anything else to ensure we're not doing long running database work
    // off the main thread.


}
