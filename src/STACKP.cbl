       Identification Division.
       *> Copyright (C) 2022 Craig Schneiderwent, All rights reserved
       *> This software may be modified and distributed under the terms
       *> of the MIT license. See the LICENSE file for details.
       *> 
       *> Implementation of STACK functionality for fixed length
       *> items.
       *>
       *> See testing/src files for sample usage.
       *>
       *> If you detect Return-Code to be any of the 
       *> rc-stack-overflow* values it is strongly suggested that
       *> you Call STACKT and re-evaluate your coding choices.
       *>
       Program-ID. STACKP.
       Environment Division.
       Configuration Section.
       Repository.
          Function All Intrinsic.
       Data Division.
       Working-Storage Section.
       01  constants.
           05  myname                   PIC X(008) Value 'STACKP'.
           05  stack-items-increment    PIC 9(009)  Binary Value 10.
           05  rc-success               PIC S9(004) Binary Value +0.
           05  rc-stack-empty           PIC S9(004) Binary Value +4.
           05  rc-bad-func              PIC S9(004) Binary Value +8.
           05  rc-stack-overflow1       PIC S9(004) Binary Value +15.
           05  rc-stack-overflow2       PIC S9(004) Binary Value +16.
           05  rc-stack-overflow3       PIC S9(004) Binary Value +23.
           05  rc-stack-overflow4       PIC S9(004) Binary Value +42.
           
       Local-Storage Section.
       01  work-areas.
           05  new-stack-items-ptr      Pointer            Value NULL.
           05  new-stack-items-len      PIC 9(009) Binary  Value 0.
           05  new-stack-items-capacity PIC 9(009) Binary  Value 0.
           05  save-rc                  PIC S9(004) Binary Value +0.
           
       Linkage Section.
       01  ab-ptr                       Pointer.
       
       01  func                         PIC X(004).
           88  func-push                           Value 'PUSH'.
           88  func-peek                           Value 'PEEK'.
           88  func-pop                            Value 'POP '.
           
       01  stack-item.
           05  Occurs 1 To Unbounded 
               Depending stack-item-len
               PIC X(001).
               
       01  ab.
           05  stack-item-len           PIC 9(009) Binary.
           05  stack-items-len          PIC 9(009) Binary.
           05  stack-curr-nb-items      PIC 9(009) Binary.
           05  stack-items-capacity     PIC 9(009) Binary.
           05  stack-items-position     PIC 9(009) Binary.
           05  stack-items-ptr          Pointer.
           
       01  stack-items.
           05  Occurs 1 To Unbounded 
               Depending stack-items-len
               PIC X(001).
               
       01  new-stack-items.
           05  Occurs 1 To Unbounded 
               Depending new-stack-items-len
               PIC X(001).
               
       01  item-len                     PIC 9(009) Binary.
       
       01  nb-items                     PIC 9(009) Binary.
       
       Procedure Division Using
             ab-ptr
             func
             stack-item
           .
           
           Set Address Of ab To ab-ptr
           Set Address Of stack-items To stack-items-ptr
           Move rc-success To save-rc
           
           Evaluate True
             When func-push
                  Perform 1000-Push
             When func-peek
                  If stack-curr-nb-items = 0
                      Move rc-stack-empty To save-rc
                  Else
                      Perform 2000-Peek
                  End-If
             When func-pop
                  If stack-curr-nb-items = 0
                      Move rc-stack-empty To save-rc
                  Else
                      Perform 3000-Pop
                  End-If
             When Other
                  Move rc-bad-func To save-rc
           End-Evaluate
           
           Move save-rc To Return-Code
           Goback.
           
       1000-Push.
       *>  The stack grows down
           If Mod(stack-curr-nb-items, stack-items-capacity) = 0
             If stack-curr-nb-items > 0
               Perform 1010-Reallocate
             End-If
           End-If
           
           If stack-curr-nb-items = 0
               Move 1 To stack-items-position
           Else
               Add stack-item-len To stack-items-position
                 On Size Error Move rc-stack-overflow1 To save-rc
               End-Add
           End-If
           
           Add 1 To stack-curr-nb-items
             On Size Error Move rc-stack-overflow2 To save-rc
           End-Add
           
           Move stack-item 
             To stack-items(stack-items-position:stack-item-len)
           .
           
       1010-Reallocate.
           Compute new-stack-items-capacity =
             stack-items-capacity + stack-items-increment
             On Size Error Move rc-stack-overflow3 To save-rc
           End-Compute
             
           Compute new-stack-items-len = 
             stack-item-len * new-stack-items-capacity
             On Size Error Move rc-stack-overflow4 To save-rc
           End-Compute

           Allocate
             new-stack-items-len Characters
             Initialized
             Returning new-stack-items-ptr

           Set Address Of new-stack-items To new-stack-items-ptr
           
           Move stack-items              To new-stack-items
           Move new-stack-items-capacity To stack-items-capacity

           Free stack-items-ptr

           Move new-stack-items-ptr      To stack-items-ptr
           Move new-stack-items-len      To stack-items-len
           
           Set Address Of stack-items To stack-items-ptr
           .
           
       2000-Peek.
           Move stack-items(stack-items-position:stack-item-len)
             To stack-item
           .
           
       3000-Pop.
           Perform 2000-Peek

           Move Low-Values 
             To stack-items(stack-items-position:stack-item-len)

           Subtract 1 From stack-curr-nb-items

           If stack-curr-nb-items = 0
               Move 1 To stack-items-position
           Else
               Subtract stack-item-len From stack-items-position
           End-If
           .
           
