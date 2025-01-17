Hello, 

This is my submission for assignment 1 and 2. 

## Assign 1:

I represented blood type as an enum of blood types. There are functions that return the blood 
types that patient can receive and give.

I represented Medicatins as a struct that holds all the information required. There is also a function that
checks if the medications is still in use by the patient based on the date it was perscribed 
and how long it was perscribed for

I represented Patient also as a atruct that contains all the required informantion and methods.

All three types have the CustomStringConvertible protocol and they all have thorough test coverage. 


## Assign 2:

- I created a viewModel class that contains the patients list and is @observable. This is the ground truth list that is used and displayed in all other views.
- I created a patientListView that lists the patients in aplphabetical order and has a search bar to search for patients based on their last name and also has an add patient button
- the add patient button takes you to the addPatient view which is a form where you fill out patient info and add the noew patient to the patients list
- then when you click on a patient it take you to the patient Details view which shows the details of a patient and has the add medication button
- the add medication button takes you to the addMedication view where you fill out details for a medication and perscribe it to a patient. The medications that a patient has perscribed are displayed in the patiend details view
- I also wrote UI tests to test UI functionality






