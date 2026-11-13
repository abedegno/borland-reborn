// modtest: -ml -O -G
// C++ classes: constructors, destructors, copy constructors and assignment (written and
// generated), virtual functions, multiple and virtual inheritance, static members, global
// objects with constructors, arrays of objects, new and delete.
class Base {
public:
    Base() : value(0) { ++count; }
    Base(int v) : value(v) { ++count; }
    Base(const Base &b) : value(b.value) { ++count; }
    virtual ~Base() { --count; }
    virtual int area() const { return value; }
    virtual int scale(int k) { value *= k; return value; }
    static int count;
protected:
    int value;
};
int Base::count = 0;

class Named {
public:
    Named(const char *n = "none") : name(n) {}
    const char *label() const { return name; }
private:
    const char *name;
};

class Square : public Base, public Named {
public:
    Square(int side) : Base(side * side), Named("square"), side(side) {}
    int area() const { return side * side; }
    int scale(int k) { side *= k; return Base::scale(k * k); }
private:
    int side;
};

class Shared : public virtual Base { public: Shared() : Base(3) {} int get() { return value; } };
class Left : public virtual Shared { public: int l; Left() : l(1) {} };
class Right : public virtual Shared { public: int r; Right() : r(2) {} };
class Diamond : public Left, public Right {
public:
    Diamond() {}
    int sum() { return l + r + get(); }
};

struct Plain { int a, b; long c; };    // generated copy and assignment
struct Holder { Plain p; Base b; Named n; };

Square global_square(4);
Base global_bases[3];
Holder global_holder;

int use(Base &b, const Square &s)
{
    Base copy = b;
    Square other = s;
    other = s;
    Plain p1 = { 1, 2, 3 }, p2;
    p2 = p1;
    Holder h = global_holder;
    h = global_holder;
    Base *heap = new Square(5);
    int r = heap->area() + copy.area() + other.scale(2) + p2.a + h.p.b;
    delete heap;
    Base *many = new Base[4];
    r += many[2].area();
    delete [4] many;     // Borland C++ 2.0 wants the count (it has no delete [])
    Diamond d;
    r += d.sum();
    return r + Base::count + global_square.area() + global_bases[1].area();
}
