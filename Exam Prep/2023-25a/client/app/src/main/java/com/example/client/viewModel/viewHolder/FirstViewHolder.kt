package com.example.client.viewModel.viewHolder

import android.widget.ExpandableListView.OnChildClickListener
import androidx.recyclerview.widget.RecyclerView
import com.example.client.R
import com.example.client.databinding.CategoryCardItemBinding
import com.example.client.viewModel.adapter.onButtonClickItemListener
import com.example.share.data.model.Category

class FirstViewHolder(
    private val binding: CategoryCardItemBinding,
    private val onButtonClickListener: onButtonClickItemListener
): RecyclerView.ViewHolder(binding.root) {


    private var categoryType: String? = null

    init {
        binding.categoryID.setOnClickListener{
            categoryType?.let {type -> onButtonClickListener(Pair(type, SEE))}
        }
    }

    fun bind(category: Category){
        categoryType = category.category

        binding.categoryID.text = binding.root.context.getString(R.string.category, category.category)

    }

    companion object {
        const val SEE = 0
    }

}