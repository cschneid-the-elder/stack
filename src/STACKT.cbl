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
           05  myname                   PIC X(008) Value 'STACKT'.
           05  stack-items-increment    PIC 9(009)  Binary Value 10.
           05  rc-success               PIC S9(004) Binary Value +0.
           05  rc-stack-empty           PIC S9(004) Binary Value +4.
           05  rc-bad-func              PIC S9(004) Binary Value +8.
           
       01  work-areas.
           05  new-stack-items-ptr      Pointer            Value NULL.
           05  new-stack-items-len      PIC 9(009) Binary  Value 0.
           05  new-stack-items-capacity PIC 9(009) Binary  Value 0.
           
       Linkage Section.
       01  ab-ptr                       Pointer.
       
       01  ab.
           05  stack-item-len           PIC 9(009) Binary.
           05  stack-items-len          PIC 9(009) Binary.
           05  stack-curr-nb-items      PIC 9(009) Binary.
           05  stack-items-capacity     PIC 9(009) Binary.
           05  stack-items-position     PIC 9(009) Binary.
           05  stack-items-ptr          Pointer.
           
       Procedure Division Using
             ab-ptr
           .
           
           Set Address Of ab To ab-ptr
           Free stack-items-ptr
           Free ab-ptr
           
           Set ab-ptr To NULL
           
           Move rc-success To Return-Code
           Goback.

