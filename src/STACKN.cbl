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
       Program-ID. STACKN.
       Environment Division.
       Configuration Section.
       Repository.
          Function All Intrinsic.
       Data Division.
       Working-Storage Section.
       01  constants.
           *>  Eyecatcher.
           05  myname                   PIC X(008) Value 'STACKN'.
           *>  Return code indicating success.
           05  rc-success               PIC S9(004) Binary Value +0.
           
       Linkage Section.
       *>  Input.  Pointer to the anchor block for the stack.
       01  ab-ptr                       Pointer.
       
       *>  Output.  Number of items currently on the stack.
       01  nb-items                     PIC 9(009) Binary.
       
       Copy 'STACKAB.cpy'.
           
       Procedure Division Using
             ab-ptr
             nb-items
           .
           
           Set Address Of ab To ab-ptr

           *> This may seem like a long way to go just to execute
           *> a Move statement, but it keeps the contents of the
           *> anchor block private.
           Move stack-curr-nb-items to nb-items

           *> Note that rc-success is returned even if the stack is
           *> empty.  It seems more logical to indicate success than
           *> to return 0 in the nb-items and also a return code
           *> indicating the stack is empty.
           Move rc-success To Return-Code
           Goback.
           

