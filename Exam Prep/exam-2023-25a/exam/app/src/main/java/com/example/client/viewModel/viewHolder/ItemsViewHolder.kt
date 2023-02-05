package com.example.client.viewModel.viewHolder

import androidx.recyclerview.widget.RecyclerView
import com.example.client.R
import com.example.client.data.model.Item
import com.example.client.databinding.ItemCardItemBinding
import com.example.client.viewModel.adapter.onButtonClickItemListener

class ItemsViewHolder(private val binding: ItemCardItemBinding,
                      private val onButtonClickItemListener: onButtonClickItemListener
):
    RecyclerView.ViewHolder(binding.root){

    private var itemId: Int? = null

    init {
        binding.deleteButton.setOnClickListener{
            itemId?.let { itemId -> onButtonClickItemListener(Pair(itemId, DELETE)) }
        }
    }

    fun bind(item: Item){
        itemId = item.id

        binding.nameID.text =
            binding.root.context.getString(R.string.name_format, item.name)

        binding.descriptionID.text =
            binding.root.context.getString(R.string.description_format, item.description)

        binding.imageId.text =
            binding.root.context.getString(R.string.image_format, item.image)

        binding.categoryItemID.text =
            binding.root.context.getString(R.string.category_format, item.category)

        binding.unitID.text =
            binding.root.context.getString(R.string.units_format, item.units)

        binding.priceID.text =
            binding.root.context.getString(R.string.price_format, item.price)


    }

    companion object {
        const val DELETE = 0
    }

}