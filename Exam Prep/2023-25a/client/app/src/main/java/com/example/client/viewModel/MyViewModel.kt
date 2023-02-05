//package com.example.client.viewModel
//
//import android.app.AlertDialog
//import com.example.share.data.model.Item
//import android.content.Context
//import android.net.ConnectivityManager
//import android.net.NetworkCapabilities
//import android.util.Log
//import androidx.lifecycle.*
//import com.example.share.data.model.Category
//import com.example.share.persistance.repository.Repository
//import kotlinx.coroutines.delay
//import kotlinx.coroutines.flow.Flow
//import kotlinx.coroutines.launch
//
//private const val ERROR = "Error"
//private const val TRYING = "Trying"
//private const val SUCCESS = "Success"
//
//private const val DELAY_FOR_FLEXING_LOADING = 500L
//
//
//class MyViewModel(
//    private val repository: Repository,
//    private val context: Context
//): ViewModel(){
//
//    var syncedFirst = false
//    var syncedSecond = false
//
//
//    private val _isError: MutableLiveData<String?> = MutableLiveData()
//    val isError: LiveData<String?>
//        get() = _isError
//
//    private val _isSuccess: MutableLiveData<String?> = MutableLiveData()
//    val isSuccess: LiveData<String?>
//        get() = _isSuccess
//
//    private val _serverMessage: MutableLiveData<String?> = MutableLiveData()
//    val serverMessage: LiveData<String?>
//        get() = _serverMessage
//
//
//    fun setServerMessage(msg: String) {
//        _serverMessage.postValue(null)
//        _serverMessage.postValue(msg)
//        _serverMessage.postValue(null)
//    }
//
//    private val _isLoading: MutableLiveData<Boolean> = MutableLiveData()
//    val isLoading: LiveData<Boolean>
//        get() = _isLoading
//
//
//    val categoriesList: LiveData<MutableList<Category>> = repository.allCategories.asLiveData()
//    suspend fun getItemsByCategory(category: String): Flow<MutableList<Item>> = repository.getItemsByCategory(category)
//
//    fun syncFirst(){
//        viewModelScope.launch {
//            try{
//                Log.i(TRYING, "Trying to reach the server")
//                _isError.value = null
//                _isSuccess.value = null
//                _isLoading.value = true
//
//                delay(DELAY_FOR_FLEXING_LOADING)
//                if(!hasInternetConnection()){
//                    showDialog()
//                }
//
//                if(!syncedFirst){
//                    repository.syncFirst()
//                    syncedFirst = true
//                    _isSuccess.value = "Successfully synced data"
//                }
//            } catch (ex: Exception) {
//                _isError.value = ex.message
//                Log.e(ERROR, "Operation failed", ex)
//            } finally {
//                Log.i(SUCCESS, "Successfully reached the server")
//                _isLoading.value = false
//            }
//        }
//    }
//
//
//    private fun hasInternetConnection(): Boolean {
//        val connectivityManager =
//            context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
//        val network = connectivityManager.activeNetwork ?: return false
//        val activeNetwork = connectivityManager.getNetworkCapabilities(network) ?: return false
//
//        return when {
//            activeNetwork.hasTransport(NetworkCapabilities.TRANSPORT_WIFI) -> true
//            activeNetwork.hasTransport(NetworkCapabilities.TRANSPORT_CELLULAR) -> true
//            else -> false
//        }
//    }
//
//    private fun showDialog() {
//        AlertDialog.Builder(context).setTitle("No Internet Connection")
//            .setMessage("Fallback on local DB")
//            .setPositiveButton(android.R.string.ok) { _, _ -> }
//            .setIcon(android.R.drawable.ic_dialog_alert).show()
//    }
//
//}



package com.example.client.viewModel

import android.content.Context
import android.net.ConnectivityManager
import android.net.NetworkCapabilities
import android.util.Log
import android.widget.Toast
import androidx.lifecycle.*
import com.example.client.exception.NoInternetConnection
import com.example.share.data.model.Category
import com.example.share.persistance.repository.Repository
import kotlinx.coroutines.delay
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.launch

private const val ERROR = "Error"
private const val TRYING = "Trying"
private const val SUCCESS = "Success"

private const val DELAY_FOR_FLEXING_LOADING = 500L

class MyViewModel(
    private val repository: Repository,
    private val context: Context
) : ViewModel() {

    var synced = false
    var syncedSecond = false

    val objectsList: LiveData<List<Category>> = repository.allCategories.asLiveData()
//    fun objectsListSecond(year: Int): Flow<List<ObiectAn>> = repository.allObjectsSecond(year)

//    val objectsListStats: MutableLiveData<List<Obiect>> = MutableLiveData()

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


    fun syncStats() {
        viewModelScope.launch {
            try {
                Log.i(TRYING, "Trying to reach the sever")
                _isError.value = null
                _isSuccess.value = null
                _isLoading.value = true

                delay(DELAY_FOR_FLEXING_LOADING)
//                objectsListStats.value = repository.allObjectsStats()
            } catch (ex: Exception) {
                _isError.value = ex.message
                Log.e(ERROR, "Operation failed", ex)
            } finally {
                Log.i(SUCCESS, "Successfully reached the server")
                _isLoading.value = false
            }
        }
    }

    fun  sync() {
        viewModelScope.launch {
            try {
                Log.i(TRYING, "Trying to reach the sever")
                _isError.value = null
                _isSuccess.value = null
                _isLoading.value = true

                delay(DELAY_FOR_FLEXING_LOADING)
                if (!hasInternetConnection()) {
                    throw NoInternetConnection("No internet connection.")
                }
                if (!synced) {
//                    repository.sync()
                    synced = true
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

    fun syncSecond(attr: Int) {
        viewModelScope.launch {
            Log.i(TRYING, "Trying to reach the sever")
            _isError.value = null
            _isSuccess.value = null
            _isLoading.value = true

            delay(DELAY_FOR_FLEXING_LOADING)
            try {
                if (!syncedSecond) {
//                    repository.syncSecond(attr)
                    syncedSecond = true
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

//    fun addObiect(obiectDto: ObiectDto) {
//        viewModelScope.launch {
//            try {
//                Log.i(TRYING, "Trying to reach the sever")
//                _isError.value = null
//                _isSuccess.value = null
//
//                repository.insert(obiectDto)
//                _isSuccess.value = "Successfully inserted."
//            } catch (ex: Exception) {
//                _isError.value = "Something went wrong"
//                Log.e(ERROR, "Operation failed", ex)
//            } finally {
//                Log.i(SUCCESS, "Successfully reached the server")
//            }
//        }
//    }

    fun deleteObiect(id: Int) {
        viewModelScope.launch {
            try {
                Log.i(TRYING, "Trying to reach the sever")
                _isError.value = null
                _isSuccess.value = null

//                if(!hasInternetConnection()) {
//                    repository.delete(id)
//                    throw NoInternetConnection("No internet connection. Deleted only data on the phone.")
//                }
//                repository.delete(id)
//                repository.deleteRemote(id)
                _isSuccess.value = "Successfully deleted."
            } catch (ex: NoInternetConnection) {
                _isError.value = ex.message
                Log.e(ERROR, "No Internet connection", ex)
            } catch (ex: Exception) {
                _isError.value = "Something went wrong. Failed to delete."
                Log.e(ERROR, "Operation failed", ex)
            } finally {
                Log.i(SUCCESS, "Successfully reached the server")
            }
        }
    }

    fun hasInternetConnection(): Boolean {
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
}
