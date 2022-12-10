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
       *> Note that if the stack is empty both PEEK and POP
       *> functions leave the contents of the output stack-item
       *> unchanged.
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
           *>  Eyecatcher.
           05  myname                   PIC X(008) Value 'STACKP'.
           *>  The stack grows downward in increments of 
           *>  stack-item-len * stack-items-increment.  The number
           *>  10 is arbitrary.
           05  stack-items-increment    PIC 9(009)  Binary Value 10.
           *>  Return code indicating success.
           05  rc-success               PIC S9(004) Binary Value +0.
           *>  Return code indicating the stack is empty.
           05  rc-stack-empty           PIC S9(004) Binary Value +4.
           *>  Return code indicating an unknown function was requested.
           05  rc-bad-func              PIC S9(004) Binary Value +8.
           *>  Return codes indicating at least one of the integers
           *>  involved in managing the stack would have overflowed.
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
       *>  Input.  Pointer to the anchor block for the stack.
       01  ab-ptr                       Pointer.
       
       *>  Input.  Function to be performed.
       01  func                         PIC X(004).
           88  func-push                           Value 'PUSH'.
           88  func-peek                           Value 'PEEK'.
           88  func-pop                            Value 'POP '.
           
       *>  Input or Output.  For the PUSH function this is the item
       *>  to be placed on the stack.  In this case the contents
       *>  remain unchanged.  For the POP and PEEK functions the
       *>  contents of this item will be replaced with the item "on
       *>  top" of the stack.
       01  stack-item.
           05  Occurs 1 To Unbounded 
               Depending stack-item-len
               PIC X(001).
               
       Copy 'STACKAB.cpy'.
           
       *>  The contents of the stack, in its entirety.
       01  stack-items.
           05  Occurs 1 To Unbounded 
               Depending stack-items-len
               PIC X(001).
               
       *>  When necessary, the stack is reallocated and its contents
       *>  copied here.
       01  new-stack-items.
           05  Occurs 1 To Unbounded 
               Depending new-stack-items-len
               PIC X(001).
               
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
           
       *>  The stack grows down.  Normally a stack is thought of
       *>  as having items pushed down on to the top, its just 
       *>  easier to add them to the bottom and keep track of
       *>  where the most current item is.
       1000-Push.
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
           
       *>  The stack has filled the current buffer and is in need
       *>  of reallocation.
       1010-Reallocate.
       *>  Presence of the "On Size Error" phrase ensures that, in
       *>  the case of a size error, the contents of the target
       *>  field remain unchanged.
           Compute new-stack-items-capacity =
             stack-items-capacity + stack-items-increment
             On Size Error Move rc-stack-overflow3 To save-rc
           End-Compute
             
       *>  Presence of the "On Size Error" phrase ensures that, in
       *>  the case of a size error, the contents of the target
       *>  field remain unchanged.
           Compute new-stack-items-len = 
             stack-item-len * new-stack-items-capacity
             On Size Error Move rc-stack-overflow4 To save-rc
           End-Compute

           Allocate
             new-stack-items-len Characters
             Initialized
             Returning new-stack-items-ptr

           Set Address Of new-stack-items To new-stack-items-ptr
           
           *>  Copy the old stack to the new stack.
           Move stack-items              To new-stack-items

           *>  Update the anchor block.
           Move new-stack-items-capacity To stack-items-capacity

           *>  Free the old stack.
           Free stack-items-ptr

           *>  Update the anchor block.
           Move new-stack-items-ptr      To stack-items-ptr
           Move new-stack-items-len      To stack-items-len
           
           *>  Yes, now stack-items and new-stack-items are in fact
           *>  the same data area.  This doesn't cause problems and
           *>  makes the logic in the calling paragraph easier.
           Set Address Of stack-items To stack-items-ptr
           .
           
       *>  Return the item "on top" of the stack.
       *>  It's a long way to go to execute a Move statement, but
       *>  That's really all a PEEK operation does.
       2000-Peek.
           Move stack-items(stack-items-position:stack-item-len)
             To stack-item
           .
           
       *>  Remove the item "on top" of the stack and return it in
       *>  the passed stack-item.
       3000-Pop.
           Perform 2000-Peek

           *>  Removing the item from the stack means we erase its
           *>  contents from the buffer...
           Move Low-Values 
             To stack-items(stack-items-position:stack-item-len)

           *>  ...and decrement the current number of items on the
           *>  stack.
           Subtract 1 From stack-curr-nb-items

           *>  Set the buffer position of the current item "on top"
           *>  of the stack.
           If stack-curr-nb-items = 0
               Move 1 To stack-items-position
           Else
               Subtract stack-item-len From stack-items-position
           End-If
           .
           
