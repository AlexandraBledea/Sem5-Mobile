package com.example.client.viewModel.adapter

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.ListAdapter
import androidx.recyclerview.widget.RecyclerView
import com.example.client.R
import com.example.client.databinding.CategoryCardItemBinding
import com.example.client.fragments.FirstFragment
import com.example.client.viewModel.utils.CategoryEntityDiffUtilItemCallback
import com.example.client.viewModel.viewHolder.FirstViewHolder
import com.example.share.data.model.Category

typealias onButtonClickItemListener = (itemId: Pair<String, Int>) -> Unit

class FirstAdapter(private val onButtonClickItemListener: onButtonClickItemListener) : ListAdapter<Category, FirstViewHolder>(CategoryEntityDiffUtilItemCallback()) {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int) = FirstViewHolder(
        CategoryCardItemBinding.inflate(LayoutInflater.from(parent.context), parent, false), onButtonClickItemListener)

    override fun onBindViewHolder(holder: FirstViewHolder, position: Int) {
        holder.bind(getItem(position))
    }

}