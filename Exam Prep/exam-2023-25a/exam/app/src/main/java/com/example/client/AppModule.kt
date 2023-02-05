package com.example.client

import com.example.client.client.ClientConfig
import com.example.client.persistance.database.MyRoomDatabase
import com.example.client.persistance.repository.Repository
import com.example.client.viewModel.MyViewModel
import org.koin.android.ext.koin.androidContext
import org.koin.androidx.viewmodel.dsl.viewModel
import org.koin.dsl.module


val viewModel = module { viewModel { MyViewModel(get(), get()) } }

val repository = module { single { Repository(get(), get()) } }

val dao = module { single { MyRoomDatabase.getDatabase(androidContext()).myDao() } }

val api = module { single { ClientConfig().provideApi() } }
