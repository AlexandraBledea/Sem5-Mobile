package com.example.client.fragments.firstSection


import android.os.Bundle
import android.view.View
import androidx.activity.OnBackPressedCallback
import androidx.activity.OnBackPressedDispatcher
import androidx.core.view.isVisible
import androidx.fragment.app.Fragment
import androidx.lifecycle.asLiveData
import androidx.navigation.fragment.findNavController
import androidx.recyclerview.widget.LinearLayoutManager
import com.example.client.R
import com.example.client.databinding.CategoriesListBinding
import com.example.client.viewModel.MyViewModel
import com.example.client.viewModel.adapter.CategoriesAdapter
import com.example.client.viewModel.viewHolder.CategoriesViewHolder.Companion.SEE
import com.tapadoo.alerter.Alerter
import com.zhuinden.fragmentviewbindingdelegatekt.viewBinding
import kotlinx.coroutines.flow.asFlow
import org.koin.androidx.viewmodel.ext.android.activityViewModel


class FirstFragment : Fragment(R.layout.categories_list) {
    private val binding by viewBinding(CategoriesListBinding::bind)
    private val myViewModel: MyViewModel by activityViewModel()
    private val adapter by lazy { initAdapter() }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        initRecyclerView(LinearLayoutManager(requireContext()))
        initObservers()
    }

    private fun initRecyclerView(layoutManager: LinearLayoutManager) {
        binding.categoriesList.adapter = adapter
        binding.categoriesList.layoutManager = layoutManager


        myViewModel.syncFirst()
    }

    private fun initObservers() {
        myViewModel.isLoading.observe(viewLifecycleOwner) { isLoading ->
            binding.isLoadingCIP.isVisible = isLoading
            binding.categoriesList.isVisible = !isLoading
        }

        myViewModel.categoriesList.observe(viewLifecycleOwner) { retrievedData ->
            adapter.submitList(retrievedData)
            adapter.notifyDataSetChanged()
        }

        myViewModel.isError.observe(viewLifecycleOwner) { isError ->
            if (isError != null) {
                Alerter.create(requireActivity())
                    .setTitle("Error")
                    .setText(isError.toString())
                    .setOnClickListener { myViewModel.syncFirst() }
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

    private fun onButtonClickListener(pair: Pair<String, Int>) {
        if (pair.second == SEE) {
            findNavController().navigate(FirstFragmentDirections.actionFirstFragmentToItemsFragment(pair.first))
        }
    }

    private fun initAdapter(): CategoriesAdapter = CategoriesAdapter(::onButtonClickListener)
}