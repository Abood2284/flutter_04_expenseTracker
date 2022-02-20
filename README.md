# flutter_04_expenseTracker

Expense tracker app created with help of udemy course section 4 + 5 + 6

# How a new Flutter Dev can benifit

This app was created for educational and learning purposes it has all the basics a flutter beginner will needs in it journey.
With that said it also has docs commenting explaining the hard and important concept of Flutter & Dart with that it also gives you an idea of how the data is passed in the flutter app

# How to contribute to this project

1. First Fork this repo
2. Create a branch(better if you name it same as your new_feature name) and checkout it
3. Make your desired changes
4. Commit and push
5. Wait for your Pull request to get merged


# File Structure
- lib
- |
- |--main.dart -> Holds the main Structure and body of the app
- |
- |--widgets/
-           |--adaptive_flat_button.dart  -> Holds the common flat button for both platforms used in new_transaction file
-           |--chart_bar.dart ->  Holds the chart bar with additional information about amount spend and weekdays
-           |--chart.dart -> Generates 7 chat_bar dynamically based on weekdays available
-           |--new_transaction.dart -> Adds a new transaction to the transaction list
-           |--transaction_item.dart -> holds the card which displays the single transaction
-           |--transaction_list.dart -> Responsible for dynamically generating transaaction lists via constructor of transacitem
- 
- |--models/
-           |--chartDetails.dart -> Holds the model/skeleton of what to be added in our chart
-           |--transaction.dart -> Holds the skeleton of each transaction
# What I learned from this Module

### Flutter Fundamentals

- Compose UI from built-in and custom Widgets
- Custom Widgets are also composed from built-in and other custom Widgets
- Style and configure via arguments
- Use the Docs & IDE support!

### Styling and configuring Widgets

- Styling & Layout options are very different: EdgeInsets.all(), BoxDecoration(), enums, .... Docs + IDE support help you
- Often, there's more than one Widget or option to get the job done

### Theming

- Define a Global theme for colors and text to then tap into it from anywhere in the app via Theme.of(context)
- Built-in Widgets use theme settings automatically

### Business Logic

- Lift state up and use stateful Widgets only when needed
- Pass functions references and data around
- Adjust the UI to your logic

# Images of the app

![alt](https://github.com/Abood2284/Images/blob/main/flutter_04_expenseTracker/1.png)
![alt](https://github.com/Abood2284/Images/blob/main/flutter_04_expenseTracker/2.png)
![alt](https://github.com/Abood2284/Images/blob/main/flutter_04_expenseTracker/3.png)
