package com.example.journal.model

import android.os.Parcelable
import kotlinx.android.parcel.Parcelize

@Parcelize
data class Story(
    val id: Int,
    var title: String, var text: String, var date: org.threeten.bp.LocalDate,
    var emotion: String, var motivationalMessage: String): Parcelable {
}