       Identification Division.
       *>
       *> Copyright (C) 2022 Craig Schneiderwent, All rights reserved
       *> This software may be modified and distributed under the terms
       *> of the MIT license. See the LICENSE file for details.
       *> 
       Program-ID. test0003.
       Environment Division.
       Configuration Section.
       Repository.
          Function All Intrinsic.
       Data Division.
       Working-Storage Section.
       01  constants.
           05  myname                   PIC X(008) Value 'test0003'.
           05  stack-init               PIC X(008) Value 'STACKI'.
           05  stack-term               PIC X(008) Value 'STACKT'.
           05  stack-process            PIC X(008) Value 'STACKP'.
           05  stack-num                PIC X(008) Value 'STACKN'.
           05  stack-process-push       PIC X(004) Value 'PUSH'.
           05  stack-process-pop        PIC X(004) Value 'POP '.
           05  stack-process-peek       PIC X(004) Value 'PEEK'.
           
       01  work-areas.
           05  stack-ab-ptr1            Pointer    Value NULL.
           05  stack-nb-items1          PIC 9(009) Binary Value 0.
           05  stack-item-len1          PIC 9(009) Binary Value 0.
           05  stack-ab-ptr2            Pointer    Value NULL.
           05  stack-nb-items2          PIC 9(009) Binary Value 0.
           05  stack-item-len2          PIC 9(009) Binary Value 0.
           05  stack-ab-ptr3            Pointer    Value NULL.
           05  stack-nb-items3          PIC 9(009) Binary Value 0.
           05  stack-item-len3          PIC 9(009) Binary Value 0.
           05  test-tbl-idx             PIC 9(009) Binary Value 0.
           05  test-nb-1                PIC 9(009) Binary Value 0.
           05  stack-item1              PIC X(006) Value Spaces.
           05  stack-item2              PIC X(008) Value Spaces.
           05  stack-item3              PIC X(005) Value Spaces.
           05  save-rc                  PIC S9(004) Value +0.
           
       01  test-areas.
           05  test-data1.
               10                       PIC X(006) Value 'Eli'.
               10                       PIC 9(009) Binary Value 1.
               10                       PIC X(006) Value 'Park'.
               10                       PIC 9(009) Binary Value 2.
               10                       PIC X(006) Value 'Brody'.
               10                       PIC 9(009) Binary Value 3.
               10                       PIC X(006) Value 'Volker'.
               10                       PIC 9(009) Binary Value 4.
               10                       PIC X(006) Value 'Rush'.
               10                       PIC 9(009) Binary Value 5.
           05  Redefines test-data1.
               10  test-tbl1 Occurs 5.
                   15  test-name1       PIC X(006).
                   15  test-nb1         PIC 9(009) Binary.
           05  test-data2.
               10                       PIC X(008) Value 'Johansen'.
               10                       PIC 9(009) Binary Value 1.
               10                       PIC X(008) Value 'Greer'.
               10                       PIC 9(009) Binary Value 2.
               10                       PIC X(008) Value 'Young'.
               10                       PIC 9(009) Binary Value 3.
               10                       PIC X(008) Value 'Scott'.
               10                       PIC 9(009) Binary Value 4.
               10                       PIC X(008) Value 'James'.
               10                       PIC 9(009) Binary Value 5.
               10                       PIC X(008) Value 'Telford'.
               10                       PIC 9(009) Binary Value 6.
               10                       PIC X(008) Value 'Riley'.
               10                       PIC 9(009) Binary Value 7.
           05  Redefines test-data2.
               10  test-tbl2 Occurs 7.
                   15  test-name2       PIC X(008).
                   15  test-nb2         PIC 9(009) Binary.
           05  test-data3.
               10                       PIC X(005) Value 'Varro'.
               10                       PIC 9(009) Binary Value 1.
               10                       PIC X(005) Value 'Ginn'.
               10                       PIC 9(009) Binary Value 2.
               10                       PIC X(005) Value 'Kiva'.
               10                       PIC 9(009) Binary Value 3.
           05  Redefines test-data3.
               10  test-tbl3 Occurs 3.
                   15  test-name3       PIC X(005).
                   15  test-nb3         PIC 9(009) Binary.

       Procedure Division.
           Move Length(stack-item1) to stack-item-len1
           
           Call stack-init Using
             stack-ab-ptr1
             stack-item-len1
           End-Call
           
           Move Length(stack-item2) to stack-item-len2
           
           Call stack-init Using
             stack-ab-ptr2
             stack-item-len2
           End-Call
           
           Move Length(stack-item3) to stack-item-len3
           
           Call stack-init Using
             stack-ab-ptr3
             stack-item-len3
           End-Call
           
           Perform 1000-test-0001
             Varying test-tbl-idx
             From 1 By 1 Until test-tbl-idx > 5
             
           Perform 2000-test-0001
             Varying test-tbl-idx
             From 1 By 1 Until test-tbl-idx > 7
             
           Perform 3000-test-0001
             Varying test-tbl-idx
             From 1 By 1 Until test-tbl-idx > 3
             
           Perform 1100-test-0002
             Varying test-tbl-idx
             From 5 By -1 Until test-tbl-idx = 0

           Call stack-process Using
             stack-ab-ptr1
             stack-process-peek
             stack-item1
           End-Call

           If Return-Code = 4
               Display 
                 '(peek) empty stack Return-Code = ' 
                 Return-Code 
                 ' pass'
           Else
               Display 
                 '(peek) empty stack Return-Code = '
                 Return-Code
                 ' fail'
               Move +12 To save-rc
           End-If
           
           Perform 2100-test-0002
             Varying test-tbl-idx
             From 7 By -1 Until test-tbl-idx = 0

           Call stack-process Using
             stack-ab-ptr2
             stack-process-peek
             stack-item2
           End-Call

           If Return-Code = 4
               Display 
                 '(peek) empty stack Return-Code = ' 
                 Return-Code 
                 ' pass'
           Else
               Display 
                 '(peek) empty stack Return-Code = '
                 Return-Code
                 ' fail'
               Move +12 To save-rc
           End-If
           
           Perform 3100-test-0002
             Varying test-tbl-idx
             From 3 By -1 Until test-tbl-idx = 0

           Call stack-process Using
             stack-ab-ptr3
             stack-process-peek
             stack-item3
           End-Call

           If Return-Code = 4
               Display 
                 '(peek) empty stack Return-Code = ' 
                 Return-Code 
                 ' pass'
           Else
               Display 
                 '(peek) empty stack Return-Code = '
                 Return-Code
                 ' fail'
               Move +12 To save-rc
           End-If
           
           If save-rc Not = 0
               Display myname ' FAIL'
           End-If
           Move save-rc To Return-Code
           Goback.
                      
       1000-test-0001.
           Initialize stack-item1 stack-nb-items1
           
           Move test-name1(test-tbl-idx) To stack-item1
           
           Call stack-process Using
             stack-ab-ptr1
             stack-process-push
             stack-item1
           End-Call
           
           Initialize stack-item1
           
           Call stack-process Using
             stack-ab-ptr1
             stack-process-peek
             stack-item1
           End-Call

           If stack-item1 = test-name1(test-tbl-idx)
               Display '(peek) stack-item = ' stack-item1 ' pass'
           Else
               Display 
                 '(peek) stack-item = ' 
                 stack-item1 
                 ' fail should be ' 
                 test-name1(test-tbl-idx)
               Move +12 To save-rc
           End-If

           Call stack-num Using
             stack-ab-ptr1
             stack-nb-items1
           End-Call
           
           If stack-nb-items1 = test-nb1(test-tbl-idx)
               Display 'stack-nb-items = ' stack-nb-items1 ' pass'
           Else
               Display 
                 'stack-nb-items = ' 
                 stack-nb-items1 
                 ' fail should be ' 
                 test-nb1(test-tbl-idx)
               Move +12 To save-rc
           End-If
           .
           
       1100-test-0002.
           Initialize stack-item1 stack-nb-items1
           
           Call stack-process Using
             stack-ab-ptr1
             stack-process-pop
             stack-item1
           End-Call
           
           If stack-item1 = test-name1(test-tbl-idx)
               Display '(pop) stack-item = ' stack-item1 ' pass'
           Else
               Display 
                 '(pop) stack-item = ' 
                 stack-item1 
                 ' fail should be ' 
                 test-name1(test-tbl-idx)
               Move +12 To save-rc
           End-If

           Call stack-num Using
             stack-ab-ptr1
             stack-nb-items1
           End-Call
           
           Compute test-nb-1 = test-nb1(test-tbl-idx) - 1

           If stack-nb-items1 = test-nb-1
               Display 'stack-nb-items = ' stack-nb-items1 ' pass'
           Else
               Display 
                 'stack-nb-items = ' 
                 stack-nb-items1 
                 ' fail should be ' 
                 test-nb-1
               Move +12 To save-rc
           End-If
           .
           
       2000-test-0001.
           Initialize stack-item2 stack-nb-items2
           
           Move test-name2(test-tbl-idx) To stack-item2
           
           Call stack-process Using
             stack-ab-ptr2
             stack-process-push
             stack-item2
           End-Call
           
           Initialize stack-item2
           
           Call stack-process Using
             stack-ab-ptr2
             stack-process-peek
             stack-item2
           End-Call

           If stack-item2 = test-name2(test-tbl-idx)
               Display '(peek) stack-item = ' stack-item2 ' pass'
           Else
               Display 
                 '(peek) stack-item = ' 
                 stack-item2 
                 ' fail should be ' 
                 test-name2(test-tbl-idx)
               Move +12 To save-rc
           End-If

           Call stack-num Using
             stack-ab-ptr2
             stack-nb-items2
           End-Call
           
           If stack-nb-items2 = test-nb2(test-tbl-idx)
               Display 'stack-nb-items = ' stack-nb-items2 ' pass'
           Else
               Display 
                 'stack-nb-items = ' 
                 stack-nb-items2 
                 ' fail should be ' 
                 test-nb2(test-tbl-idx)
               Move +12 To save-rc
           End-If
           .
           
       2100-test-0002.
           Initialize stack-item2 stack-nb-items2
           
           Call stack-process Using
             stack-ab-ptr2
             stack-process-pop
             stack-item2
           End-Call
           
           If stack-item2 = test-name2(test-tbl-idx)
               Display '(pop) stack-item = ' stack-item2 ' pass'
           Else
               Display 
                 '(pop) stack-item = ' 
                 stack-item2 
                 ' fail should be ' 
                 test-name2(test-tbl-idx)
               Move +12 To save-rc
           End-If

           Call stack-num Using
             stack-ab-ptr2
             stack-nb-items2
           End-Call
           
           Compute test-nb-1 = test-nb2(test-tbl-idx) - 1

           If stack-nb-items2 = test-nb-1
               Display 'stack-nb-items = ' stack-nb-items2 ' pass'
           Else
               Display 
                 'stack-nb-items = ' 
                 stack-nb-items2 
                 ' fail should be ' 
                 test-nb-1
               Move +12 To save-rc
           End-If
           .
           
       3000-test-0001.
           Initialize stack-item3 stack-nb-items3
           
           Move test-name3(test-tbl-idx) To stack-item3
           
           Call stack-process Using
             stack-ab-ptr3
             stack-process-push
             stack-item3
           End-Call
           
           Initialize stack-item3
           
           Call stack-process Using
             stack-ab-ptr3
             stack-process-peek
             stack-item3
           End-Call

           If stack-item3 = test-name3(test-tbl-idx)
               Display '(peek) stack-item = ' stack-item3 ' pass'
           Else
               Display 
                 '(peek) stack-item = ' 
                 stack-item3 
                 ' fail should be ' 
                 test-name3(test-tbl-idx)
               Move +12 To save-rc
           End-If

           Call stack-num Using
             stack-ab-ptr3
             stack-nb-items3
           End-Call
           
           If stack-nb-items3 = test-nb3(test-tbl-idx)
               Display 'stack-nb-items = ' stack-nb-items3 ' pass'
           Else
               Display 
                 'stack-nb-items = ' 
                 stack-nb-items3 
                 ' fail should be ' 
                 test-nb3(test-tbl-idx)
               Move +12 To save-rc
           End-If
           .
           
       3100-test-0002.
           Initialize stack-item3 stack-nb-items3
           
           Call stack-process Using
             stack-ab-ptr3
             stack-process-pop
             stack-item3
           End-Call
           
           If stack-item3 = test-name3(test-tbl-idx)
               Display '(pop) stack-item = ' stack-item3 ' pass'
           Else
               Display 
                 '(pop) stack-item = ' 
                 stack-item3 
                 ' fail should be ' 
                 test-name3(test-tbl-idx)
               Move +12 To save-rc
           End-If

           Call stack-num Using
             stack-ab-ptr3
             stack-nb-items3
           End-Call
           
           Compute test-nb-1 = test-nb3(test-tbl-idx) - 1

           If stack-nb-items3 = test-nb-1
               Display 'stack-nb-items = ' stack-nb-items3 ' pass'
           Else
               Display 
                 'stack-nb-items = ' 
                 stack-nb-items3 
                 ' fail should be ' 
                 test-nb-1
               Move +12 To save-rc
           End-If
           .
           

