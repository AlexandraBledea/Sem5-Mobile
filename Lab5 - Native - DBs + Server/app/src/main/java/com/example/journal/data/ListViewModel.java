package com.example.journal.data;

import androidx.lifecycle.MutableLiveData;
import androidx.lifecycle.ViewModel;

import com.example.journal.model.Story;

import java.util.List;

public class ListViewModel extends ViewModel {

    MutableLiveData<List<Story>> storiesLiveData;


    public ListViewModel() {
        storiesLiveData = new MutableLiveData<>();

    }

}
