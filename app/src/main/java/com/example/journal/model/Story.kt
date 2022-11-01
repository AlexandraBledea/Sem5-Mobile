package com.example.journal.model

import android.os.Parcelable
import kotlinx.android.parcel.Parcelize

@Parcelize
data class Story(
    val title: String, val text: String, val date: org.threeten.bp.LocalDate,
    val emotion: String, val motivationalMessage: String): Parcelable {
}