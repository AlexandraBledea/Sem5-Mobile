package com.example.client.fragments

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.View
import androidx.navigation.fragment.findNavController
import com.example.client.R
import okhttp3.OkHttpClient
import okhttp3.Request
import com.example.client.databinding.MainPageBinding
import com.example.client.client.WebSocket
import com.example.client.viewModel.MyViewModel
import com.zhuinden.fragmentviewbindingdelegatekt.viewBinding
import org.koin.androidx.viewmodel.ext.android.activityViewModel

import java.util.concurrent.TimeUnit


class MainPageFragment : Fragment(R.layout.main_page) {
    private val binding by viewBinding(MainPageBinding::bind)
    private val myViewModel: MyViewModel by activityViewModel()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
         myViewModel.nukeItemTable()
        OkHttpClient.Builder()
            .readTimeout(3, TimeUnit.SECONDS)
            .build()
            .newWebSocket(
                Request.Builder()
                    .url("ws://10.0.2.2:2325")
                    .build(), WebSocket(myViewModel)
            )
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        binding.mainSectionButton.setOnClickListener{
            findNavController().navigate(MainPageFragmentDirections.actionMainPageFragmentToFirstFragment())
        }

//        binding.priceSectionButton.setOnClickListener{
//            findNavController().navigate(MainPageFragmentDirections.actionMainFragmentToSecondFragment())
//        }

//        myViewModel.serverMessage.observe(viewLifecycleOwner) { hasMessage ->
//            if (!hasMessage.isNullOrEmpty()) {
//                Alerter.create(requireActivity())
//                    .setTitle("Message from server")
//                    .setText(hasMessage.toString())
//                    .setBackgroundColorRes(R.color.purple_500)
//                    .show()
//            }
//        }

    }

}