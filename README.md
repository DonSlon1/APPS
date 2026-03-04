# APPS
nasm -f elf64 -g -F dwarf asm.asm -o asm.o && gcc -g -c main.c -o main.o && gcc -g main.o asm.o -o main

### ⌨️ 2. TUI & Navigation Shortcuts

How to move around without breaking the UI.

| Goal | Command / Shortcut |
| --- | --- |
| **Fix garbled screen output** | `Ctrl + L` (or type `refresh`) |
| **Switch scrolling window** | `focus next` (Cycles through source, assembly, etc.) |
| **Scroll command history** | `Ctrl + P` (Up), `Ctrl + N` (Down), or `focus cmd` |
| **Repeat last command** | Just press `Enter` on an empty line |
| **View Registers** | `layout regs` (then `tui reg general` or `float`) |

---

### 🛑 3. Controlling Execution

How to stop and skip through your code.

| Goal | Command / Code |
| --- | --- |
| **Hardcode a breakpoint in C** | `__builtin_trap();` (GCC/Clang) or `raise(SIGTRAP);` |
| **Step OVER a function** | `next` (`n`) |
| **Step INTO a function** | `step` (`s`) |
| **Run until current func ends** | `finish` |
| **Ignore breakpoint X times** | `ignore [ID] [Count]` (e.g., `ignore 1 50`) |

---

### 🔍 4. Reading Memory & Arrays

How to read the raw bytes or cast them into arrays.

| Scenario | Command Syntax | Example |
| --- | --- | --- |
| **Examine Raw Memory (`x`)** | `x/[Count][Format][Size] $[Reg]` | `x/10dw $rax` (10 items, Decimal, 4-byte Words) |
| **Read String at Register** | `x/s $[Reg]` | `x/s $rdi` |
| **Print as C-Style Array** | `p *([Type] *)$[Reg] @ [Count]` | `p *(int *)$rax @ 5` |
| **Read `[base+index*scale]**` | Translate to `($base + $index * 4)` | `x/1dw ($rsi + $r9 * 4)` |

---

### ⚠️ 5. Assembly "Gotchas" (x86-64)

The traps we found in your code and how to fix them.

**Multiplication (`mul` vs `imul`)**

* **Signed Math (`imul`):** Takes two operands. `imul r8, r9` saves the result into `r8`.
* **Unsigned Math (`mul`):** Takes *one* operand. `mul r9` multiplies `r9` by `rax` and splits the giant answer into `rdx` (high) and `rax` (low).

**Division Exceptions (`div`)**

If you divide a 32-bit number (like `div r8d`), the CPU actually divides the glued-together `edx:eax` pair.

* **The Bug:** If `edx` has garbage data, it creates a massive number that causes an Arithmetic (Quotient Overflow) Exception.
* **The Fix:** Always zero out the high register right before dividing:
```assembly
xor edx, edx   ; Zero out the high half!
mov eax, r10d  ; Move your number into the low half
div r8d        ; Divide safely

```



---

You have a really solid grasp on looking at memory and registers now. Would you like me to finally show you how to set up a **conditional breakpoint** (e.g., `break 42 if r9 == 50`) so you can debug your prime number loop without hitting continue a hundred times?
