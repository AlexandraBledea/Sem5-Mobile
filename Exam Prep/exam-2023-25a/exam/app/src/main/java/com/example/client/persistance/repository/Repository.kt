package com.example.client.persistance.repository

import android.util.Log
import androidx.lifecycle.asLiveData
import com.example.client.client.ClientAPI
import com.example.client.data.model.Category
import com.example.client.data.model.Item
import com.example.client.persistance.database.MyDao
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.emptyFlow

// Declares the DAO as a private property in the constructor. Pass in the DAO
// instead of the whole database, because you only need access to the DAO
class Repository(private val myDao: MyDao, private val api: ClientAPI) {
    // Room executes all queries on a separate thread.
    // Observed Flow will notify the observer when the data has changed.
    val allItems: Flow<MutableList<Item>> = myDao.getItems();
    val allCategories: Flow<MutableList<Category>> = myDao.getCategories()

    fun getItemsByCategory(c: String): Flow<MutableList<Item>> {
        return myDao.getItemsByCategory(c)
    }

    suspend fun syncCategories() {
        myDao.nukeCategoryTable();
        api.retrieveAllCategories().body()
            ?.forEach { elem -> myDao.insertCategory(Category(elem)) }
    }

    fun nukeCategoryTable(){
        myDao.nukeCategoryTable()
    }

    fun nukeItemTable() {
        myDao.nukeItemTable()
    }

    suspend fun syncItemsByCategory(category: String) {
        api.retrieveAllItemsForCategory(category).body()?.forEach { elem ->
            Log.i("caca", elem.category); myDao.insertItem(elem)
        }
    }

    // By default Room runs suspend queries off the main thread, therefore, we don't need to
    // implement anything else to ensure we're not doing long running database work
    // off the main thread.


}
