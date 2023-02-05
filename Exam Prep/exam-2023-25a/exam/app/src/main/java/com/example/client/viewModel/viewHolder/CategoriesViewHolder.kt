package com.example.client.viewModel.viewHolder

import androidx.recyclerview.widget.RecyclerView
import com.example.client.R
import com.example.client.databinding.CategoryCardItemBinding
import com.example.client.viewModel.adapter.onButtonClickCategoryListener
import com.example.client.data.model.Category

class CategoriesViewHolder(
    private val binding: CategoryCardItemBinding,
    private val onButtonClickListener: onButtonClickCategoryListener
): RecyclerView.ViewHolder(binding.root) {


    private var categoryType: String? = null

    init {
        binding.categoryID.setOnClickListener{
            categoryType?.let {type -> onButtonClickListener(Pair(type, SEE))}
        }
    }

    fun bind(category: Category){
        categoryType = category.category
        binding.categoryID.text = binding.root.context.getString(R.string.category_format, category.category)

    }

    companion object {
        const val SEE = 0
    }

}