package com.example.share

import androidx.navigation.ActionOnlyNavDirections
import androidx.navigation.NavDirections
import com.example.Examen19_2022.R

public class SecondFragmentDirections private constructor() {
  public companion object {
    public fun actionSecondFragmentToFirstFragment(): NavDirections =
        ActionOnlyNavDirections(R.id.action_SecondFragment_to_FirstFragment)
  }
}
