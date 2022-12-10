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
       *> When you are done with your stack, it is important to call
       *> this module to free the memory associated with it.
       *>
       Program-ID. STACKT.
       Environment Division.
       Configuration Section.
       Repository.
          Function All Intrinsic.
       Data Division.
       Working-Storage Section.
       01  constants.
           *>  Eyecatcher.
           05  myname                   PIC X(008) Value 'STACKT'.
           *>  Return code indicating success.
           05  rc-success               PIC S9(004) Binary Value +0.
           
       Linkage Section.
       *>  Input and Output.  
       01  ab-ptr                       Pointer.
       
       Copy 'STACKAB.cpy'.
           
       *>  The contents of the stack, in its entirety.
       01  stack-items.
           05  Occurs 1 To Unbounded 
               Depending stack-items-len
               PIC X(001).
               
       Procedure Division Using
             ab-ptr
           .
           
           Set Address Of ab To ab-ptr
           Set Address of stack-items To stack-items-ptr
           Move Low-Values to stack-items
           Free stack-items-ptr
           Move Low-Values To ab
           Free ab-ptr
           
           Set ab-ptr To NULL
           
           Move rc-success To Return-Code
           Goback.

