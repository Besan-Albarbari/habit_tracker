import 'package:flutter/material.dart';

class AddHabitButtom extends StatefulWidget{
   Function (String,Color) onHabitAdd;
   final String? editname;
   final Color?editColor;
  AddHabitButtom({
    super.key,
     required this.onHabitAdd,
     this.editColor,
     this.editname,
  });
  @override
  AddHabitButtomState createState() => AddHabitButtomState();

  }
  class AddHabitButtomState extends State<AddHabitButtom> {
    TextEditingController controller = TextEditingController();
   final List<Color> _avalibleColor=[
       Colors.blue,
    Colors.cyan,
    Colors.orange,
    Colors.green,
    Colors.pink,
    Colors.purple,
    ];
   Color _selectedColor=Colors.green;
   @override
   void initState(){
    super.initState();
    controller=TextEditingController(text: widget.editname??"");
    _selectedColor=widget.editColor??Colors.green;
   }

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }
    @override
  Widget build(BuildContext context) {
        return Padding(padding: EdgeInsets.only(
        top: 24,
        left: 24,
        right: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24, 
        // هي المسافة الجمالية الإضافية التي نتركها بين زر الحفظ وأعلى الكيبورد مباشرة، عشان ما يلزق الزر بالكيبورد.
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("اضافة عادة جديدة",  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
          SizedBox(height:16 ,),
          TextField(
            controller: controller,
            autofocus: true,
            decoration: InputDecoration(
              hintText: "مثلا : قراءة كتاب ،شرب 3 لتر ماء ",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              filled: true,
              fillColor: Colors.grey.shade100,
            ),
          ),
          SizedBox(
            height:46 ,
            child: ListView.builder(scrollDirection: Axis.horizontal,
              itemCount: _avalibleColor.length,
              itemBuilder:(context, index) {
                final color=_avalibleColor[index];
                final isSelected=_selectedColor==color;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedColor=color;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: isSelected ? Border.all(color: Colors.black,width: 3): null,
                    ),
                    child: isSelected ? Icon(Icons.check,color: Colors.white,size: 20,):null,
                  ),
                );
              }, )
            
          ),
          SizedBox(height: 20,),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(onPressed: (){
              if(controller.text.trim().isNotEmpty){
                widget.onHabitAdd(controller.text.trim(),_selectedColor);
                Navigator.pop(context);
              }
            },
             child: Text('حفظ العادة', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
          )

        ],
      ),
        );
  }
  }
 
  

 