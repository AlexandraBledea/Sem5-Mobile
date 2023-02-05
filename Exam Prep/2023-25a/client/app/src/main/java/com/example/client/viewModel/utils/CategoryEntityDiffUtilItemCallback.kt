package com.example.client.viewModel.utils

import androidx.recyclerview.widget.DiffUtil
import com.example.share.data.model.Category

class CategoryEntityDiffUtilItemCallback : DiffUtil.ItemCallback<Category>() {
    override fun areItemsTheSame(oldItem: Category, newItem: Category) = oldItem == newItem

    override fun areContentsTheSame(oldItem: Category, newItem: Category) = oldItem == newItem
}
