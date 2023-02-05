package com.example.client.viewModel.utils

import androidx.recyclerview.widget.DiffUtil
import com.example.client.data.model.Category
import com.example.client.data.model.Item

class ItemEntityDiffUtilItemCallback: DiffUtil.ItemCallback<Item>() {
    override fun areItemsTheSame(oldItem: Item, newItem: Item) = oldItem == newItem

    override fun areContentsTheSame(oldItem: Item, newItem: Item) = oldItem == newItem
}