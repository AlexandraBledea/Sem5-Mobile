package com.example.journal.data

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.recyclerview.widget.LinearLayoutManager
import com.example.journal.R
import com.example.journal.adapter.ItemAdapter
import com.example.journal.model.Story
import kotlinx.android.synthetic.main.activity_list_notes.*
import org.threeten.bp.LocalDate
import org.threeten.bp.format.DateTimeFormatter

class ListViewActivity: AppCompatActivity() {
    private val stories = mutableListOf<Story>()


    override fun onCreate(savedInstanceState: Bundle?){
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_list_notes)

        supportActionBar?.hide()

        initStories()

        recyclerView.layoutManager = LinearLayoutManager(this)
        recyclerView.adapter = ItemAdapter(this, stories)

    }


    private fun initStories(){

        val formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy")

        val story1 = Story("Lola", "aaaaa", LocalDate.parse("03-04-1999", formatter), "Happy", "Some review...")
        val story2 = Story("Lola2", "aaaaa", LocalDate.parse("04-04-1999", formatter), "Sad", "Some review...")
        val story3 = Story("Lola3", "aaaaa", LocalDate.parse("05-04-1999", formatter), "Angry", "Some review...")
        val story4 = Story("Lola4", "aaaaa", LocalDate.parse("06-04-1999", formatter), "Anxious", "Some review...")
        val story5 = Story("Lola5", "aaaaa", LocalDate.parse("07-04-1999", formatter), "Neutral", "Some review...")
        val story6 = Story("Lola6", "aaaaa", LocalDate.parse("08-04-1999", formatter), "Ambitious", "Some review...")
        val story7 = Story("Lola7", "aaaaa", LocalDate.parse("09-04-1999", formatter), "Nervous", "Some review...")


        stories.add(story1)
        stories.add(story2)
        stories.add(story3)
        stories.add(story4)
        stories.add(story5)
        stories.add(story6)
        stories.add(story7)

    }
}