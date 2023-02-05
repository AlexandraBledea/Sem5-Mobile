package com.example.client.viewModel.adapter

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.ListAdapter
import com.example.client.databinding.CategoryCardItemBinding
import com.example.client.viewModel.utils.CategoryEntityDiffUtilItemCallback
import com.example.client.viewModel.viewHolder.CategoriesViewHolder
import com.example.client.data.model.Category

typealias onButtonClickCategoryListener = (itemId: Pair<String, Int>) -> Unit

class CategoriesAdapter(private val onButtonClickItemListener: onButtonClickCategoryListener) :
    ListAdapter<Category, CategoriesViewHolder>(CategoryEntityDiffUtilItemCallback()) {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int) = CategoriesViewHolder(
        CategoryCardItemBinding.inflate(LayoutInflater.from(parent.context), parent,
            false), onButtonClickItemListener)

    override fun onBindViewHolder(holder: CategoriesViewHolder, position: Int) {
        holder.bind(getItem(position))
    }

}