// modtest: -ml -O
// modes: -S
// Inline assembly in C++: the C++ front end has its own encoder for C names (ASMENC2.C):
// globals, locals, class members selected with '.', and a jump to a C label from asm code.
// (Enumeration constants fail in C++ asm: ASMENUM.CPP.)
struct Point { int x, y; long tag; };
class Box { public: int width; Point corner; int area() const; };
Point origin;
int Box::area() const
{
    int w = width;
    asm mov ax, w
    asm mov bx, word ptr origin.y
    asm add ax, bx
    asm mov w, ax
    return w * corner.x;
}
int run(Box &b, int n)
{
    int count = n;
    asm mov cx, count
    asm add cx, 7
    asm les bx, b
    asm mov ax, es:[bx].width
    asm cmp ax, 3
    asm jl finish
    asm mov count, cx
finish:
    return count + origin.x;
}
