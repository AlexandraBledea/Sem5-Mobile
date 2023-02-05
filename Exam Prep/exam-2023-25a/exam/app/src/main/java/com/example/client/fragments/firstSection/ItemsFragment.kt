package com.example.client.fragments.firstSection

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.activity.OnBackPressedCallback
import androidx.core.view.isVisible
import androidx.fragment.app.Fragment
import androidx.lifecycle.asLiveData
import androidx.navigation.fragment.findNavController
import androidx.navigation.fragment.navArgs
import androidx.recyclerview.widget.LinearLayoutManager
import com.example.client.R
import com.example.client.databinding.ItemsListBinding
import com.example.client.viewModel.MyViewModel
import com.example.client.viewModel.adapter.ItemsAdapter
import com.example.client.viewModel.viewHolder.ItemsViewHolder.Companion.DELETE
import com.tapadoo.alerter.Alerter
import com.zhuinden.fragmentviewbindingdelegatekt.viewBinding
import org.koin.androidx.viewmodel.ext.android.activityViewModel


class ItemsFragment : Fragment(R.layout.items_list) {
    private val binding by viewBinding(ItemsListBinding::bind)
    private val myViewModel: MyViewModel by activityViewModel()
    private val adapter by lazy { initAdapter() }
    val args: ItemsFragmentArgs by navArgs()


    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        initRecyclerView(LinearLayoutManager(requireContext()))
        initObservers()
    }

    private fun initRecyclerView(layoutManager: LinearLayoutManager) {
        binding.itemList.adapter = adapter
        binding.itemList.layoutManager = layoutManager

        myViewModel.syncItemsByCategory(args.category)
    }

    private fun initObservers() {
        myViewModel.isLoading.observe(viewLifecycleOwner) { isLoading ->
            binding.isLoadingCIP.isVisible = isLoading
            binding.itemList.isVisible = !isLoading
        }

        myViewModel.itemsList(args.category).asLiveData()
            .observe(viewLifecycleOwner) { retrievedData ->
                adapter.submitList(retrievedData)
                adapter.notifyDataSetChanged()

            }

        myViewModel.isError.observe(viewLifecycleOwner) { isError ->
            if (isError != null) {
                Alerter.create(requireActivity())
                    .setTitle("Error")
                    .setText(isError.toString())
                    .setBackgroundColorRes(R.color.purple_v2).show()
            }
        }

        myViewModel.isSuccess.observe(viewLifecycleOwner) { isSuccess ->
            if (isSuccess != null) {
                Alerter.create(requireActivity())
                    .setTitle("Successful")
                    .setText(isSuccess.toString())
                    .setBackgroundColorRes(R.color.purple)
                    .show()
            }
        }

        myViewModel.serverMessage.observe(viewLifecycleOwner) { hasMessage ->
            if (!hasMessage.isNullOrEmpty()) {
                Alerter.create(requireActivity())
                    .setTitle("Message from server")
                    .setText(hasMessage.toString())
                    .setBackgroundColorRes(R.color.purple)
                    .show()
            }
        }
    }

    private fun onButtonClickListener(pair: Pair<Int, Int>) {
        if (pair.second == DELETE) {
//            myViewModel.deleteItemById(pair.first)
        }
    }

    private fun initAdapter(): ItemsAdapter = ItemsAdapter(::onButtonClickListener)


}