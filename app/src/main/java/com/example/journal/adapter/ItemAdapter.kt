package com.example.journal.adapter

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.example.journal.R
import com.example.journal.model.Story
import kotlinx.android.synthetic.main.list_item.view.*

class ItemAdapter(private val context: Context, private val dataset: MutableList<Story>): RecyclerView.Adapter<ItemAdapter.ItemViewHolder>() {

    inner class ItemViewHolder(view: View): RecyclerView.ViewHolder(view)

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ItemViewHolder {
        val adapterLayout = LayoutInflater.from(parent.context).inflate(R.layout.list_item, parent, false)
        return ItemViewHolder(adapterLayout)
    }

    override fun onBindViewHolder(holder: ItemViewHolder, position: Int) {
        val item = dataset[position]
        holder.itemView.apply {
            titleID.text = item.title;
            dateID.text = item.date.toString();
            emotionID.text = item.emotion;
        }

    }

    override fun getItemCount(): Int {
        return dataset.size
    }


}