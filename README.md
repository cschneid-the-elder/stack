## Stack Implementation in COBOL

COBOL does not have a native stack implementation.  It has tables (arrays), which can be used to simulate a stack, but it turns out that simulating stack functionality requires more work than you'd think.

Being lazy, I've attempted to implement generic stack functionality for fixed-length items so I don't have to re-implement it every time I need it.  Nor do you.

## Structure

Functionality is implemented across four subroutines, STACKI, STACKN, STACKP, and STACKT.

| Routine | Function |
| ------- | -------- |
| STACKI | Initialization.  Storage for an anchor block and the initial stack is allocated. |
| STACKN | Returns the number of items currently on the stack. |
| STACKP | PUSH, POP, and PEEK processing. |
| STACKT | Termination.  Storage for the anchor block and the stack is freed. |

## Use

Begin by calling STACKI with the address of a data item with usage pointer and another PIC 9(009) Binary data item containing the length of the items you wish to stack.

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
           
Now you can begin pushing items on to your stack by calling STACKP.

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
           
You can see how many items are on the stack by calling STACKN.

           Call stack-num Using
             stack-ab-ptr
             stack-nb-items
           End-Call
           
           Display 'stack-nb-items = ' stack-nb-items
           
This would display `stack-nb-items = 000000001`

Add another item to the stack...

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

...and check the size of the stack...

           Call stack-num Using
             stack-ab-ptr
             stack-nb-items
           End-Call
           
           Display 'stack-nb-items = ' stack-nb-items
           
This would display `stack-nb-items = 000000002`

Peek at the current top of the stack...

           Move Spaces to stack-item
           
           Call stack-process Using
             stack-ab-ptr
             stack-process-peek
             stack-item
           End-Call
           
           Evaluate Return-Code
             When Zero
                  Display '(peek) stack-item = ' stack-item
             When 4
                  Display '(peek) stack is empty'
             When Other
                  Display '(peek) Return-Code = ' Return-Code
           End-Evaluate

...and you see `(peek) stack-item = Rush`

Popping items off the stack...

           Move Spaces to stack-item
           
           Call stack-process Using
             stack-ab-ptr
             stack-process-pop
             stack-item
           End-Call
           
           Display '(pop) stack-item = ' stack-item
           
...and again you see `(peek) stack-item = Rush`

           Call stack-num Using
             stack-ab-ptr
             stack-nb-items
           End-Call
           
           Display 'stack-nb-items = ' stack-nb-items

This would now display `stack-nb-items = 000000001`

When you're done with your stack...

           Call stack-term Using
             stack-ab-ptr
           End-Call

...to release storage.

