       Identification Division.
       *>
       *> Copyright (C) 2022 Craig Schneiderwent, All rights reserved
       *> This software may be modified and distributed under the terms
       *> of the MIT license. See the LICENSE file for details.
       *> 
       Program-ID. test0002.
       Environment Division.
       Configuration Section.
       Repository.
          Function All Intrinsic.
       Data Division.
       Working-Storage Section.
       01  constants.
           05  myname                   PIC X(008) Value 'test0002'.
           05  stack-init               PIC X(008) Value 'STACKI'.
           05  stack-term               PIC X(008) Value 'STACKT'.
           05  stack-process            PIC X(008) Value 'STACKP'.
           05  stack-num                PIC X(008) Value 'STACKN'.
           05  stack-process-push       PIC X(004) Value 'PUSH'.
           05  stack-process-pop        PIC X(004) Value 'POP '.
           05  stack-process-peek       PIC X(004) Value 'PEEK'.
           
       01  work-areas.
           05  stack-ab-ptr             Pointer    Value NULL.
           05  stack-nb-items           PIC 9(009) Binary Value 0.
           05  stack-item-len           PIC 9(009) Binary Value 0.
           05  test-tbl-idx             PIC 9(009) Binary Value 0.
           05  test-nb-1                PIC 9(009) Binary Value 0.
           05  stack-item               PIC X(008) Value Spaces.
           05  save-rc                  PIC S9(004) Value +0.
           
       01  test-areas.
           05  test-data.
               10                       PIC X(008) Value 'Eli'.
               10                       PIC 9(009) Binary Value 1.
               10                       PIC X(008) Value 'Park'.
               10                       PIC 9(009) Binary Value 2.
               10                       PIC X(008) Value 'Brody'.
               10                       PIC 9(009) Binary Value 3.
               10                       PIC X(008) Value 'Volker'.
               10                       PIC 9(009) Binary Value 4.
               10                       PIC X(008) Value 'Johansen'.
               10                       PIC 9(009) Binary Value 5.
               10                       PIC X(008) Value 'Greer'.
               10                       PIC 9(009) Binary Value 6.
               10                       PIC X(008) Value 'Young'.
               10                       PIC 9(009) Binary Value 7.
               10                       PIC X(008) Value 'Wray'.
               10                       PIC 9(009) Binary Value 8.
               10                       PIC X(008) Value 'Scott'.
               10                       PIC 9(009) Binary Value 9.
               10                       PIC X(008) Value 'Chloe'.
               10                       PIC 9(009) Binary Value 10.
               10                       PIC X(008) Value 'James'.
               10                       PIC 9(009) Binary Value 11.
               10                       PIC X(008) Value 'Telford'.
               10                       PIC 9(009) Binary Value 12.
               10                       PIC X(008) Value 'Riley'.
               10                       PIC 9(009) Binary Value 13.
               10                       PIC X(008) Value 'Varro'.
               10                       PIC 9(009) Binary Value 14.
               10                       PIC X(008) Value 'Ginn'.
               10                       PIC 9(009) Binary Value 15.
           05  Redefines test-data.
               10  test-tbl Occurs 15.
                   15  test-name        PIC X(008).
                   15  test-nb          PIC 9(009) Binary.

       Procedure Division.
           Move Length(stack-item) to stack-item-len
           
           Call stack-init Using
             stack-ab-ptr
             stack-item-len
           End-Call
           
           Perform 1000-test-0001
             Varying test-tbl-idx
             From 1 By 1 Until test-tbl-idx > 15
             
           Perform 1100-test-0002
             Varying test-tbl-idx
             From 15 By -1 Until test-tbl-idx = 0

           Call stack-process Using
             stack-ab-ptr
             stack-process-peek
             stack-item
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
           
           Call stack-process Using
             stack-ab-ptr
             stack-process-pop
             stack-item
           End-Call

           If Return-Code = 4
               Display 
                 '(pop) empty stack Return-Code = ' 
                 Return-Code 
                 ' pass'
           Else
               Display 
                 '(pop) empty stack Return-Code = '
                 Return-Code
                 ' fail'
               Move +12 To save-rc
           End-If
           
           Perform 1000-test-0001
             Varying test-tbl-idx
             From 1 By 1 Until test-tbl-idx > 5
             
           Perform 1100-test-0002
             Varying test-tbl-idx
             From 5 By -1 Until test-tbl-idx = 3
             
           Perform 1000-test-0001
             Varying test-tbl-idx
             From 4 By 1 Until test-tbl-idx > 15
             
           Perform 1100-test-0002
             Varying test-tbl-idx
             From 15 By -1 Until test-tbl-idx = 0
             
           Move save-rc To Return-Code
           Display myname ' exiting Return-Code = ' Return-Code
           Goback.
                      
       1000-test-0001.
           Initialize stack-item stack-nb-items
           
           Move test-name(test-tbl-idx) To stack-item
           
           Call stack-process Using
             stack-ab-ptr
             stack-process-push
             stack-item
           End-Call
           
           Initialize stack-item
           
           Call stack-process Using
             stack-ab-ptr
             stack-process-peek
             stack-item
           End-Call

           If stack-item = test-name(test-tbl-idx)
               Display '(peek) stack-item = ' stack-item ' pass'
           Else
               Display 
                 '(peek) stack-item = ' 
                 stack-item 
                 ' fail should be ' 
                 test-name(test-tbl-idx)
               Move +12 To save-rc
           End-If

           Call stack-num Using
             stack-ab-ptr
             stack-nb-items
           End-Call
           
           If stack-nb-items = test-nb(test-tbl-idx)
               Display 'stack-nb-items = ' stack-nb-items ' pass'
           Else
               Display 
                 'stack-nb-items = ' 
                 stack-nb-items 
                 ' fail should be ' 
                 test-nb(test-tbl-idx)
               Move +12 To save-rc
           End-If
           .
           
       1100-test-0002.
           Initialize stack-item stack-nb-items
           
           Call stack-process Using
             stack-ab-ptr
             stack-process-pop
             stack-item
           End-Call
           
           If stack-item = test-name(test-tbl-idx)
               Display '(pop) stack-item = ' stack-item ' pass'
           Else
               Display 
                 '(pop) stack-item = ' 
                 stack-item 
                 ' fail should be ' 
                 test-name(test-tbl-idx)
               Move +12 To save-rc
           End-If

           Call stack-num Using
             stack-ab-ptr
             stack-nb-items
           End-Call
           
           Compute test-nb-1 = test-nb(test-tbl-idx) - 1

           If stack-nb-items = test-nb-1
               Display 'stack-nb-items = ' stack-nb-items ' pass'
           Else
               Display 
                 'stack-nb-items = ' 
                 stack-nb-items 
                 ' fail should be ' 
                 test-nb-1
               Move +12 To save-rc
           End-If
           .
           

