package com.example.client.viewModel

import android.app.AlertDialog
import com.example.client.data.model.Item
import android.content.Context
import android.net.ConnectivityManager
import android.net.NetworkCapabilities
import android.util.Log
import androidx.lifecycle.*
import com.example.client.data.model.Category
import com.example.client.exception.NoInternetConnection
import com.example.client.persistance.repository.Repository
import kotlinx.coroutines.awaitAll
import kotlinx.coroutines.delay
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.FlowCollector
import kotlinx.coroutines.flow.count
import kotlinx.coroutines.flow.emptyFlow
import kotlinx.coroutines.launch
import kotlinx.coroutines.suspendCancellableCoroutine
import kotlin.system.exitProcess

private const val ERROR = "Error"
private const val TRYING = "Trying"
private const val SUCCESS = "Success"

private const val DELAY_FOR_FLEXING_LOADING = 500L


class MyViewModel(
    private val repository: Repository,
    private val context: Context
) : ViewModel() {

    var syncedFirst = false

    //    var syncedSecond = false
    var syncedSecondMap = mutableMapOf<String, Boolean>()


    private val _isError: MutableLiveData<String?> = MutableLiveData()
    val isError: LiveData<String?>
        get() = _isError

    private val _isSuccess: MutableLiveData<String?> = MutableLiveData()
    val isSuccess: LiveData<String?>
        get() = _isSuccess

    private val _serverMessage: MutableLiveData<String?> = MutableLiveData()
    val serverMessage: LiveData<String?>
        get() = _serverMessage


    fun setServerMessage(msg: String) {
        _serverMessage.postValue(null)
        _serverMessage.postValue(msg)
        _serverMessage.postValue(null)
    }

    private val _isLoading: MutableLiveData<Boolean> = MutableLiveData()
    val isLoading: LiveData<Boolean>
        get() = _isLoading


    val categoriesList: LiveData<MutableList<Category>> = repository.allCategories.asLiveData()
    fun itemsList(category: String): Flow<MutableList<Item>> {
        return repository.getItemsByCategory(category)
    }


    fun nukeItemTable() {
        this.repository.nukeItemTable();
    }

    fun syncFirst() {
        viewModelScope.launch {
            try {
                Log.i(TRYING, "Trying to reach the server")
                _isError.value = null
                _isSuccess.value = null
                _isLoading.value = true

                delay(DELAY_FOR_FLEXING_LOADING)
                if (!hasInternetConnection()) {
                    throw NoInternetConnection("No internet connection")
                }

                if (!syncedFirst) {
                    repository.syncCategories()
                    syncedFirst = true
                    delay(DELAY_FOR_FLEXING_LOADING)
                    categoriesList.value?.forEach { elem -> syncedSecondMap[elem.category] = false }
                    _isSuccess.value = "Successfully synced data"
                }
            } catch (ex: Exception) {
                _isError.value = ex.message
                Log.e(ERROR, "Operation failed", ex)
                exitProcess(0)
            } finally {
                Log.i(SUCCESS, "Successfully reached the server")
                _isLoading.value = false
            }
        }
    }

    fun syncItemsByCategory(categoryType: String) {
        viewModelScope.launch {
            try {
                Log.i(TRYING, "Trying to reach the sever")
                _isError.value = null
                _isSuccess.value = null
                _isLoading.value = true

                delay(DELAY_FOR_FLEXING_LOADING)
                if (!hasInternetConnection()) {
                    throw NoInternetConnection("No internet connection!")
                }
                if (syncedSecondMap[categoryType] == false) {
                    repository.syncItemsByCategory(categoryType)

                    syncedSecondMap[categoryType] = true
                    _isSuccess.value = "Successfully synced data"
                }
            } catch (ex: Exception) {
                _isError.value = ex.message
                Log.e(ERROR, "Operation failed", ex)
            } finally {
                Log.i(SUCCESS, "Successfully reached the server")
                _isLoading.value = false
            }
        }
    }


    private fun hasInternetConnection(): Boolean {
        val connectivityManager =
            context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
        val network = connectivityManager.activeNetwork ?: return false
        val activeNetwork = connectivityManager.getNetworkCapabilities(network) ?: return false

        return when {
            activeNetwork.hasTransport(NetworkCapabilities.TRANSPORT_WIFI) -> true
            activeNetwork.hasTransport(NetworkCapabilities.TRANSPORT_CELLULAR) -> true
            else -> false
        }
    }

    private fun showDialog() {
        AlertDialog.Builder(context).setTitle("No Internet Connection")
            .setMessage("Fallback on local DB")
            .setPositiveButton(android.R.string.ok) { _, _ -> }
            .setIcon(android.R.drawable.ic_dialog_alert).show()
    }

}

