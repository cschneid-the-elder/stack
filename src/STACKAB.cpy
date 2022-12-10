       *> Copyright (C) 2022 Craig Schneiderwent, All rights reserved
       *> This software may be modified and distributed under the terms
       *> of the MIT license. See the LICENSE file for details.
       *> 
       *> This is the anchor block for the stack.  Private.
       01  ab.
           *>  Length of each individual item on the stack.
           05  stack-item-len           PIC 9(009) Binary.
           *>  Length of the buffer representing the stack.
           05  stack-items-len          PIC 9(009) Binary.
           *>  Current number of items on the stack.
           05  stack-curr-nb-items      PIC 9(009) Binary.
           *>  Maximum number of stack items the buffer can hold.
           05  stack-items-capacity     PIC 9(009) Binary.
           *>  Position in the buffer of the item "on top" of the stack.
           05  stack-items-position     PIC 9(009) Binary.
           *>  Pointer to the buffer representing the stack.
           05  stack-items-ptr          Pointer.

