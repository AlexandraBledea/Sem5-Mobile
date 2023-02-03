package com.example.client

import com.example.share.client.ClientConfig
import com.example.share.persistance.database.MyRoomDatabase
import com.example.share.persistance.repository.Repository
import org.koin.android.ext.koin.androidContext
import org.koin.androidx.viewmodel.dsl.viewModel
import org.koin.core.scope.get
import org.koin.dsl.module


val repository = module { single { Repository(get()) } }

val dao = module { single { MyRoomDatabase.getDatabase(androidContext()).myDao() } }

val api = module { single { ClientConfig().provideApi() } }
