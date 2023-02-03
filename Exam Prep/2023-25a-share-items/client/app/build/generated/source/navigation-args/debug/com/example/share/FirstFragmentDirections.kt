package com.example.share

import androidx.navigation.ActionOnlyNavDirections
import androidx.navigation.NavDirections
import com.example.Examen19_2022.R

public class FirstFragmentDirections private constructor() {
  public companion object {
    public fun actionFirstFragmentToSecondFragment(): NavDirections =
        ActionOnlyNavDirections(R.id.action_FirstFragment_to_SecondFragment)
  }
}
