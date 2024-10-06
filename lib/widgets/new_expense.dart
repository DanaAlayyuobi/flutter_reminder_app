import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_reminder_app/models/expense.dart';
final formatter=DateFormat.yMd();

class NewExpense extends StatefulWidget{
  const NewExpense({required this.onAddExpence,super.key});

  final void Function(Expense expense) onAddExpence;
  @override
  State<StatefulWidget> createState() {
   return _NewExpenseState();
  }

}
class _NewExpenseState extends State<NewExpense>{
  final _titleController=TextEditingController();
  final _amountController=TextEditingController();
   DateTime? _selectedDate;
   Category1 _selectedCategory=Category1.leisure;

  void _PresentDatePicker() async{
    final now=DateTime.now();
    final firstDate =DateTime(now.year-1,now.month,now.day);
    final lastDate =DateTime(now.year+1,now.month,now.day);

    final pickedDate=await showDatePicker(
        context: context,
        initialDate:now,
        firstDate:firstDate ,
        lastDate: lastDate,
      );
   setState(() {
     _selectedDate=pickedDate;
   });
  }
  void _submitExpenseDate(){
   final enteredAmount= double.tryParse(
       _amountController.text);
   final amountIsInvalid=enteredAmount==null || enteredAmount<=0;
   if(_titleController.text.trim().isEmpty||
       amountIsInvalid||
       _selectedDate==null){
   showDialog(context: context
       , builder: (ctx)=>AlertDialog(
         title:const Text('Invalid input'),
         content: const Text('Please make sure the date and category was entered'),
         actions: [
           TextButton(
               onPressed: (){
                 Navigator.pop(ctx);
               },
               child: const Text('Okay'))
         ],
       ));
       return;
   }
   widget.onAddExpence(
       Expense(
           title: _titleController.text,
           amount: enteredAmount,
           date: _selectedDate!,
           category: _selectedCategory)
   );
   Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
   return Padding(
       padding:const EdgeInsets.fromLTRB(16,48,16,.16),
       child:Column(
       children:[
        TextField(
          controller: _titleController,
          maxLength:50 ,
          decoration:const InputDecoration(
            label:Text('title')
          ),
        ),
         Row(
           mainAxisAlignment: MainAxisAlignment.end,
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
             // Amount TextField on the left
             Expanded(
               child: TextField(
                 controller: _amountController,
                 keyboardType: TextInputType.number,
                 maxLength: 6,
                 decoration: const InputDecoration(
                   prefixText: '\$ ',
                   label: Text('Amount'),
                 ),
               ),
             ),

             const SizedBox(width: 100),

             Row(
               children: [
                  Text(
                      _selectedDate==null
                      ?'No Date Selected'
                      :formatter.format(_selectedDate!)
                  ),
                 IconButton(
                   onPressed: _PresentDatePicker,
                   icon: const Icon(Icons.calendar_month),
                 ),
               ],
             ),
           ],
         ),

        const SizedBox(height: 20,),
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             DropdownButton(
                value :_selectedCategory,
                 items:Category1.values.map(
                   (category)=>DropdownMenuItem(
                     value:category,
                   child: Text(category.name.toUpperCase(),),)
                   ,).toList(),
                 onChanged: (value){
                   print(value);
                   if (value==null)
                     return;
                   setState(() {
                     _selectedCategory=value;
                   });
                 },
             ),
             const Spacer(),
             ElevatedButton(
               onPressed: _submitExpenseDate,
               child: const Text("Save Expense"),
             ),
             ElevatedButton(
               onPressed: () {
                 Navigator.pop(context);
               },
               child: const Text("Cancel"),
             ),
           ],
         ),

       ],

   )
   );
  }
}