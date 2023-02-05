package com.example.client.viewModel.adapter

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.ListAdapter
import com.example.client.data.model.Item
import com.example.client.databinding.ItemCardItemBinding
import com.example.client.viewModel.utils.ItemEntityDiffUtilItemCallback
import com.example.client.viewModel.viewHolder.ItemsViewHolder


typealias onButtonClickItemListener = (itemId: Pair<Int, Int>) -> Unit

class ItemsAdapter(private val onButtonClickItemListener: onButtonClickItemListener):
    ListAdapter<Item, ItemsViewHolder>(ItemEntityDiffUtilItemCallback())
{
    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int) = ItemsViewHolder(
        ItemCardItemBinding.inflate(LayoutInflater.from(parent.context), parent, false),
        onButtonClickItemListener
    )

    override fun onBindViewHolder(holder: ItemsViewHolder, position: Int) {
        holder.bind(getItem(position))
    }
}