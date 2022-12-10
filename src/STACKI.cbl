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
       *> Prior to using your stack, you must call this module to
       *> allocate storage associated with it.  This includes an
       *> anchor block containing information about your stack.
       *>
       Program-ID. STACKI.
       Environment Division.
       Configuration Section.
       Repository.
          Function All Intrinsic.
       Data Division.
       Working-Storage Section.
       01  constants.
           *>  Eyecatcher.
           05  myname                   PIC X(008)  Value 'STACKI'.
           *>  The stack grows downward in increments of 
           *>  stack-item-len * stack-items-increment.  The number
           *>  10 is arbitrary.
           05  stack-items-increment    PIC 9(009)  Binary Value 10.
           *>  Return code indicating success.
           05  rc-success               PIC S9(004) Binary Value +0.
           
       Linkage Section.
       *>  Output.  Pointer to the anchor block for the stack.
       01  ab-ptr                       Pointer.
       
       *>  Input.  Length of the items to be placed on the stack.
       01  item-len                     PIC 9(009) Binary.
       
       Copy 'STACKAB.cpy'.
                  
       Procedure Division Using
             ab-ptr
             item-len
           .
       
           Allocate 
             Length(ab) Characters 
             Initialized 
             Returning ab-ptr
             
           Set Address Of ab To ab-ptr
           
           Move stack-items-increment To stack-items-capacity
           Move item-len              To stack-item-len
           
           Compute stack-items-len = 
             stack-item-len * stack-items-capacity
             
           Allocate
             stack-items-len Characters
             Initialized
             Returning stack-items-ptr
        
           Move item-len   To stack-item-len
           Move 0          To stack-curr-nb-items
           Move 1          To stack-items-position
           Move rc-success To Return-Code
           Goback.
           

