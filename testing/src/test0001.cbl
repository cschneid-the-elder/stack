       Identification Division.
       *>
       *> Copyright (C) 2022 Craig Schneiderwent, All rights reserved
       *> This software may be modified and distributed under the terms
       *> of the MIT license. See the LICENSE file for details.
       *> 
       Program-ID. test0001.
       Environment Division.
       Configuration Section.
       Repository.
          Function All Intrinsic.
       Data Division.
       Working-Storage Section.
       01  constants.
           05  myname                   PIC X(008) Value 'test0001'.
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
           05  stack-item               PIC X(008) Value Spaces.
           
       Procedure Division.
           Move Length(stack-item) to stack-item-len
           
           Call stack-init Using
             stack-ab-ptr
             stack-item-len
           End-Call
           
           Move 'Eli' to stack-item
           
           Call stack-process Using
             stack-ab-ptr
             stack-process-push
             stack-item
           End-Call
           
           If Return-Code Not = Zero
               Display
                 myname
                 ' Return-Code = ' Return-Code
                 ' after PUSH of ' stack-item
           End-If
           
           Call stack-num Using
             stack-ab-ptr
             stack-nb-items
           End-Call
           
           Display 'stack-nb-items = ' stack-nb-items
           
           Move 'Rush' to stack-item

           Call stack-process Using
             stack-ab-ptr
             stack-process-push
             stack-item
           End-Call
           
           If Return-Code Not = Zero
               Display
                 myname
                 ' Return-Code = ' Return-Code
                 ' after PUSH of ' stack-item
           End-If
           
           Call stack-num Using
             stack-ab-ptr
             stack-nb-items
           End-Call
           
           Display 'stack-nb-items = ' stack-nb-items
           
           Move Spaces to stack-item
           
           Call stack-process Using
             stack-ab-ptr
             stack-process-peek
             stack-item
           End-Call
           
           Display '(peek) stack-item = ' stack-item
           
           Move Spaces to stack-item
           
           Call stack-process Using
             stack-ab-ptr
             stack-process-pop
             stack-item
           End-Call
           
           Display '(pop) stack-item = ' stack-item
           
           Call stack-num Using
             stack-ab-ptr
             stack-nb-items
           End-Call
           
           Display 'stack-nb-items = ' stack-nb-items
           
           Move Spaces to stack-item
           
           Call stack-process Using
             stack-ab-ptr
             stack-process-peek
             stack-item
           End-Call
           
           Display '(peek) stack-item = ' stack-item
           
           Move Spaces to stack-item
           
           Call stack-process Using
             stack-ab-ptr
             stack-process-pop
             stack-item
           End-Call
           
           Display '(pop) stack-item = ' stack-item
           
           Call stack-num Using
             stack-ab-ptr
             stack-nb-items
           End-Call
           
           Display 'stack-nb-items = ' stack-nb-items
           
           Call stack-term Using
             stack-ab-ptr
           End-Call
           
           Goback.
           
